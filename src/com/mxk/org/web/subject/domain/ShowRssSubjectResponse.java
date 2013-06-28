package com.mxk.org.web.subject.domain;

import java.util.List;

import com.mxk.org.entity.UserRssSubjectEntity;

public class ShowRssSubjectResponse {
    
	private int page;
	private List<UserRssSubjectEntity> list;
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public List<UserRssSubjectEntity> getList() {
		return list;
	}
	public void setList(List<UserRssSubjectEntity> list) {
		this.list = list;
	}
	
	
}
