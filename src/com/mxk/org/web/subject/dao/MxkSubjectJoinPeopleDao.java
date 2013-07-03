package com.mxk.org.web.subject.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Order;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Component;

import com.mxk.org.entity.SubjectJoinPeopleEntity;

@Component
public class MxkSubjectJoinPeopleDao {
	
	private static final Log log = LogFactory.getLog(MxkSubjectJoinPeopleDao.class);
	
	@Value("${mxk.page.pagesize}")
	private int pageSize;
	
	@Autowired
	private MongoOperations mog; 
	
	public long findSubjectJoinerAllPage(String subjectid){
		Query q = new Query(Criteria.where("subjectid").is(subjectid));
		long count = mog.count(q, SubjectJoinPeopleEntity.class);
		if(count != 0){
			return (count + pageSize - 1) / pageSize;
		}else{
			return 0;
		}
	}
	
	public List<SubjectJoinPeopleEntity> findSubjectJoinerByPage(String subjectid,int page){
		List<SubjectJoinPeopleEntity> list = null;
		try {
			Query q = new Query(Criteria.where("subjectid").is(subjectid));
			q.limit(pageSize);
			q.skip(pageSize * (page - 1));
			list = mog.find(q, SubjectJoinPeopleEntity.class);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
		return list; 
	}
	
	public List<String> findUserJoinSubjectIds(String userid,int page){
		List<String> ids = null;
		Query q = new Query(Criteria.where("userid").is(userid));
		q.sort().on("createTime", Order.DESCENDING);//ÉýÐò
		q.limit(pageSize);
		q.skip(pageSize*(page - 1));
		List<SubjectJoinPeopleEntity> list = mog.find(q, SubjectJoinPeopleEntity.class);
		if(list != null){
			ids = new ArrayList<String>();
			for (SubjectJoinPeopleEntity p : list) {
				ids.add(p.getSubjectid());
			}
		}
		return ids;
	}
	
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
	
	public long findUserJoinSubject(String userid){
		Query q = new Query(Criteria.where("userid").is(userid));
		return mog.count(q, SubjectJoinPeopleEntity.class);
	}
	
	public long findUserJoinSubjectAllPage(String userid){
		Query q = new Query(Criteria.where("userid").is(userid));
		long count = mog.count(q, SubjectJoinPeopleEntity.class);
		if(count != 0){
			return (count + pageSize - 1) / pageSize;
		}else{
			return 0;
		}
	}
}
