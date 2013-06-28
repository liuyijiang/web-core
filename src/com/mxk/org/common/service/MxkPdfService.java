package com.mxk.org.common.service;

import java.util.List;

import com.mxk.org.entity.SubjectEntity;

public interface MxkPdfService {

	public String createSubjectPdfByParts(List<String> ids,SubjectEntity subjectEntity,String username);
	
}
