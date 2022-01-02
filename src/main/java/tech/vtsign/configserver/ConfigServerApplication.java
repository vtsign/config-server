package tech.vtsign.configserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.config.server.EnableConfigServer;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableConfigServer
@EnableEurekaClient
public class ConfigServerApplication {

    public static void main(String[] args) {
        System.getenv().forEach((k, v) -> System.out.println(k + "=" + v));
        System.out.println("===========================");
        System.out.println(System.getProperty("spring.cloud.config.server.git.uri"));
        System.out.println(System.getProperty("spring.cloud.config.server.git.privateKey"));
        SpringApplication.run(ConfigServerApplication.class, args);
    }

}
