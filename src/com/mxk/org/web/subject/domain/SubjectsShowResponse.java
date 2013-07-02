package com.mxk.org.web.subject.domain;

import java.util.List;

import com.mxk.org.entity.SubjectEntity;

/**
 * 瀑布流显示的4个栅格
 * @author liuyijiang
 *
 */
public class SubjectsShowResponse {
   
	private long allpage;
	private List<SubjectEntity> list1;
	private List<SubjectEntity> list2;
	private List<SubjectEntity> list3;
	private List<SubjectEntity> list4;
	
	
	public List<SubjectEntity> getList1() {
		return list1;
	}
	public void setList1(List<SubjectEntity> list1) {
		this.list1 = list1;
	}
	public List<SubjectEntity> getList2() {
		return list2;
	}
	public void setList2(List<SubjectEntity> list2) {
		this.list2 = list2;
	}
	public List<SubjectEntity> getList3() {
		return list3;
	}
	public void setList3(List<SubjectEntity> list3) {
		this.list3 = list3;
	}
	public List<SubjectEntity> getList4() {
		return list4;
	}
	public void setList4(List<SubjectEntity> list4) {
		this.list4 = list4;
	}
	public long getAllpage() {
		return allpage;
	}
	public void setAllpage(long allpage) {
		this.allpage = allpage;
	}
	
	
	
}
