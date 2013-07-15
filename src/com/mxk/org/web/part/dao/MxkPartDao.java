package com.mxk.org.web.part.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Order;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.entity.CollectInformationEntity;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.web.part.domain.SearchPartRequest;
import com.mxk.org.web.part.domain.UpdatePartInfoRequest;

/**
 * ר��partdao
 * @author liuyijiang
 *
 */
@Component
public class MxkPartDao {

	@Value("${mxk.page.pagesize}")
	private int pageSize;
	
	private static final Log log = LogFactory.getLog(MxkPartDao.class);

	@Autowired
	private MongoOperations mog; 
	
	public List<CollectInformationEntity> findCollectInformationEntity(String targetId){
		Query q = new Query(Criteria.where("tragetId").is(targetId));
		return mog.find(q, CollectInformationEntity.class);
	}
	
	public void saveCollectInformationEntity(CollectInformationEntity en){
		mog.save(en);
	}
	
	public void removeCollectInformationEntity(String userid,String targetId){
		Query q = new Query(Criteria.where("tragetId").is(targetId).and("collecterId").is(userid));	
		mog.remove(q, CollectInformationEntity.class);
	}
	
	public long findUserSubjectPartsAllPage(String subjectid){
	    Query q = new Query(Criteria.where("subjectid").is(subjectid));	
	    long count =  mog.count(q, PartEntity.class);
		if(count != 0){
			return (count + pageSize - 1) / pageSize;
		}else{
			return 0;
		}
	}
	
	public List<PartEntity> findSubjectNewParts(String id){
		List<PartEntity> list = null;
		try{
			Query q = new Query(Criteria.where("subjectid").is(id));
			q.limit(5);
			q.sort().on("createTime", Order.DESCENDING);//����
			list = mog.find(q, PartEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return list;
	}
	
	public List<PartEntity> findPartEntityByIds(List<String> ids){
		List<PartEntity> list = null;
		try{
			Query q = new Query(Criteria.where("id").in(ids));
			list = mog.find(q , PartEntity.class);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage(),e);
		}
		return list;
	}
	
	
	public List<PartEntity> findPartEntityAll(String subjectid){
		List<PartEntity> list = null;
		try{
			Query q = new Query(Criteria.where("subjectid").is(subjectid));
			list = mog.find(q , PartEntity.class);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage(),e);
		}
		return list;
	}
	
	//��ѯsubject ���� ��Щ����subject�������ϴ���part���� userid �Ǵ���subject�ߵ�id
	public long findSubjectPartNotInUserId(String userid,String subjectid){
		long num = 0;
		try{
			Query q = new Query(Criteria.where("subjectid").is(subjectid).and("userid").ne(userid));
			num = mog.count(q , PartEntity.class);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage(),e);
		}
		return num;
	}
	
	//ɾ���¼
	public boolean removePartById(String partid){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(partid));
			mog.remove(q, PartEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public boolean updatePartById(UpdatePartInfoRequest updatePartInfoRequest){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(updatePartInfoRequest.getPartid()));
			Update u = new Update();
			u.set("desc", updatePartInfoRequest.getInfo());
			mog.updateMulti(q, u, PartEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	
	public boolean savePart(PartEntity partEntity){
		boolean success = true;
		try {
			mog.save(partEntity);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public boolean updatePartImage(String partid,String image,String minimage){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(partid));
			Update u = new Update();
			u.set("image", image);
			u.set("minimage", minimage);
			mog.updateMulti(q, u, PartEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public PartEntity findPartEntityById(String id){
		PartEntity entity = null;
		try {
			Query q = new Query(Criteria.where("id").is(id));
			entity = mog.findOne(q, PartEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return entity;
	}
	
	//������Ͳ�ѯ��ҳ��
	public long findPartEnitiyPageByType(String type){
		long count = 0;
		Query q = null;
		if(type == null){
			q = new Query();	
		}else{
			q = new Query(Criteria.where("type").is(type));	
		}
		count =  mog.count(q, PartEntity.class);
		if(count != 0){
			return (count + pageSize - 1) / pageSize;
		}else{
			return 0;
		}
	}
	
	public List<PartEntity> findPartEntityByPage(SearchPartRequest request){
		List<PartEntity> rlist = null;
		try {
			Criteria criteria = null;
			Query q = null;
			if(request.getSubjectid() != null){
				criteria = Criteria.where("subjectid").is(request.getSubjectid());
				if(request.getType() != null){
					criteria.and("type").is(request.getType());
				}
				q = new Query(criteria);
			}else{
				criteria = Criteria.where("status").ne(MxkConstant.SUBJECT_TYPE_PRIVATE);
				if(request.getType() != null){
					criteria.and("type").is(request.getType());
				}
				q = new Query(criteria);
			}
			q.sort().on("createTime", Order.DESCENDING);//����
			q.limit(pageSize);
			q.skip(pageSize*(request.getPage() - 1));
			rlist = mog.find(q, PartEntity.class);
    	} catch (Exception e) {
			log.error(e.getMessage(),e);
		} 
		return rlist;
	}
	
	//���� ���۵����� comments audios  desc ��� ����
	public boolean updatePartCommentsQuantity(String id,String type,boolean desc) {
		boolean success = true;
		try{
			Query q = new Query(Criteria.where("id").is(id));
			Update u = new Update();
			if(desc){
				u.inc(type, 1);	
			}else{
				u.inc(type, -1);	
			}
			mog.updateMulti(q, u, PartEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		} 
		return success;
	}
	
}
