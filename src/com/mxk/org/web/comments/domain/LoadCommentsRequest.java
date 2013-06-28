package com.mxk.org.web.comments.domain;

public class LoadCommentsRequest {
   
	private String targeid;
	private int page;
	private String type;//text or wav;
	
	public String getTargeid() {
		return targeid;
	}
	public void setTargeid(String targeid) {
		this.targeid = targeid;
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
	
	
	
}
