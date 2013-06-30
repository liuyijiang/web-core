package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * 用户关注的 专题
 * @author liuyijiang
 *
 */
@Document
public class UserRssSubjectEntity implements Serializable {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = 5581530515892177364L;
	@Id
	private String id;
	private String userid;
	private String username;//冗余
	private String userimage;//冗余
	private String userdesc;//冗余
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
