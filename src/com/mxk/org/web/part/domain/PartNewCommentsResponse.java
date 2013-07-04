package com.mxk.org.web.part.domain;

import java.util.List;

import com.mxk.org.entity.CommentEntity;

public class PartNewCommentsResponse {
   
	public List<CommentEntity> list;

	public List<CommentEntity> getList() {
		return list;
	}

	public void setList(List<CommentEntity> list) {
		this.list = list;
	}
	
	
}
