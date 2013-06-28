package com.mxk.org.web.visitor.domain;

import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.web.comments.domain.LoadCommentsRespone;
import com.mxk.org.web.subject.domain.SubjectNewPartsVO;

public class VistitorSeeSubjectCommentsRespone {

	private SubjectEntity subjectEntity;
	private SubjectNewPartsVO subjectNewPartsVO;
	private LoadCommentsRespone loadCommentsRespone;
	private String type;
	
	public SubjectEntity getSubjectEntity() {
		return subjectEntity;
	}
	public void setSubjectEntity(SubjectEntity subjectEntity) {
		this.subjectEntity = subjectEntity;
	}
	public SubjectNewPartsVO getSubjectNewPartsVO() {
		return subjectNewPartsVO;
	}
	public void setSubjectNewPartsVO(SubjectNewPartsVO subjectNewPartsVO) {
		this.subjectNewPartsVO = subjectNewPartsVO;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public LoadCommentsRespone getLoadCommentsRespone() {
		return loadCommentsRespone;
	}
	public void setLoadCommentsRespone(LoadCommentsRespone loadCommentsRespone) {
		this.loadCommentsRespone = loadCommentsRespone;
	}
	
	
}
