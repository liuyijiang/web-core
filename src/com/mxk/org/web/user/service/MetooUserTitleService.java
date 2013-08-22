package com.mxk.org.web.user.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.common.domain.constant.MetooPointTypeConstant;
import com.mxk.org.entity.UserCertificateEntity;
import com.mxk.org.entity.UserTitleEntity;
import com.mxk.org.web.user.dao.MetooUserCertificateDao;
import com.mxk.org.web.user.dao.MetooUserTitleDao;
import com.mxk.org.web.user.domain.CertificateRespone;

@Service
public class MetooUserTitleService {

	@Autowired
	private MetooUserCertificateDao userCertificateDao;

	@Autowired
	private MetooUserTitleDao userTitleDao;
	
	public boolean saveTitleCertificate(UserCertificateEntity entity){
		return userCertificateDao.saveCertificate(entity);
	}
	
	public CertificateRespone findUserAllCertificate(String userid){
		List<UserCertificateEntity> list = userCertificateDao.findUserCertificateEntity(userid);
		CertificateRespone certificateRespone = null;
		if(list != null && !list.isEmpty()){
			certificateRespone = new CertificateRespone();
			int index = 0;
			List<UserCertificateEntity> list1 = new ArrayList<UserCertificateEntity>();
			List<UserCertificateEntity> list2 = new ArrayList<UserCertificateEntity>();
			List<UserCertificateEntity> list3 = new ArrayList<UserCertificateEntity>();
			List<UserCertificateEntity> list4 = new ArrayList<UserCertificateEntity>();
			certificateRespone.setList1(list1);
			certificateRespone.setList2(list2);
			certificateRespone.setList3(list3);
			certificateRespone.setList4(list4);
			for (UserCertificateEntity cer : list) {
				if(index == 0){
					list1.add(cer);
					index ++ ;
				}
				else if(index == 1){
					list2.add(cer);
					index ++ ;
				}
				else if(index == 2){
					list3.add(cer);
					index ++;
				}else if(index == 3){
					list4.add(cer);
					index = 0;
				}
			}
		}
		return certificateRespone;
	}
	
	public UserTitleEntity findUserTitleEntity(String userid){
	   return userTitleDao.findUserTitleEntity(userid);
    }
	
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
