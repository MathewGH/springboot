/*
 * Copyright 2012-2016 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.example.demo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.example.demo.domain.SsoLog;
import com.example.demo.mapper.FirstMapper;

@Service
public class AccountService {


	@Autowired
    private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private FirstMapper mapper;
//	@Autowired
//	private MybatisDao dao;

	@Bean
    public List<Account> getList(){
        String sql = "SELECT tokenid FROM sso_log";
        //this.jdbcTemplate.execute("call p_create_student_test('123')");    
        return (List<Account>) jdbcTemplate.query(sql, new RowMapper<Account>(){

            @Override
            public Account mapRow(ResultSet rs, int rowNum) throws SQLException {
            	Account stu = new Account();
                stu.setTokenid(rs.getString("tokenid"));
                return stu;
            }

        });
    }
	
	public SsoLog getSsoLogDev(String tokenid){
		return mapper.findLogByTokenid(tokenid).get(0);
	}
	
//	public SsoLog getSsoLog(){
//		return dao.selectCityById("mathewtest").get(0);
//	}
	
	public SsoLog getSsoLogNew(){
		return mapper.findLogByTokenid("cOJLWl3VMqg").get(0);
	}
}
