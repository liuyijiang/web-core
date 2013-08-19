package com.mxk.org.web.subject.dao;

import java.util.Date;
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
import com.mxk.org.common.util.StringUtil;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.entity.SubjectExtraEntity;
import com.mxk.org.entity.SubjectJoinPeopleEntity;
import com.mxk.org.entity.SubjectWorkingEntity;
import com.mxk.org.entity.UserEntity;
import com.mxk.org.entity.UserRssSubjectEntity;
import com.mxk.org.web.subject.domain.CreateSubjectRequest;
import com.mxk.org.web.subject.domain.SearchSubjectRequest;
import com.mxk.org.web.subject.domain.SetFaceImageRequest;
import com.mxk.org.web.subject.domain.UpdateSubjectStatusRequest;
import com.mxk.org.web.user.domain.UserVO;
/**
 * ר��dao
 * @author liuyijiang
 *
 */
@Component
public class MxkSubjectDao {
   
	@Value("${mxk.page.pagesize}")
	private int pageSize;
	
	private static final Log log = LogFactory.getLog(MxkSubjectDao.class);
	
	@Autowired
	private MongoOperations mog; 
	
	public boolean updateSubjectQrCode(String id,String qrcodeImage){
		boolean success = true;
		try{
			Query qs = new Query(Criteria.where("id").is(id));	
			Update u = new Update();
			u.set("qrcodeImage", qrcodeImage);
			mog.updateMulti(qs, u, SubjectEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	/**
	 * 批量修改历史数据 
	 */
	public void btnUpdateSubjects(){
		Query qs = new Query();
		List<SubjectEntity> list = mog.find(qs, SubjectEntity.class);
		for (SubjectEntity sub : list) {
			Update up = new Update();
			Query qu = new Query(Criteria.where("id").is(sub.getUserid()));
			UserEntity un = mog.findOne(qu, UserEntity.class);
			up.set("username", un.getName());
			up.set("userimage", un.getImage());
			Query qsone = new Query(Criteria.where("id").is(sub.getId()));
			mog.updateMulti(qsone, up, SubjectEntity.class);
		}
		
	}
	
	
	public void updateSubjectEntity(CreateSubjectRequest request){
		Query q = new Query(Criteria.where("id").is(request.getId()));
		SubjectEntity sub = mog.findOne(q, SubjectEntity.class);
		if(sub != null && sub.getUserid().equals(request.getUserid())){
			Update usub = new Update();
			usub.set("info", request.getInfo());
			usub.set("name", request.getName());
			usub.set("category", request.getCategory());
			if(!sub.getTags().equals(request.getTags())){
				usub.set("tags", request.getTags());
				Query qpart = new Query(Criteria.where("subjectid").is(sub.getId()).and("userid").is(sub.getUserid()));
				Update upart = new Update();
				upart.set("type", request.getTags());
				mog.updateMulti(qpart, upart, PartEntity.class);
			}
			mog.updateMulti(q,usub,SubjectEntity.class);
		}
	}
	
	
	public List<SubjectWorkingEntity> findUserWorkingList(String userid,String subjectid){
		Query q = new Query(Criteria.where("userid").is(userid).and("subjectid").is(subjectid));
		return mog.find(q, SubjectWorkingEntity.class);
	}
	
	
	public SubjectWorkingEntity findSubjectWorkingEntityByDate(String userid,String subjectid,String createTime){
		Query q = new Query(Criteria.where("userid").is(userid).and("subjectid").is(subjectid).and("createTime").is(createTime));
		return mog.findOne(q, SubjectWorkingEntity.class);
	}
	
	public boolean saveSubjectWorkingEntity(SubjectWorkingEntity entity){
		boolean success = true;
		try{
			mog.save(entity);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public boolean updateSubjectWorkingEntity(SubjectWorkingEntity entity){
		boolean success = true;
		try{
			Query q = new Query(Criteria.where("userid").is(entity.getUserid()).and("subjectid").is(entity.getSubjectid()).and("createTime").is(entity.getCreateTime()));
			Update u = new Update();
			u.set("plan", entity.getPlan());
			u.set("doc", entity.getDoc());
			mog.updateMulti(q, u, SubjectWorkingEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public boolean deleteSubject(String id){
		boolean success = true;
		try{
			Query q = new Query(Criteria.where("id").is(id));
			mog.remove(q, SubjectEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
		
	}
	
	public long findUserSubjectAllPage(String userid){
		Query q = new Query(Criteria.where("userid").is(userid));
		int count = (int) mog.count(q, SubjectEntity.class);
		if(count != 0){
			return (count + pageSize-1) / pageSize;
		}else{
			return 0;
		}
	}
	
	public List<SubjectEntity> findSubjectEntityByIdsList(List<String> ids){
		Query q = new Query(Criteria.where("id").in(ids));
		return mog.find(q, SubjectEntity.class);
	}
	
	public long findUserRssSubjectNum(String userid){
		Query qp = new Query(Criteria.where("userid").is(userid));
		return mog.count(qp, UserRssSubjectEntity.class);
	}
	
	public boolean addSubjectJoinPeople(UserVO vo,String subjectid){
		boolean success = true;
		try{
			Query qp = new Query(Criteria.where("subjectid").is(subjectid).and("userid").is(vo.getId()));
			long num = mog.count(qp, SubjectJoinPeopleEntity.class);
			if(num == 0){
				SubjectJoinPeopleEntity sub = new SubjectJoinPeopleEntity();
				sub.setCreateTime(StringUtil.dateToString(new Date(), null));
				sub.setUserid(vo.getId());
				sub.setUserimage(vo.getImage());
				sub.setSubjectid(subjectid);
				sub.setParts(1);
				sub.setUserdesc(vo.getInfo());
				sub.setUsername(vo.getName());
				mog.save(sub);
				Query q = new Query(Criteria.where("id").is(subjectid));
				Update u = new Update();
				u.inc("joinpeople", 1);
				mog.updateMulti(q, u, SubjectEntity.class);
			}else{
				Update u = new Update();
				u.inc("parts", 1);
				mog.updateMulti(qp, u, SubjectJoinPeopleEntity.class);
			}
		}catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public List<SubjectEntity> findSubjectEntityByName(String name,int page){
		Query q = new Query(Criteria.where("name").regex(".*?"+name+".*"));
		q.limit(pageSize);
		q.skip(pageSize*(page - 1));
		List<SubjectEntity> list = mog.find(q, SubjectEntity.class);
		return list;
	}
	
	public List<SubjectEntity> findSubjectEntityForALl(String tags,String type,int page){
		Query q = null;
		Criteria criteria = null;
		if(type != null){
			criteria = Criteria.where("type").is(MxkConstant.SUBJECT_TYPE_FOR_ALL);
		}else{
			criteria = Criteria.where("type").ne(MxkConstant.SUBJECT_TYPE_PRIVATE);
		}
		if(!StringUtil.stringIsEmpty(tags)){
			criteria.and("tags").is(tags);
		}
		q = new Query(criteria);
		q.sort().on("createTime", Order.DESCENDING);//����
		q.limit(pageSize);
		q.skip(pageSize*(page - 1));
		List<SubjectEntity> list = mog.find(q, SubjectEntity.class);
		return list;
	}
	
	//��ҳ�� ��ҳ�����������ҳ���Ͳ��������� 
	public int findSubjectEntityForALlPages(String tags,String type){
		Query q = null;
		Criteria criteria = null;
		if(type != null){
			criteria = Criteria.where("type").is(MxkConstant.SUBJECT_TYPE_FOR_ALL);
		}else{
			criteria = Criteria.where("type").ne(MxkConstant.SUBJECT_TYPE_PRIVATE);
		}
		if(!StringUtil.stringIsEmpty(tags)){
			criteria.and("tags").is(tags);
		}
		int count = (int) mog.count(q, SubjectEntity.class);
		if(count != 0){
			return (count + pageSize-1) / pageSize;
		}else{
			return 0;
		}
	}
	
	//��ҳ�� ��ҳ�����������ҳ���Ͳ���������
	public int findSubjectEntityByNamePages(String name){
		Query q = new Query(Criteria.where("name").regex(".*?"+name+".*"));
		int count = (int) mog.count(q, SubjectEntity.class);
		if(count != 0){
			return (count + pageSize-1) / pageSize;
		}else{
			return 0;
		}
	}
	
	public boolean removeUserRssSubejct(String userid,String subject){
		boolean success = true;
		try {
			Query qremove = new Query(Criteria.where("userid").is(userid).and("subjectid").is(subject));
			mog.remove(qremove, UserRssSubjectEntity.class);
			Query q = new Query(Criteria.where("id").is(subject));
			Update u = new Update();
			u.inc("attention", -1);
			mog.updateMulti(q, u, SubjectEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public List<UserRssSubjectEntity> findSubjectRssByPage(String subjectid,int page){
		List<UserRssSubjectEntity> list = null;
		try {
			Query q = new Query(Criteria.where("subjectid").is(subjectid));
			q.sort().on("createTime", Order.DESCENDING);//����
			q.limit(pageSize);
			q.skip(pageSize * (page - 1));
			list = mog.find(q, UserRssSubjectEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return list;
	}
	
	
	public boolean createUserRssSubject(UserRssSubjectEntity userRssSubjectEntity){
		boolean success = true;
		try {
			Query qp = new Query(Criteria.where("userid").is(userRssSubjectEntity.getUserid()).and("subjectid").is(userRssSubjectEntity.getSubjectid()));
			long num = mog.count(qp, UserRssSubjectEntity.class);
			if(num == 0){
				mog.save(userRssSubjectEntity);
				Query q = new Query(Criteria.where("id").is(userRssSubjectEntity.getSubjectid()));
				Update u = new Update();
				u.inc("attention", 1);
				mog.updateMulti(q, u, SubjectEntity.class);
			}else{
				success = false;	
			}
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	
	public boolean updateSubjectForCreatePart(String subjectid,String imageurl){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(subjectid));
			Update u = new Update();
			u.inc("parts", 1);
			if(imageurl != null){
				u.set("faceimage", imageurl);
			}
			mog.updateMulti(q, u, SubjectEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	
	public boolean updateSubjectStatus(UpdateSubjectStatusRequest updateSubjectStatusRequest){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(updateSubjectStatusRequest.getId()));
			Update u = new Update();
			u.set("type", updateSubjectStatusRequest.getStauts());
			mog.updateMulti(q, u, SubjectEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public boolean setSubjectFaceImage(SetFaceImageRequest setFaceImageRequest){
		boolean success = true;
		try {
			Query qs = new Query(Criteria.where("id").is(setFaceImageRequest.getPartid()));
			PartEntity partEntity = mog.findOne(qs, PartEntity.class);
			Query q = new Query(Criteria.where("id").is(setFaceImageRequest.getSubjectid()));
			Update u = new Update();
			u.set("faceimage", partEntity.getMinimage());
			mog.updateMulti(q, u, SubjectEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public SubjectExtraEntity findSubjectExtraEntity(String subjectid){
		Query q = new Query(Criteria.where("subjectid").is(subjectid));
		return mog.findOne(q, SubjectExtraEntity.class);
	}
	
	public boolean updateSubjectExtraUrl(String extraid,String type,String url){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("subjectid").is(extraid));
			Update u = new Update();
			u.set(type, url);
			mog.updateMulti(q, u, SubjectExtraEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return success;
	} 
	
	public boolean saveSubject(SubjectEntity subjectEntity){
		boolean success = true;
		try {
			mog.save(subjectEntity);
			SubjectExtraEntity sub = new SubjectExtraEntity();
			sub.setGifUrl("-");
			sub.setPdfUrl("-");
			sub.setUrlDowmloadTimes(0);
			sub.setUserid(subjectEntity.getUserid());
			sub.setSubjectid(subjectEntity.getId());
			mog.save(sub);
			Query q = new Query(Criteria.where("id").is(subjectEntity.getUserid()));
			Update u = new Update();
			u.inc("subject", 1);
			mog.updateMulti(q, u, UserEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public SubjectEntity findSubjectEntityById(String id){
		SubjectEntity entity = null;
		try {
			Query q = new Query(Criteria.where("id").is(id));
			entity = mog.findOne(q, SubjectEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return entity;
	}
	
	public List<SubjectEntity> findSubjectEntityByPage(SearchSubjectRequest request){
		List<SubjectEntity> rlist = null;
		try {
			Criteria criteria = Criteria.where("userid").is(request.getUseid());
			if(request.getType() != null){
				criteria.and("type").is(request.getType());
			}
			Query q = new Query(criteria);
			q.sort().on("createTime", Order.DESCENDING);//����
			q.limit(pageSize);
			q.skip(pageSize*(request.getPage() - 1));
			rlist = mog.find(q, SubjectEntity.class);
    	} catch (Exception e) {
			log.error(e.getMessage(),e);
		} 
		return rlist;
	}
	
	public boolean updateSubjectCommentsQuantity(String id, boolean desc) {
		boolean success = true;
		try{
			Query q = new Query(Criteria.where("id").is(id));
			Update u = new Update();
			if(desc){
				u.inc("comments", 1);	
			}else{
				u.inc("comments", -1);	
			}
			mog.updateMulti(q, u, SubjectEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		} 
		return success;
	}
	
}
