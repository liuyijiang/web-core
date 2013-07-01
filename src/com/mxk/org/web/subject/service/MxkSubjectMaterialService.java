package com.mxk.org.web.subject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.entity.SubjectMaterialDetailEntity;
import com.mxk.org.entity.SubjectMaterialSummaryEntity;
import com.mxk.org.web.subject.dao.MxkSubjectMaterialDao;
import com.mxk.org.web.subject.domain.SubjectMaterailDetailRespone;

@Service
public class MxkSubjectMaterialService {

	@Autowired
	private MxkSubjectMaterialDao subjectMaterialDao;
	
	public SubjectMaterailDetailRespone findUserSubjectMaterials(String subjectid){
		SubjectMaterailDetailRespone subjectMaterailDetailRespone = new SubjectMaterailDetailRespone();
		SubjectMaterialSummaryEntity summary = subjectMaterialDao.findSubjecMaterialSummaryEntity(subjectid);
		List<SubjectMaterialDetailEntity> list =  subjectMaterialDao.findSubjectMaterialDetailEntity(subjectid);
		subjectMaterailDetailRespone.setList(list);
		subjectMaterailDetailRespone.setSummary(summary);
		return subjectMaterailDetailRespone;
	}
	
	public boolean delateSubjectMaterailDetailById(String id){
		return subjectMaterialDao.delateSubjectMaterailDetailById(id);
	}
	
	public SubjectMaterialSummaryEntity findSubjectMaterialSummaryEntityBySubjectId(String subjectid){
		return subjectMaterialDao.findSubjectMaterialSummaryEntityBySubjectId(subjectid);
	}
	
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
