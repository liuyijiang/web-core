package com.mxk.org.web.comments.domain;

import java.util.List;

import com.mxk.org.entity.UserGiftEntity;

public class GiftInfoResponse {
   
	private long allpage;
	private List<UserGiftEntity> list;
	
	public List<UserGiftEntity> getList() {
		return list;
	}
	public void setList(List<UserGiftEntity> list) {
		this.list = list;
	}
	public long getAllpage() {
		return allpage;
	}
	public void setAllpage(long allpage) {
		this.allpage = allpage;
	}
	
	
	
}
