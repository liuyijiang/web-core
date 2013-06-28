package com.mxk.org.web.user.domain;

public class UserChangePasswordRequest {
   
	private String onepassword;
	private String twopassword;
	private String usermail;
	private String uuid;
	
	public String getOnepassword() {
		return onepassword;
	}
	public void setOnepassword(String onepassword) {
		this.onepassword = onepassword;
	}
	public String getTwopassword() {
		return twopassword;
	}
	public void setTwopassword(String twopassword) {
		this.twopassword = twopassword;
	}
	public String getUsermail() {
		return usermail;
	}
	public void setUsermail(String usermail) {
		this.usermail = usermail;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	
	
}
