package com.mxk.org.web.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.factory.EntityFactory;
import com.mxk.org.common.factory.VOFactory;
import com.mxk.org.common.util.SecurityUtil;
import com.mxk.org.entity.UserEntity;
import com.mxk.org.web.main.domain.RegisterCheckRequest;
import com.mxk.org.web.user.dao.MxkUserDao;
import com.mxk.org.web.user.dao.MxkUserFriendDao;
import com.mxk.org.web.user.domain.SearchUserResponse;
import com.mxk.org.web.user.domain.SearchUserRssSubjectRequest;
import com.mxk.org.web.user.domain.UserCollectSearchRequest;
import com.mxk.org.web.user.domain.UserLoginRequest;
import com.mxk.org.web.user.domain.UserRegisterRequest;
import com.mxk.org.web.user.domain.UserVO;
import com.mxk.org.web.visitor.domain.CollectPartsRequest;

@Service
public class MxkUserService {

	@Autowired
	private MxkUserDao userDao;
	
	@Autowired
	private MxkUserFriendDao userFriendDao;
	
	public long findUserRssSubjectALlPage(String userid){
		return userDao.findUserRssSubjectALlPage(userid);
	}
	
	public List<String> findUserRssSubjectIdsList(SearchUserRssSubjectRequest searchUserRssSubjectRequest){
		return userDao.findUserRssSubjectIdsList(searchUserRssSubjectRequest.getUserid(),searchUserRssSubjectRequest.getPage());
	}
	
	public long findfindUserByNameCount(String name){
		return userDao.findUserByNameCount(name);
	}
	
	public UserEntity updateUserPassword(String email,String password){
		password = SecurityUtil.digestByMd5(password);
		return userDao.updateUserPassword(email, password);
	}
	
	public List<UserEntity> findAllUsers(){
		return userDao.findAllUsers();
	}
	
	public SearchUserResponse findUserByName(String name,int page){
		SearchUserResponse searchUserResponse = new SearchUserResponse();
		List<UserEntity> list = userDao.findUserByName(name,page);
		searchUserResponse.setPage(page);
		searchUserResponse.setList(list);
		return searchUserResponse;
	}
	
	public SearchUserResponse findUserFirends(String userid,int page,boolean isfollower){
		List<String> ids = userFriendDao.findUserFirendsIds(userid,page,isfollower);
		SearchUserResponse searchUserResponse = new SearchUserResponse();
		if(ids != null){
			List<UserEntity> list = userDao.findUserEntityByIdList(ids);
			searchUserResponse.setPage(page);
			searchUserResponse.setList(list);
		}
		return searchUserResponse;
	}
	
	public long findUserCollectPartsPages(UserCollectSearchRequest userCollectSearchRequest){
		return userDao.findUserCollectPartsPages(userCollectSearchRequest);
	}
	
	public List<String> findUserCollectPartsIds(UserCollectSearchRequest userCollectSearchRequest){
		return userDao.findUserCollectPartsIds(userCollectSearchRequest);
	}
	
	public boolean createUserCollect(CollectPartsRequest collectPartsRequest){
		return userDao.createUserCollect(collectPartsRequest);
	}
	
	public boolean removeUserCollect(CollectPartsRequest collectPartsRequest){
		return userDao.removeUserCollect(collectPartsRequest);
	}
	
	//����user������ id
	public UserVO saveUserEntity(UserRegisterRequest userRegisterRequest) {
		UserEntity userEntity = EntityFactory.createUserEntity(userRegisterRequest);
		UserVO vo = null;
		if(userDao.saveUserEntity(userEntity)){
			vo = VOFactory.createUserVOFormEnitiy(userEntity);
		}
		return vo;
	}
	
	public boolean updateUserEntity(UserRegisterRequest userRegisterRequest){
		return userDao.updateUserEntity(userRegisterRequest);
	}
	
	public UserEntity checkUserLogin(UserLoginRequest userLoginRequest){
		return userDao.checkUser(userLoginRequest.getLoginName(), userLoginRequest.getLoginPass());
	}
	
	//����ͷ��
	public boolean updateUserImage(String userid,String image,String minimage){
		return userDao.updateUserImage(userid,image,minimage);
	}
	
	public boolean checkParmUnique(RegisterCheckRequest registerCheckRequest){
		if(MxkConstant.VALIATE_EMAIL.equals(registerCheckRequest.getType())){
			return userDao.checkUserEmailUnique(registerCheckRequest.getParm());
		}else if(MxkConstant.VALIATE_NAME.equals(registerCheckRequest.getType())){
			if(registerCheckRequest.getParm().equals(registerCheckRequest.getCurrentName())){
				return true;
			}else{
				return userDao.checkUserNameUnique(registerCheckRequest.getParm());
			}
		}else{
			return false;
		}
	}
	
}
