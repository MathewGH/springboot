package com.example.demo.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class SsoLogNew implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8726842714165119688L;
	private String tokenid;
	private String request_Sys;
	private Timestamp exception_tm;
	private String error_msg;
	private String userid;

	public String getTokenid() {
		return tokenid;
	}

	public void setTokenid(String tokenid) {
		this.tokenid = tokenid;
	}


	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getRequest_Sys() {
		return request_Sys;
	}

	public void setRequest_Sys(String request_Sys) {
		this.request_Sys = request_Sys;
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


}
