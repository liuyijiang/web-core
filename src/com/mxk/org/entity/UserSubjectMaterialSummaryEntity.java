package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;

public class UserSubjectMaterialSummaryEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8544061279438918651L;
    
	@Id
	private String id;
	private String subjectId;
	private String userid;
	private String dowmloadExl;
	private String createTime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDowmloadExl() {
		return dowmloadExl;
	}
	public void setDowmloadExl(String dowmloadExl) {
		this.dowmloadExl = dowmloadExl;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	
	
}
