package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * 
 * @author Administrator
 *
 */
@Document
public class SubjectWorkingEntity implements Serializable {
  
	/**
	 * 
	 */
	private static final long serialVersionUID = 6399787607431123149L;
	
	@Id
	private String id;
	private String userid;
	private String subjectid;
	private double plan;//进度
	private String doc;//记录[2012-12-12:12:21:23]wadawdaddawda ,格式
	private String createTime;//[2012-12-11 00:00:00]
	
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
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getDoc() {
		return doc;
	}
	public void setDoc(String doc) {
		this.doc = doc;
	}
	
	
}
