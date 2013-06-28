package com.mxk.org.entity;

import java.io.Serializable;

/**
 * �û���ע�� ר��
 * @author liuyijiang
 *
 */
public class UserRssSubjectEntity implements Serializable {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = 5581530515892177364L;
	private String id;
	private String userid;
	private String username;//����
	private String userimage;//����
	private String userdesc;//����
	private String subjectid;
	private String subjectOwnerId;
	private String ceateTime;
	
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
	public String getCeateTime() {
		return ceateTime;
	}
	public void setCeateTime(String ceateTime) {
		this.ceateTime = ceateTime;
	}
	public String getSubjectOwnerId() {
		return subjectOwnerId;
	}
	public void setSubjectOwnerId(String subjectOwnerId) {
		this.subjectOwnerId = subjectOwnerId;
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
	public String getUserdesc() {
		return userdesc;
	}
	public void setUserdesc(String userdesc) {
		this.userdesc = userdesc;
	}
	
}
