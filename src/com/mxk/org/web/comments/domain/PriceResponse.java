package com.mxk.org.web.comments.domain;

import java.util.List;

import com.mxk.org.entity.SubjectPriceEntity;

public class PriceResponse {

	private long allpage;
	private List<SubjectPriceEntity> list;
	public long getAllpage() {
		return allpage;
	}
	public void setAllpage(long allpage) {
		this.allpage = allpage;
	}
	public List<SubjectPriceEntity> getList() {
		return list;
	}
	public void setList(List<SubjectPriceEntity> list) {
		this.list = list;
	}
	
	
	
}
