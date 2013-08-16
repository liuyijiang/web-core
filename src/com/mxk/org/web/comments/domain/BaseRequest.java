package com.mxk.org.web.comments.domain;

public class BaseRequest {
  
	private String trageUserId;
	private String tragetid;
	private String trageType;
	
	public String getTragetid() {
		return tragetid;
	}
	public void setTragetid(String tragetid) {
		this.tragetid = tragetid;
	}
	public String getTrageType() {
		return trageType;
	}
	public void setTrageType(String trageType) {
		this.trageType = trageType;
	}
	public String getTrageUserId() {
		return trageUserId;
	}
	public void setTrageUserId(String trageUserId) {
		this.trageUserId = trageUserId;
	}
	
}
