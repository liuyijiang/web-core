package com.mxk.org.web.subject.domain;

public class SearchSubjectRequest {
   
	private String useid;
	private String type;
	private int page;
	
	public SearchSubjectRequest(){
		
	}
	
	public SearchSubjectRequest(String useid, String type, int page) {
		this.useid = useid;
		this.type = type;
		this.page = page;
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
	public String getUseid() {
		return useid;
	}
	public void setUseid(String useid) {
		this.useid = useid;
	}
	
	
	
}
