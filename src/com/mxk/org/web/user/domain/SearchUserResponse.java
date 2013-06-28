package com.mxk.org.web.user.domain;

import java.util.List;

import com.mxk.org.entity.UserEntity;

public class SearchUserResponse {
   
	private int page;
	private List<UserEntity> list;
	private long all;
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public List<UserEntity> getList() {
		return list;
	}
	public void setList(List<UserEntity> list) {
		this.list = list;
	}
	public long getAll() {
		return all;
	}
	public void setAll(long all) {
		this.all = all;
	}
	
	
	
}
