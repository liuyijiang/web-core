package com.mxk.org.web.subject.dao;

import java.math.BigDecimal;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import com.mxk.org.entity.SubjectMaterialDetailEntity;
import com.mxk.org.entity.SubjectMaterialSummaryEntity;

@Component
public class MxkSubjectMaterialDao {

	private static final Log log = LogFactory.getLog(MxkSubjectMaterialDao.class);
	
	@Autowired
	private MongoOperations mog; 
	
	public boolean delateSubjectMaterailDetailById(String id){
		boolean success = true;
		try{
			Query q = new Query(Criteria.where("id").is(id));
			mog.remove(q,SubjectMaterialDetailEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	
	}
	
	public SubjectMaterialSummaryEntity findSubjecMaterialSummaryEntity(String subjectid) {
		Query q = new Query(Criteria.where("subjectId").is(subjectid));
		return mog.findOne(q, SubjectMaterialSummaryEntity.class);
	}
	
	public List<SubjectMaterialDetailEntity> findSubjectMaterialDetailEntity(String subjectid) {
		Query q = new Query(Criteria.where("subjectid").is(subjectid));
		return mog.find(q, SubjectMaterialDetailEntity.class);
	}
	
	public boolean updateSubejcyMaterialExcelUrl(String id,String excel){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(id));
			Update u = new Update();
			u.set("dowmloadExl", excel);
			mog.updateMulti(q, u, SubjectMaterialSummaryEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public SubjectMaterialSummaryEntity findSubjectMaterialSummaryEntityBySubjectId(String subjectid){
		Query q = new Query(Criteria.where("subjectId").is(subjectid));
		return mog.findOne(q, SubjectMaterialSummaryEntity.class);
	}
	
	public SubjectMaterialSummaryEntity findSubjectMaterialSummaryEntityById(String id){
		Query q = new Query(Criteria.where("id").is(id));
		return mog.findOne(q, SubjectMaterialSummaryEntity.class);
	}
	
	public List<SubjectMaterialDetailEntity> findSubjectMaterialDetailEntityBySubjectId(String id){
		Query q = new Query(Criteria.where("subjectid").is(id));
		return mog.find(q, SubjectMaterialDetailEntity.class);
	}
	
	
	public boolean createSubjectMaterial(SubjectMaterialSummaryEntity summary,List<SubjectMaterialDetailEntity> list){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("subjectId").is(summary.getSubjectId()));
			long num = mog.count(q, SubjectMaterialSummaryEntity.class);
			if(num == 0){
			    mog.save(summary);
			}
			for(SubjectMaterialDetailEntity detail : list){
				detail.setSubjectid(summary.getSubjectId());
				detail.setSummaryid(summary.getId());
				detail.setAllMoney(detail.getMoney().multiply(new BigDecimal(detail.getNum())));
				detail.setUserid(summary.getUserid());
				mog.save(detail);
			}
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
}
