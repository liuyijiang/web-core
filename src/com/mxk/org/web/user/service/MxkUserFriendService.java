package com.mxk.org.web.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.entity.UserFriendEntity;
import com.mxk.org.web.user.dao.MxkUserFriendDao;

@Service
public class MxkUserFriendService {

	@Autowired
	private MxkUserFriendDao dao;
	
	public boolean checkUserRelationShip(String userId,String checkedUserId){
		return dao.checkUserRelationShip(userId, checkedUserId);
	}
	
	public boolean createUserRelation(UserFriendEntity user){
		return dao.createUserRelation(user);
	}
	
	public boolean removeUserRelation(UserFriendEntity user){
	     return dao.removeUserRelation(user);
	}
	
}
