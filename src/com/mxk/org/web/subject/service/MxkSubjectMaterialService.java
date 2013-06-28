package com.mxk.org.web.subject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.entity.SubjectMaterialDetailEntity;
import com.mxk.org.entity.SubjectMaterialSummaryEntity;
import com.mxk.org.web.subject.dao.MxkSubjectMaterialDao;

@Service
public class MxkSubjectMaterialService {

	@Autowired
	private MxkSubjectMaterialDao subjectMaterialDao;
	
	public SubjectMaterialSummaryEntity findSubjectMaterialSummaryEntityById(String id){
		return subjectMaterialDao.findSubjectMaterialSummaryEntityById(id);
	}
	
	public boolean createSubjectMaterial(SubjectMaterialSummaryEntity summary,List<SubjectMaterialDetailEntity> list){
		return subjectMaterialDao.createSubjectMaterial(summary, list);
	}
	
	public boolean updateSubejcyMaterialExcelUrl(String id,String excel){
		return subjectMaterialDao.updateSubejcyMaterialExcelUrl(id, excel);
	}
}
