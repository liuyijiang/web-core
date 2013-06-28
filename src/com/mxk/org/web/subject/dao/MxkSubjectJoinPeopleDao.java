package com.mxk.org.web.subject.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Order;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Component;

import com.mxk.org.entity.SubjectJoinPeopleEntity;

@Component
public class MxkSubjectJoinPeopleDao {
	
	private static final Log log = LogFactory.getLog(MxkSubjectJoinPeopleDao.class);
	
	@Autowired
	private MongoOperations mog; 
	
	public List<SubjectJoinPeopleEntity> findTop5SubjectJoiner(String subjectid){
		List<SubjectJoinPeopleEntity> list = null;
		try {
			Query q = new Query(Criteria.where("subjectid").is(subjectid));
			q.limit(5);
			q.sort().on("parts", Order.DESCENDING);//½µ
			list = mog.find(q, SubjectJoinPeopleEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return list;
	}
	
}
