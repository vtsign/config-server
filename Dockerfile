FROM adoptopenjdk/openjdk11:jdk-11.0.11_9-alpine as base

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./

RUN chmod +x ./mvnw
RUN ./mvnw dependency:go-offline

COPY src ./src

#FROM base as test
#CMD ["./mvnw", "test"]
#
#FROM base as development
#CMD ["./mvnw", "spring-boot:run", "-Dspring-boot.run.profiles=mysql", "-Dspring-boot.run.jvmArguments='-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000'"]

FROM base as build
RUN ./mvnw package -Dmaven.test.skip=true

FROM adoptopenjdk/openjdk11:jre-11.0.11_9-alpine as production
WORKDIR /app

EXPOSE 8888
COPY --from=build /app/target/*.jar ./
ENV GH_REPO=repo
ENV GH_USERNAME=username
ENV GH_PASSWORD=passwordortoken
ENV PORT=8888
ENV EUREKA_SERVER_URL=http://localhost:8761/eureka/
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/config-server.jar"]
