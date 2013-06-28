package com.mxk.org.web.user.domain;

import com.mxk.org.common.util.SecurityUtil;

public class UserLoginRequest {
  
	private String loginName;
	private String loginPass;
	
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getLoginPass() {
		return loginPass;
	}
	public void setLoginPass(String loginPass) {
		this.loginPass = SecurityUtil.digestByMd5(loginPass);
	}
	
	
	
}
