package com.mxk.org.web.user.domain;

import java.util.List;

import com.mxk.org.entity.MessageEntity;

public class LoadUserMessageRespone {
   
	private List<MessageEntity> list;
	private int page;
	
	public List<MessageEntity> getList() {
		return list;
	}
	public void setList(List<MessageEntity> list) {
		this.list = list;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	
	
	
}
