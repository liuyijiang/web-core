package com.mxk.org.web.subject.domain;

import java.util.List;

import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.entity.UserRssSubjectEntity;

public class SubjectMessageShowRespone {
  
	private SubjectEntity subjectEntity;
	private SubjectNewPartsVO subjectNewPartsVO;
	private List<UserRssSubjectEntity> list;
	
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
	public List<UserRssSubjectEntity> getList() {
		return list;
	}
	public void setList(List<UserRssSubjectEntity> list) {
		this.list = list;
	}
	
	
	
}
