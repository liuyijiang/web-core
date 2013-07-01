package com.mxk.org.common.service;

import java.io.File;
import java.util.List;

import com.mxk.org.entity.SubjectEntity;

public interface MxkPdfService {

	public File createSubjectPdfByParts(List<String> ids,SubjectEntity subjectEntity,String username);
	
}
