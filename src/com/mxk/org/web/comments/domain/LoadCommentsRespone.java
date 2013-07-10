package com.mxk.org.web.comments.domain;

import java.util.List;

import com.mxk.org.entity.CommentEntity;

public class LoadCommentsRespone {
	
	private long allpage;
	private List<CommentEntity> list1;
	private List<CommentEntity> list2;
	private List<CommentEntity> list3;
	private List<CommentEntity> list4;
	
	private List<CommentEntity> listAll;
	
	public List<CommentEntity> getList1() {
		return list1;
	}
	public void setList1(List<CommentEntity> list1) {
		this.list1 = list1;
	}
	public List<CommentEntity> getList2() {
		return list2;
	}
	public void setList2(List<CommentEntity> list2) {
		this.list2 = list2;
	}
	public List<CommentEntity> getList3() {
		return list3;
	}
	public void setList3(List<CommentEntity> list3) {
		this.list3 = list3;
	}
	public List<CommentEntity> getList4() {
		return list4;
	}
	public void setList4(List<CommentEntity> list4) {
		this.list4 = list4;
	}
	public long getAllpage() {
		return allpage;
	}
	public void setAllpage(long allpage) {
		this.allpage = allpage;
	}
	public List<CommentEntity> getListAll() {
		return listAll;
	}
	public void setListAll(List<CommentEntity> listAll) {
		this.listAll = listAll;
	}
	
	
	
}
