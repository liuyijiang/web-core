package com.mxk.org.web.user.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import com.mxk.org.entity.UserEntity;
import com.mxk.org.entity.UserFriendEntity;

/**
 * 用户关系dao
 * @author Administrator
 *
 */
@Component
public class MxkUserFriendDao {

	private static final Log log = LogFactory.getLog(MxkUserFriendDao.class);
	
	@Value("${mxk.page.pagesize}")
	private int pageSize;
	
	@Autowired
	private MongoOperations mog; 
	
	//返回false 表示没有关系
	public boolean checkUserRelationShip(String userId,String checkedUserId){
		boolean hasRelation = true;
		try{
			Query q = new Query(Criteria.where("userid").is(userId).and("friendid").is(checkedUserId));
		    long num = mog.count(q, UserFriendEntity.class);
		    if(num == 0){
		    	hasRelation = false;
		    }
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return hasRelation;
	}
	
	public boolean createUserRelation(UserFriendEntity user){
		boolean success = true;
		try{
			mog.save(user);
			Query quser = new Query(Criteria.where("id").is(user.getFriendid()));
			Query qfriend = new Query(Criteria.where("id").is(user.getUserid()));
			Update updateuser = new Update();
			Update updatefriend = new Update();
			updateuser.inc("focus", 1);
			updatefriend.inc("followors", 1);
			mog.updateMulti(quser, updateuser, UserEntity.class);
			mog.updateMulti(qfriend, updatefriend, UserEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
	public boolean removeUserRelation(UserFriendEntity user){
		boolean success = true;
		try{
			Query quser = new Query(Criteria.where("userid").is(user.getUserid()).and("friendid").is(user.getFriendid()));
			Query qfriend = new Query(Criteria.where("userid").is(user.getFriendid()).and("friendid").is(user.getUserid()));
			mog.remove(quser, UserFriendEntity.class);
			mog.remove(qfriend, UserFriendEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
	public List<String> findUserFirendsIds(String id,int page,boolean isfollower){
		Query q = null;
		List<String> list = null;
		if(isfollower){
			q =  new Query(Criteria.where("userid").is(id));
		}else{
			q =  new Query(Criteria.where("friendid").is(id));
		}
		q.limit(pageSize);
		q.skip(pageSize*(page - 1));
		List<UserFriendEntity> flist =  mog.find(q, UserFriendEntity.class);
		if(flist != null && !flist.isEmpty()){
			list = new ArrayList<String>();
			for(UserFriendEntity entity : flist){
				if(isfollower){
					list.add(entity.getFriendid());
				}else{
					list.add(entity.getUserid());
				}
			}
		}
		return list;
	}
	
}
