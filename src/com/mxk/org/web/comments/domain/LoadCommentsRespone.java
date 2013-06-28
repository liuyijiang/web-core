package com.mxk.org.web.comments.domain;

import java.util.List;

import com.mxk.org.entity.CommentEntity;

public class LoadCommentsRespone {
  
	private List<CommentEntity> list;

	public List<CommentEntity> getList() {
		return list;
	}

	public void setList(List<CommentEntity> list) {
		this.list = list;
	}
	
	
	
}
