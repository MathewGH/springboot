package com.example.demo;

import org.apache.ibatis.session.Configuration;
import org.mybatis.spring.boot.autoconfigure.ConfigurationCustomizer;
import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.boot.context.event.ApplicationEnvironmentPreparedEvent;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Bean;


//@SpringBootApplication
public class Example {
	
	@SuppressWarnings("rawtypes")
	public static void main(String[] args) throws Exception {
//        SpringApplication.run(Example.class, args);
        SpringApplication app = new SpringApplication(Example.class);
        app.setBannerMode(Banner.Mode.CONSOLE);
        app.setWebEnvironment(true);
        /**
         * Application events are sent in the following order, as your application runs:

An ApplicationStartingEvent is sent at the start of a run, but before any processing except the registration of listeners and initializers.
An ApplicationEnvironmentPreparedEvent is sent when the Environment to be used in the context is known, but before the context is created.
An ApplicationPreparedEvent is sent just before the refresh is started, but after bean definitions have been loaded.
An ApplicationReadyEvent is sent after the refresh and any related callbacks have been processed to indicate the application is ready to service requests.
An ApplicationFailedEvent is sent if there is an exception on startup.
         */
        app.addListeners(new ApplicationListener(){
			@Override
			public void onApplicationEvent(ApplicationEvent event) {
				if(event instanceof ApplicationEnvironmentPreparedEvent){
					System.out.println("do something");
				}
			}
        	
        });
        app.run(args);
    }
//	
//	@Bean
//	ConfigurationCustomizer mybatisConfigurationCustomizer() {
//	    return new ConfigurationCustomizer() {
//	        @Override
//	        public void customize(Configuration configuration) {
//	            // customize ...
//	        }
//	    };
//	}

}