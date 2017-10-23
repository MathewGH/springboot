package com.example.demo;

import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * 
 * @author ganpeng1
 *
 */
@SpringBootApplication
@EnableDiscoveryClient
//@Import(WebController.class)
public class DeployableWarFile extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(DeployableWarFile.class);
    }

    public static void main(String[] args) throws Exception {
    	   SpringApplication app = new SpringApplication(DeployableWarFile.class);
    	   
    	   // Will configure using demo-server.yml or demo-server.properties
          System.setProperty("spring.config.name", "application");
           
           app.setBannerMode(Banner.Mode.CONSOLE);
           app.setWebEnvironment(true);
           app.run(args);
    }
}
