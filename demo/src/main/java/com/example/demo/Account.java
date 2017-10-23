/*
 * Copyright 2012-2014 the original author or authors.
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

import java.sql.Timestamp;

public class Account {

	private String tokenid;
	private String request_sys;
	private Timestamp exception_tm;
	private String error_msg;
	private String userid;

	public String getTokenid() {
		return tokenid;
	}
	public void setTokenid(String tokenid) {
		this.tokenid = tokenid;
	}
	public String getRequest_sys() {
		return request_sys;
	}
	public void setRequest_sys(String request_sys) {
		this.request_sys = request_sys;
	}
	public Timestamp getException_tm() {
		return exception_tm;
	}
	public void setException_tm(Timestamp exception_tm) {
		this.exception_tm = exception_tm;
	}
	public String getError_msg() {
		return error_msg;
	}
	public void setError_msg(String error_msg) {
		this.error_msg = error_msg;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}

}
