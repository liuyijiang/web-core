package com.mxk.org.web.comments.domain;

public class SetPointRequest {
   
	private String trageUserId;
	private String tragetid;
	private String trageType;
	private int point;
	
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
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getTrageUserId() {
		return trageUserId;
	}
	public void setTrageUserId(String trageUserId) {
		this.trageUserId = trageUserId;
	}
	
	
	
}
