package com.example.demo.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class SsoLog implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8726842714165119688L;
	private String tokenid;
	private String requestSys;
	private Timestamp exceptionTime;
	private String errorMsg;
	private String userid;

	public String getTokenid() {
		return tokenid;
	}

	public void setTokenid(String tokenid) {
		this.tokenid = tokenid;
	}

	public String getRequestSys() {
		return requestSys;
	}

	public void setRequestSys(String requestSys) {
		this.requestSys = requestSys;
	}


	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public Timestamp getExceptionTime() {
		return exceptionTime;
	}

	public void setExceptionTime(Timestamp exceptionTime) {
		this.exceptionTime = exceptionTime;
	}

}
