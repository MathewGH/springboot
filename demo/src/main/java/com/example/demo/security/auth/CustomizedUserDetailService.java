package com.example.demo.security.auth;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomizedUserDetailService implements UserDetails{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String username;
	private String password;
	private Collection<? extends GrantedAuthority> authorities;
	private boolean enabled;
	private boolean isLocked;
	private boolean isExpired;
	
	public CustomizedUserDetailService(String username,String password,Collection<? extends GrantedAuthority> authorities,boolean enabled,boolean isLocked,boolean isExpired){
		this.username=username;
		this.password=password;
		this.authorities=authorities;
		this.enabled=enabled;
		this.isLocked=isLocked;
		this.isExpired=isExpired;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return password;
	}

	@Override
	public String getUsername() {
		return username;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return isExpired;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return isLocked;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return enabled;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
