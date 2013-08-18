package com.mxk.org.web.comments.domain;

import java.util.List;

import com.mxk.org.entity.UserPointEntity;

public class PointInfoResponse {

	private long allpage;
	private List<UserPointEntity> list;
	
	public long getAllpage() {
		return allpage;
	}
	public void setAllpage(long allpage) {
		this.allpage = allpage;
	}
	public List<UserPointEntity> getList() {
		return list;
	}
	public void setList(List<UserPointEntity> list) {
		this.list = list;
	}
	
	
}
