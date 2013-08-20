package com.mxk.org.web.user.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Order;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Component;

import com.mxk.org.entity.UserCertificateEntity;


@Component
public class MetooUserCertificateDao {

	private static final Log log = LogFactory.getLog(MetooUserCertificateDao.class);
	
	@Autowired
	private MongoOperations mog; 
	
	public boolean saveCertificate(UserCertificateEntity entity){
		boolean success = true;
		try {
			mog.save(entity);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
	public List<UserCertificateEntity> findUserCertificateEntity(String userid){
		Query q = new Query(Criteria.where("userid").is(userid));
		q.sort().on("createTime", Order.DESCENDING);
		return mog.find(q, UserCertificateEntity.class);
	}
	
}
