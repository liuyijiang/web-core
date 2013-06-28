package com.mxk.org.web.part.domain;

public class SearchPartRequest {

	private String subjectid;
	private String userid;
	private String type;
	private int page;
	
	public SearchPartRequest(){
		
	}
	
	public SearchPartRequest(String userid,String subjectid, String type, int page) {
		this.userid = userid;
		this.subjectid = subjectid;
		this.type = type;
		this.page = page;
	}

	public String getSubjectid() {
		return subjectid;
	}

	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	
	
}
