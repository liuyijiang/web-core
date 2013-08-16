package com.mxk.org.web.user.dao;

import java.util.ArrayList;
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

import com.mxk.org.common.util.StringUtil;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.UserCollectEntity;
import com.mxk.org.entity.UserEntity;
import com.mxk.org.entity.UserRssSubjectEntity;
import com.mxk.org.web.user.domain.UserCollectSearchRequest;
import com.mxk.org.web.user.domain.UserRegisterRequest;
import com.mxk.org.web.visitor.domain.CollectPartsRequest;

@Component
public class MxkUserDao {
   
	@Value("${mxk.page.pagesize}")
	private int pageSize;
	
	private static final Log log = LogFactory.getLog(MxkUserDao.class);
	
	@Autowired
	private MongoOperations mog; 
	
	public List<UserEntity> findAllUsers(){
		Query q = new Query();
		return mog.find(q, UserEntity.class);
	}
	
	public long findUserRssSubjectALlPage(String userid){
		Query q = new Query(Criteria.where("userid").is(userid));
		long count = mog.count(q, UserRssSubjectEntity.class);
		if(count != 0) {
			return (count + pageSize - 1) / pageSize;
		} else{
			return 0;
		}
	}
	
	public List<String> findUserRssSubjectIdsList(String userid,int page){
		List<String> ids = null;
		try{
			Query q = new Query(Criteria.where("userid").is(userid));
			q.sort().on("createTime", Order.DESCENDING);//����
			q.limit(pageSize);
			q.skip(pageSize*(page - 1));	
		    List<UserRssSubjectEntity> list = mog.find(q, UserRssSubjectEntity.class);
			if(list != null && !list.isEmpty()){
				ids = new ArrayList<String>();
				for (UserRssSubjectEntity s : list) {
					ids.add(s.getSubjectid());
				}
			}
		}catch(Exception e){
			log.error(e.getMessage(),e);
		}
		return ids;
	}
	
	public UserEntity updateUserPassword(String email,String password){
		UserEntity userEntity = null;
		try{
			Query q = new Query(Criteria.where("email").is(email));
			userEntity =  mog.findOne(q, UserEntity.class);
			Update u = new Update();
			u.set("password", password);
			mog.updateMulti(q, u, UserEntity.class);
		}catch(Exception e){
			log.error(e.getMessage(),e);
		}
		return userEntity;
	}
	
	public List<UserEntity> findUserEntityByIdList(List<String> ids){
		List<UserEntity> list = null;
		try {
		   Query q = new Query(Criteria.where("id").in(ids));
		   list = mog.find(q, UserEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return list;
    }
	
	public long findUserCollectPartsPages(UserCollectSearchRequest userCollectSearchRequest){
		long count = 0;
		Criteria criteria = Criteria.where("userid").is(userCollectSearchRequest.getUserid());
		if(userCollectSearchRequest.getType() != null){
			criteria.and("targetType").is(userCollectSearchRequest.getType());
		}
		Query q = new Query(criteria);
		count =  mog.count(q, UserCollectEntity.class);
		if(count != 0){
			return (count + pageSize - 1) / pageSize;
		}else{
			return 0;
		}
	}
	
	public List<String> findUserCollectPartsIds(UserCollectSearchRequest userCollectSearchRequest){
		List<String> ids = null;
		try {
			Criteria criteria = Criteria.where("userid").is(userCollectSearchRequest.getUserid());
			if(userCollectSearchRequest.getType() != null){
				criteria.and("targetType").is(userCollectSearchRequest.getType());
			}
			Query q = new Query(criteria);
			q.sort().on("createTime", Order.DESCENDING);//����
			q.limit(pageSize);
			q.skip(pageSize*(userCollectSearchRequest.getPage() - 1));
			List<UserCollectEntity> list = mog.find(q, UserCollectEntity.class);
			if(list != null && !list.isEmpty()){
				ids = new ArrayList<String>();
				for(UserCollectEntity entity : list){
					ids.add(entity.getTargetId());
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return ids;
	}
	
	
	public List<UserEntity> findUserByName(String str,int page){
		Query q = new Query(Criteria.where("name").regex(".*?"+str+".*"));
		q.limit(pageSize);
		q.skip(pageSize*(page - 1));
		List<UserEntity> list = mog.find(q, UserEntity.class);
		return list;
	}
	
	public long findUserByNameCount(String str){
		Query q = new Query(Criteria.where("name").regex(".*?"+str+".*"));
		return mog.count(q, UserEntity.class);
	}
	
	public boolean updateUserEntity(UserRegisterRequest userRegisterRequest) {
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(userRegisterRequest.getUserid()));
			Update u = new Update();
			if(userRegisterRequest.getImageurl() != null && userRegisterRequest.getMinimageurl() != null){
				u.set("image", userRegisterRequest.getImageurl());
				u.set("minimage", userRegisterRequest.getMinimageurl());
			}
			u.set("name",userRegisterRequest.getUsername());
			u.set("info",userRegisterRequest.getInfo());
			u.set("sex",userRegisterRequest.getSex());
			u.set("interest", userRegisterRequest.getInterest());
			mog.updateMulti(q, u, UserEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
	public boolean createUserCollect(CollectPartsRequest collectPartsRequest){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("userid").is(collectPartsRequest.getUserid()).and("targetId").is(collectPartsRequest.getTargetId()));
			long num = mog.count(q, UserCollectEntity.class);
			if(num == 0){
			  Query qpart = new Query(Criteria.where("id").is(collectPartsRequest.getTargetId()));
			  PartEntity partEntity = mog.findOne(qpart, PartEntity.class);
			  UserCollectEntity userCollectEntity = new UserCollectEntity();
			  userCollectEntity.setTargetId(collectPartsRequest.getTargetId());
			  userCollectEntity.setUserid(collectPartsRequest.getUserid());
			  userCollectEntity.setCreateTime(StringUtil.dateToString(new Date(), null));
			  userCollectEntity.setTargetType(partEntity.getType());
			  mog.save(userCollectEntity);
			  Update u = new Update();
			  u.inc("collect", 1);
			  mog.updateMulti(qpart, u, PartEntity.class);
			}else{
				success = false;
			}
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
	public boolean removeUserCollect(CollectPartsRequest collectPartsRequest){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("userid").is(collectPartsRequest.getUserid()).and("targetId").is(collectPartsRequest.getTargetId()));
			mog.remove(q, UserCollectEntity.class);
			Query qpart = new Query(Criteria.where("id").is(collectPartsRequest.getTargetId()));
			Update u = new Update();
			u.inc("collect", -1);
			mog.updateMulti(qpart, u, PartEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
	public UserEntity checkUser(String email,String password){
		UserEntity userEntity = null;
		try {
			Query q = new Query(Criteria.where("email").is(email).and("password").is(password));
			userEntity = mog.findOne(q, UserEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
	    return userEntity;
	}
	
	public boolean checkUserNameUnique(String name){
		Query q = new Query(Criteria.where("name").is(name));
		Long num = mog.count(q, UserEntity.class);
		if(num == 0){
			return true;
		}else{
			return false;
		}
	}
	
	public boolean checkUserEmailUnique(String email){
		Query q = new Query(Criteria.where("email").is(email));
		Long num = mog.count(q, UserEntity.class);
		if(num == 0){
			return true;
		}else{
			return false;
		}
	}
	
	public boolean saveUserEntity(UserEntity userEntity){
		boolean success = true;
		try {
			if(checkUserEmailUnique(userEntity.getEmail()) && checkUserNameUnique(userEntity.getName())){
			  mog.save(userEntity);
			}
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
	public boolean updateUserImage(String userid,String image,String minimage){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(userid));
			Update u = new Update();
			u.set("image", image);
			u.set("minimage", minimage);
			mog.updateMulti(q, u, UserEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
}
