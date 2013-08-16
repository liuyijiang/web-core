package com.mxk.org.web.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.common.domain.constant.MetooPointTypeConstant;
import com.mxk.org.entity.UserTitleEntity;
import com.mxk.org.web.user.dao.MetooUserTitleDao;

@Service
public class MetooUserTitleService {


	@Autowired
	private MetooUserTitleDao userTitleDao;
	
	public boolean upgradeUserTile(String userid,int type){
		boolean success = true;
		switch (type) {
		   case 1:
			   success = userTitleDao.upgradeUserShareTile(userid, MetooPointTypeConstant.METOO_POINT_TYPE_PART);
			   break;
		   case 2:
			   success = userTitleDao.upgradeUserShareTile(userid, MetooPointTypeConstant.METOO_POINT_TYPE_COMMENT);
			   break;
		   case 3:
			   success = userTitleDao.upgradeUserShareTile(userid, MetooPointTypeConstant.METOO_POINT_TYPE_SUBJECT);
			   break;
		   default:
			   success = userTitleDao.upgradeUserShareTile(userid, MetooPointTypeConstant.METOO_POINT_TYPE_PART);
		}
		return success;
	}
	
	public boolean saveUserTitle(UserTitleEntity entity){
		return userTitleDao.saveUserTitle(entity);
	}
	
	public void updatePoint(String userid,MetooPointTypeConstant type,boolean isadd,boolean isbase){
		userTitleDao.updatePoint(userid, type, isadd, isbase);
	}
	
}
