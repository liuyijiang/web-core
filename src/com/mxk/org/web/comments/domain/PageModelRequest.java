package com.mxk.org.web.comments.domain;

public class PageModelRequest {
  
	private String tragetId;
	private int currentPage;
	private int allPage;
	private int count;
	
	public String getTragetId() {
		return tragetId;
	}
	public void setTragetId(String tragetId) {
		this.tragetId = tragetId;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getAllPage() {
		return allPage;
	}
	public void setAllPage(int allPage) {
		this.allPage = allPage;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	 
	
	
}
