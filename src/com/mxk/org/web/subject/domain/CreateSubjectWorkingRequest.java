package com.mxk.org.web.subject.domain;

public class CreateSubjectWorkingRequest {

	private String id;
	private String userid;
	private String subjectid;
	private double plan;//进度
	private String doc;//记录[2012-12-12:12:21:23]wadawdaddawda  格式
	private String createTime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}
	public double getPlan() {
		return plan;
	}
	public void setPlan(double plan) {
		this.plan = plan;
	}
	public String getDoc() {
		return doc;
	}
	public void setDoc(String doc) {
		this.doc = doc;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
   	
}
