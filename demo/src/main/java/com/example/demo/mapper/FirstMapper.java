package com.example.demo.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import com.example.demo.domain.SsoLog;
import com.example.demo.domain.SsoLogNew;

@Mapper
public interface FirstMapper {

	@Select("select * from sso_log where tokenid=#{tokenid} ")
	@Results({@Result(property = "requestSys", column = "request_sys"),
		      @Result(property = "exceptionTime", column = "exception_tm"),
	          @Result(property="errorMsg", column="error_msg")
	        })
	List<SsoLog> findLogByTokenid(@Param("tokenid") String tokenid);

	@Select("select * from sso_log where tokenid=#{tokenid} ")
	List<SsoLogNew> findLogByTokenidOldVersion(@Param("tokenid") String tokenid);

}
