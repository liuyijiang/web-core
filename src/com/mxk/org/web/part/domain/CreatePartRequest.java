package com.mxk.org.web.part.domain;

public class CreatePartRequest {
   
	private String subjectid;
	private String desc;
	private String type;//继承subject 
	private String subname;
	private String userid;
	private int forfaceimage;
	
	private String username;//冗余 用户名称
	private String userimage;//冗余 用户头像
	private String status;
	
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSubname() {
		return subname;
	}
	public void setSubname(String subname) {
		this.subname = subname;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getForfaceimage() {
		return forfaceimage;
	}
	public void setForfaceimage(int forfaceimage) {
		this.forfaceimage = forfaceimage;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserimage() {
		return userimage;
	}
	public void setUserimage(String userimage) {
		this.userimage = userimage;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
