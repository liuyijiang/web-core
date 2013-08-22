package com.mxk.org.web.comments.dao;

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
import com.mxk.org.entity.CommentEntity;
import com.mxk.org.entity.GiftEntity;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.entity.SubjectPriceEntity;
import com.mxk.org.entity.UserEntity;
import com.mxk.org.entity.UserGiftEntity;
import com.mxk.org.entity.UserLikeEntity;
import com.mxk.org.entity.UserPointEntity;
import com.mxk.org.web.comments.domain.LoadCommentsRequest;

@Component
public class MxkCommentsDao {

	private static final Log log = LogFactory.getLog(MxkCommentsDao.class);
	
	@Value("${mxk.commnets.full.pagesize}")
	private int pageSize;
	
	@Value("${mxk.commnets.min.pagesize}")
	private int miniPageSize;
	
	@Autowired
	private MongoOperations mog; 
	
	public List<SubjectPriceEntity> findSubjectPriceEntity(String subjectid,int page){
		Query q = new Query(Criteria.where("subjectid").is(subjectid));
		q.sort().on("createTime", Order.DESCENDING);
		q.limit(pageSize);
		q.skip(pageSize*(page - 1));
		return mog.find(q, SubjectPriceEntity.class);
	}
	
	public long findCountOfSubjectPriceEntity(String subjectid){
		Query q = new Query(Criteria.where("subjectid").is(subjectid));
		long count = mog.count(q, SubjectPriceEntity.class);
		if(count != 0){
			return (count + pageSize - 1) / pageSize;
		}else{
			return 1;
		}
	}
	
	public boolean checkHasBeenSetPrice(String subjectid,String userid){
		boolean success = false;
		Query q = new Query(Criteria.where("subjectid").is(subjectid).and("setPriceUserId").is(userid));
	    long num = mog.count(q, SubjectPriceEntity.class);
	    if(num == 0){
	    	success = true;
	    }
	    return success;
	}
	
	public boolean saveSubjectPriceEntity(SubjectPriceEntity entity){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(entity.getSubjectid()));
			SubjectEntity su = mog.findOne(q, SubjectEntity.class);
			if(su != null){
				mog.save(entity);
				if(su.getHighMoney() < entity.getMoney()){
					Update u = new Update();
					u.set("highMoney", entity.getMoney());
					mog.updateMulti(q, u, SubjectEntity.class);
				}
			}
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	
	public long findCountOfUserSetPoint(String tragetid){
		Query q = new Query(Criteria.where("targetId").is(tragetid));
		long count = mog.count(q, UserPointEntity.class);
		if(count != 0){
			return (count + pageSize - 1) / pageSize;
		}else{
			return 1;
		}
	}
	
	public List<UserPointEntity> findUserPointEntity(String tragetid,int page){
		Query q = new Query(Criteria.where("targetId").is(tragetid));
		q.sort().on("createTime", Order.DESCENDING);//����
		q.limit(pageSize);
		q.skip(pageSize*(page - 1));
		return mog.find(q, UserPointEntity.class);
	}
	
	
	public long findCountOfUserLikeEntity(String tragetid){
		Query q = new Query(Criteria.where("targetId").is(tragetid));
		long count = mog.count(q, UserLikeEntity.class);
		if(count != 0){
			return (count + pageSize - 1) / pageSize;
		}else{
			return 1;
		}
	}
	
	public List<UserLikeEntity> findUserLikeEntityByPage(String tragetid,int page){
		Query q = new Query(Criteria.where("targetId").is(tragetid));
		q.sort().on("createTime", Order.DESCENDING);//����
		q.limit(pageSize);
		q.skip(pageSize*(page - 1));
		return mog.find(q, UserLikeEntity.class);
	}
	
	public long findCountOfUserGiftEntity(String tragetid){
		Query q = new Query(Criteria.where("tragetId").is(tragetid));
		long count = mog.count(q, UserGiftEntity.class);
		if(count != 0){
			return (count + pageSize - 1) / pageSize;
		}else{
			return 1;
		}
	}
	
	public long findCountOfUserAllGift(String tragetid){
		Query q = new Query(Criteria.where("userid").is(tragetid));
		long count = mog.count(q, UserGiftEntity.class);
		if(count != 0){
			return (count + pageSize - 1) / pageSize;
		}else{
			return 1;
		}
	}
	
	public List<UserGiftEntity> findUserGiftEntity(String tragetid,int page){
		Query q = new Query(Criteria.where("userid").is(tragetid));
		q.sort().on("sendGiftTime", Order.DESCENDING);//����
		q.limit(pageSize);
		q.skip(pageSize*(page - 1));
		return mog.find(q, UserGiftEntity.class);
	}
	
	
	public List<UserGiftEntity> findUserGiftEntityByPage(String tragetid,int page){
		Query q = new Query(Criteria.where("tragetId").is(tragetid));
		q.sort().on("sendGiftTime", Order.DESCENDING);//����
		q.limit(pageSize);
		q.skip(pageSize*(page - 1));
		return mog.find(q, UserGiftEntity.class);
	}
	
	public GiftEntity randomGift(){ 
		GiftEntity en = null;
		Query q = new Query();
		long count = mog.count(q, GiftEntity.class);
		if (count != 0) {
			long page = count;
			Long i = (long)(Math.random()*page);
			q.limit(1);
			q.skip(i.intValue());
			List<GiftEntity> list = mog.find(q, GiftEntity.class);
			en = list.get(0);
		}
		return en;
	}
	
	public boolean saveUserSetPonit(UserPointEntity entity){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(entity.getTargetId()));
			mog.save(entity);
			if(MxkConstant.PART.equals(entity.getTargetType())){
				PartEntity pe = mog.findOne(q, PartEntity.class);
				if(entity.getPoint() > pe.getHighPoint()){
					Update up = new Update();
					up.set("highPoint", entity.getPoint());
					mog.updateMulti(q, up, PartEntity.class);
				}
			}else if(MxkConstant.SUBJECT.equals(entity.getTargetType())){
				SubjectEntity sub = mog.findOne(q, SubjectEntity.class);
				if(entity.getPoint() > sub.getHighPoint()){
					Update up = new Update();
					up.set("highPoint", entity.getPoint());
					mog.updateMulti(q, up, SubjectEntity.class);
				}
			}
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	
	public boolean checkHasBeanSetPoint(String tragetId,String userid){
		boolean success = false;
		Query q = new Query(Criteria.where("targetId").is(tragetId).and("userid").is(userid));
	    long num = mog.count(q, UserPointEntity.class);
	    if(num == 0){
	    	success = true;
	    }
	    return success;
	}
	
	public boolean checkHaslBeenLiked(String tragetId,String userid){
		boolean success = false;
		Query q = new Query(Criteria.where("targetId").is(tragetId).and("userid").is(userid));
	    long num = mog.count(q, UserLikeEntity.class);
	    if(num == 0){
	    	success = true;
	    }
	    return success;
	}
	
	public boolean saveUserliked(UserLikeEntity entity){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(entity.getTargetId()));
			Update up = new Update();
			up.inc("likes", 1);
			mog.save(entity);
			if(MxkConstant.PART.equals(entity.getTargetType())){
				mog.updateMulti(q, up, PartEntity.class);
			}else if(MxkConstant.SUBJECT.equals(entity.getTargetType())){
				mog.updateMulti(q, up, SubjectEntity.class);
			}
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	
	public boolean checkGiftHasBeenSend(String tragetId,String sendGifttUserId){
		boolean success = false;
		Query q = new Query(Criteria.where("tragetId").is(tragetId).and("sendGifttUserId").is(sendGifttUserId));
	    long num = mog.count(q, UserGiftEntity.class);
	    if(num == 0){
	    	success = true;
	    }
	    return success;
	}
	
	public boolean sendGiftToUser(UserGiftEntity entity){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(entity.getTragetId()));
			Update up = new Update();
			up.inc("gifts", 1);
			mog.save(entity);
			if(MxkConstant.PART.equals(entity.getTragetType())){
				mog.updateMulti(q, up, PartEntity.class);
			}else if(MxkConstant.SUBJECT.equals(entity.getTragetType())){
				mog.updateMulti(q, up, SubjectEntity.class);
			}
			Query qu = new Query(Criteria.where("id").is(entity.getUserid()));
			mog.updateMulti(qu, up, UserEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	
	public List<CommentEntity> findTargetAllComment(String target){
		Query q = new Query(Criteria.where("commentedId").is(target));
		return mog.find(q, CommentEntity.class);
	}
	
	public List<CommentEntity> findNewComments(String commentid){
		Query q = new Query(Criteria.where("commentedId").is(commentid));
		q.sort().on("createTime", Order.DESCENDING);//����
		q.limit(miniPageSize);
		return mog.find(q, CommentEntity.class);
	}
	
	
	public CommentEntity findSingleCommentEntity(String id){
		Query q = new Query(Criteria.where("id").is(id));
		return mog.findOne(q, CommentEntity.class);
	}
	
	public boolean saveCommentEntity(CommentEntity commentEntity){
		boolean success = true;
		try{
			mog.save(commentEntity);
		}catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
	public boolean updateCommentInfo(String id,String info){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(id));
			Update u = new Update();
			u.set("info", info);
			mog.updateMulti(q, u, CommentEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	
	public boolean removeComments(String id){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(id));
			mog.remove(q, CommentEntity.class);
		} catch (Exception e) {
			success = false;
			log.error(e.getMessage(),e);
		}
		return success;
	}
	
	public List<CommentEntity> findCommentEntity(LoadCommentsRequest request){
		List<CommentEntity> list = null;
		try {
			Query q = null;
			Criteria criteria = Criteria.where("commentedId").is(request.getTargeid());
			if(!StringUtil.stringIsEmpty(request.getType())){
				criteria.and("type").is(request.getType());
			}
		    q = new Query(criteria);
			q.sort().on("createTime", Order.DESCENDING);//����
			q.limit(pageSize);
			q.skip(pageSize*(request.getPage() - 1));
			list = mog.find(q, CommentEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return list;
	}
	
	public long findCommentsPage(LoadCommentsRequest request){
		Criteria criteria = Criteria.where("commentedId").is(request.getTargeid());
		if(!StringUtil.stringIsEmpty(request.getType())){
			criteria.and("type").is(request.getType());
		}
		Query q = new Query(criteria);
		long count = mog.count(q, CommentEntity.class);
		if(count != 0){
			return (count + pageSize - 1) / pageSize;
		}else{
			return 0;
		}
	}
	
	public List<CommentEntity> testfindCommentEntity(LoadCommentsRequest request){
		List<CommentEntity> list = null;
		try {
			Query q = null;
			if(StringUtil.stringIsEmpty(request.getType())){
				q = new Query();
			}else{
				q = new Query(Criteria.where("type").is(request.getType()));
			}
			q.sort().on("createTime", Order.DESCENDING);//����
			q.limit(pageSize);
			q.skip(pageSize*(request.getPage() - 1));
			list = mog.find(q, CommentEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return list;
	}
}
