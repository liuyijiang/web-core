package com.mxk.org.web.user.domain;

import java.util.List;

import com.mxk.org.entity.UserGiftEntity;

public class UserGiftResponse {
   
	private int page;
	private List<UserGiftEntity> list;
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public List<UserGiftEntity> getList() {
		return list;
	}
	public void setList(List<UserGiftEntity> list) {
		this.list = list;
	}
	
	
}
