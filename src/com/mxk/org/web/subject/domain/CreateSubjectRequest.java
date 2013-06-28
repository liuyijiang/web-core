package com.mxk.org.web.subject.domain;

public class CreateSubjectRequest {
	
	private String name;
	private String info;
	private String type;
	private String userid;
	private String faceiamge;
	private String tags;//
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getFaceiamge() {
		return faceiamge;
	}
	public void setFaceiamge(String faceiamge) {
		this.faceiamge = faceiamge;
	}
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	
	
}
