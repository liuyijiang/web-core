package com.mxk.org.web.system.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.stereotype.Component;

import com.mxk.org.entity.GiftEntity;

@Component
public class MetooSystemDao {
  
	@Autowired
	private MongoOperations mog; 
	
	public void createGift(GiftEntity entity){
		mog.save(entity);
	}
	
}
