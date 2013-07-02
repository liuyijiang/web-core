package com.mxk.org.common.service;

import java.util.List;

import com.mxk.org.web.user.domain.UserVO;

public interface MxkRedisCacheService {

	public <T> T getData(String key,Class<T> clzss);
	
	public void setData(String key, Object obj);
	
	public void setUserVO(String key,UserVO vo);
	
	public UserVO getUserVO(String key);
	
	public boolean cachUserRelation(String userid,String friendid);
	
	public boolean cachUserRssSubject(String userid,String subjectid);
	
	public boolean removeCachUserRssSubject(String userid,String subjectid);
	
	public List<String> findUserRssMessageByPage(String userid,int page);
	
	public long findUserRssMessageAllPage(String userid);
}
