package com.mxk.org.web.subject.domain;

import java.util.List;

import com.mxk.org.entity.SubjectMaterialDetailEntity;

public class CreateSubjectMaiterialRequest {
   
	private String summaryid;
	private List<SubjectMaterialDetailEntity> list;

	public List<SubjectMaterialDetailEntity> getList() {
		return list;
	}

	public void setList(List<SubjectMaterialDetailEntity> list) {
		this.list = list;
	}

	public String getSummaryid() {
		return summaryid;
	}

	public void setSummaryid(String summaryid) {
		this.summaryid = summaryid;
	}
	
	
	
}
