package com.example.demo.security.auth;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.example.demo.mapper.UserMapper;


/**
 * this later would be injected as a bean so that it can be used by UsernamePasswordAuthenticationFilter
 * @author ganpeng1
 *
 */
public class CustomizedUserAuthentication implements UserDetailsService  {
	
	@Autowired
	private UserMapper mapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//Standard validation
//		UserInfo userInfo=mapper.findUserInfoByUsername(username);
//		if(userInfo==null) return null;
//		List<String> authorities=mapper.findUserAuthorites(username);
//		List<SimpleGrantedAuthority> simpleAuthorities =new ArrayList<SimpleGrantedAuthority>();
//		for(String authority: authorities){
//			simpleAuthorities.add(new SimpleGrantedAuthority(authority));
//		}
//		return new CustomizedUserDetailsBean(username,userInfo.getPassword(),simpleAuthorities,userInfo.isEnabled());
		
		String[] authorities=new String[]{"USER"};
		List<SimpleGrantedAuthority> simpleAuthorities =new ArrayList<SimpleGrantedAuthority>();
		for(String authority: authorities){
			simpleAuthorities.add(new SimpleGrantedAuthority(authority));
		}
		return new CustomizedUserDetailService("teda","teda",simpleAuthorities,true,true,true);
	}

}
