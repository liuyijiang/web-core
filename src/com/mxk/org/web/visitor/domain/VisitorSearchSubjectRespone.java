package com.mxk.org.web.visitor.domain;

import com.mxk.org.web.subject.domain.SubjectsShowResponse;

public class VisitorSearchSubjectRespone {
   
	private SubjectsShowResponse subjectsShowResponse;
	private int allPage;
	private String parm;
	
	public int getAllPage() {
		return allPage;
	}
	public void setAllPage(int allPage) {
		this.allPage = allPage;
	}
	public SubjectsShowResponse getSubjectsShowResponse() {
		return subjectsShowResponse;
	}
	public void setSubjectsShowResponse(SubjectsShowResponse subjectsShowResponse) {
		this.subjectsShowResponse = subjectsShowResponse;
	}
	public String getParm() {
		return parm;
	}
	public void setParm(String parm) {
		this.parm = parm;
	}
	
	
}
