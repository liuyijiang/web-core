package com.mxk.org.web.main.domain;

public class RegisterCheckRequest {
   
	private String parm;
	private String type; //name /email;
	private String currentName;
	
	public String getParm() {
		return parm;
	}
	public void setParm(String parm) {
		this.parm = parm;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCurrentName() {
		return currentName;
	}
	public void setCurrentName(String currentName) {
		this.currentName = currentName;
	}
	
	
	
}
