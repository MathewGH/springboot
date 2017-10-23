package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.UserInfo;

@Mapper
public interface UserMapper {

	
	@Select("select * from user_info where username=#{username}")
	UserInfo findUserInfoByUsername(String username);
	
	@Select("select authority from user_authority where username=#{username}")
	List<String> findUserAuthorites(String username);
}
