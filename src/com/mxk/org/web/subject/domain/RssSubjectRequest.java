package com.mxk.org.web.subject.domain;

public class RssSubjectRequest {

	private String subjectid;
	private String subjectOwnerId;
	
	private String userid;
	private String username;//����
	private String userimage;//����
	private String userdesc;//����
	
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}
	public String getSubjectOwnerId() {
		return subjectOwnerId;
	}
	public void setSubjectOwnerId(String subjectOwnerId) {
		this.subjectOwnerId = subjectOwnerId;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
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
