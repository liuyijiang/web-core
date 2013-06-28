package com.mxk.org.web.comments.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Component;

import com.mxk.org.entity.MessageEntity;

@Component
public class MxkMessageDao {

	@Value("${mxk.page.big.pagesize}")
	private int pageSize;
	
	private static final Log log = LogFactory.getLog(MxkMessageDao.class);

	@Autowired
	private MongoOperations mog; 
	
	public boolean createMessage(MessageEntity messageEntity) {
		boolean success = true;
		try {
		    mog.save(messageEntity);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
	public MessageEntity findMessageEntityById(String id){
		Query q = new Query(Criteria.where("id").is(id));
		return mog.findOne(q, MessageEntity.class);
	}
	
	public boolean removeMesage(String id){
		boolean success = true;
		try {
			Query q = new Query(Criteria.where("id").is(id));
			mog.remove(q, MessageEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
	public long findMessageCount(String userid){
		long num = 0;
		try{
			Query q = new Query(Criteria.where("targetUserId").is(userid));
			num = mog.count(q, MessageEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return num;
	}
	
	public List<MessageEntity> findMessageEntity(String userid,int page){
		List<MessageEntity> list = null;
		try{
			Query q = new Query(Criteria.where("targetUserId").is(userid));
			q.limit(pageSize);
			q.skip(pageSize*(page - 1));
			list = mog.find(q, MessageEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return list;
	}
	
}
