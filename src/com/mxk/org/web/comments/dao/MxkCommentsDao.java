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

import com.mxk.org.entity.CommentEntity;
import com.mxk.org.web.comments.domain.LoadCommentsRequest;

@Component
public class MxkCommentsDao {

	private static final Log log = LogFactory.getLog(MxkCommentsDao.class);
	
	@Value("${mxk.page.pagesize}")
	private int pageSize;
	
	@Autowired
	private MongoOperations mog; 
	
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
			Query q = new Query(Criteria.where("commentedId").is(request.getTargeid()).and("type").is(request.getType()));
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
