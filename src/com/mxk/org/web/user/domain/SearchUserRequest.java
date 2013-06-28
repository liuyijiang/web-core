package com.mxk.org.web.user.domain;

public class SearchUserRequest {
  
	private String parm; //可以是名字 id
	private int page;
	private Long all;
	private boolean follower;
	
	public String getParm() {
		return parm;
	}
	public void setParm(String parm) {
		this.parm = parm;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public Long getAll() {
		return all;
	}
	public void setAll(Long all) {
		this.all = all;
	}
	public boolean isFollower() {
		return follower;
	}
	public void setFollower(boolean follower) {
		this.follower = follower;
	}
    	
	
	
}
