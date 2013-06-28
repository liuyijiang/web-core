package com.mxk.org.web.visitor.domain;

public class VisitorSeeSubjectDashBoardRequest {
   
	private String parm;
	private String type; // 是所有 还是只显示type是For-all的
	private int page;
	private String tags;
	
	public String getParm() {
		return parm;
	}
	public void setParm(String parm) {
		this.parm = parm;
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
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	
	
	
}
