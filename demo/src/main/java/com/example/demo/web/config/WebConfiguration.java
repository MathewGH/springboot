package com.example.demo.web.config;

import java.util.Locale;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
@Configuration
@ComponentScan("com.example.demo.controller")
//@EnableWebMvc
/**
 * 27.1.1 Spring MVC auto-configuration

Spring Boot provides auto-configuration for Spring MVC that works well with most applications.

The auto-configuration adds the following features on top of Spring’s defaults:

Inclusion of ContentNegotiatingViewResolver and BeanNameViewResolver beans.
Support for serving static resources, including support for WebJars (see below).
Automatic registration of Converter, GenericConverter, Formatter beans.
Support for HttpMessageConverters (see below).
Automatic registration of MessageCodesResolver (see below).
Static index.html support.
Custom Favicon support (see below).
Automatic use of a ConfigurableWebBindingInitializer bean (see below).
If you want to keep Spring Boot MVC features, and you just want to add additional MVC configuration (interceptors, formatters, view controllers etc.)
 you can add your own @Configuration class of type WebMvcConfigurer, but without @EnableWebMvc. 
 If you wish to provide custom instances of RequestMappingHandlerMapping, 
 RequestMappingHandlerAdapter or ExceptionHandlerExceptionResolver you can declare a WebMvcRegistrationsAdapter instance providing such components.

If you want to take complete control of Spring MVC, you can add your own @Configuration annotated with @EnableWebMvc.


 * @author ganpeng1
 *
 */
public class WebConfiguration extends WebMvcConfigurerAdapter {
//	@Bean
//	public InternalResourceViewResolver viewResolver() {
//		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
//		resolver.setPrefix("/pages/program/");
//		resolver.setSuffix(".jsp");
//		return resolver;
//	}
//	@Bean
//	public MessageSource messageSource() {
//		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
////		messageSource.setBasename("/i18n/usermsg");
////		messageSource.setDefaultEncoding("UTF-8");
//		return messageSource;
//	}
	@Bean
	//
	//equals to 
	//<bean name="localeResolver" class="org.springframework.web.servlet.LocaleResolver">
	//<property name="defaultLocale"><value>en_US</value></property></bean>          
    //
	public LocaleResolver localeResolver() {
		CookieLocaleResolver resolver = new CookieLocaleResolver();
		resolver.setDefaultLocale(new Locale("en_US"));
		resolver.setCookieName("myLocaleCookie");
		resolver.setCookieMaxAge(4800);
		return resolver;
	}
	
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/login").setViewName("login");
	}
	
//	@Bean(name="myLocaleResolver")
	//
	//equals to 
	//<bean name="myLocaleResolver" class="org.springframework.web.servlet.LocaleResolver"/>
	//          
    //
//	public LocaleResolver myResolver(){
//		SessionLocaleResolver resolver=new SessionLocaleResolver();
//		resolver.setLocale(request, response, locale);
//		
//	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		LocaleChangeInterceptor interceptor = new LocaleChangeInterceptor();
		//interceptor.setParamName("lang");
		registry.addInterceptor(interceptor);
	}

}
