package com.example.demo.security.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import com.example.demo.security.auth.CustomizedUserAuthentication;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	
//	@Autowired
//	private DataSource dataSource;
	
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
            .authorizeRequests()
                .antMatchers("/home").permitAll()
                .anyRequest().authenticated()
                .and()
            .formLogin()
                .loginPage("/login")
                .failureUrl("/loginFailed")
                .successForwardUrl("/loginSuccess")
                .permitAll()
                .and()
            .logout()
            .logoutSuccessUrl("/logoutSuccess")
            .permitAll();
    }

//    @Autowired
//    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//    	auth
//		.inMemoryAuthentication()
//			.withUser("user").password("password").roles("USER");
//    }
    
    @Bean
    public CustomizedUserAuthentication customizedUserAuthentication() {
    	return new CustomizedUserAuthentication();
    }

}