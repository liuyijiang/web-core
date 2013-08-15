package com.mxk.org.web.comments.domain;

import java.util.List;

import com.mxk.org.entity.UserLikeEntity;

public class LikeInfoResponse {

	private long allpage;
	private List<UserLikeEntity> list;
	public long getAllpage() {
		return allpage;
	}
	public void setAllpage(long allpage) {
		this.allpage = allpage;
	}
	public List<UserLikeEntity> getList() {
		return list;
	}
	public void setList(List<UserLikeEntity> list) {
		this.list = list;
	}
	
	
	
}
