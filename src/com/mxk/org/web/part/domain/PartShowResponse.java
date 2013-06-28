package com.mxk.org.web.part.domain;

import java.util.List;

import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.SubjectJoinPeopleEntity;

public class PartShowResponse {

	private List<SubjectJoinPeopleEntity> joiner;
	private List<PartEntity> list1;
	private List<PartEntity> list2;
	private List<PartEntity> list3;
	private List<PartEntity> list4;
	private long allPage;//当加载页数超过总页数后不加载
	
	public List<PartEntity> getList1() {
		return list1;
	}
	public void setList1(List<PartEntity> list1) {
		this.list1 = list1;
	}
	public List<PartEntity> getList2() {
		return list2;
	}
	public void setList2(List<PartEntity> list2) {
		this.list2 = list2;
	}
	public List<PartEntity> getList3() {
		return list3;
	}
	public void setList3(List<PartEntity> list3) {
		this.list3 = list3;
	}
	public List<PartEntity> getList4() {
		return list4;
	}
	public void setList4(List<PartEntity> list4) {
		this.list4 = list4;
	}
	public long getAllPage() {
		return allPage;
	}
	public void setAllPage(long allPage) {
		this.allPage = allPage;
	}
	public List<SubjectJoinPeopleEntity> getJoiner() {
		return joiner;
	}
	public void setJoiner(List<SubjectJoinPeopleEntity> joiner) {
		this.joiner = joiner;
	}
	
	
}
