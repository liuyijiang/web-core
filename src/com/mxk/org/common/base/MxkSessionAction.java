package com.mxk.org.common.base;

import java.util.UUID;

import javax.servlet.http.Cookie;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.connect.mencache.MemcachSessionLoad;
import com.mxk.org.common.domain.session.MxkSessionContext;
import com.mxk.org.common.domain.web.CurrentlyBrowsingPagesRespone;
import com.mxk.org.common.service.MxkRedisCacheService;
import com.mxk.org.common.util.StringUtil;
import com.mxk.org.web.user.domain.UserVO;

/**
 * 分布式session 缓存action
 * @author liuyijiang
 *
 */
public class MxkSessionAction extends MxkBaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4952377440708219233L;

	@Autowired
	private MxkSessionContext sessionContext;
   
	@Autowired
	private MemcachSessionLoad msload;
	
	@Autowired
	private MxkRedisCacheService redisCacheService;
	
	public void setSessionPage(CurrentlyBrowsingPagesRespone reposne){
		String mxkjsesson = UUID.randomUUID().toString();
		Cookie cook = new Cookie(MxkSessionContext.MXK_PAGE_JSEESION,mxkjsesson);
		cook.setPath("/");
		ServletActionContext.getResponse().addCookie(cook);//MXK_PAGE_SESSION
		JSONObject jb = JSONObject.fromObject(reposne);
		sessionContext.getKey().put(MxkSessionContext.MXK_PAGE_SESSION, mxkjsesson);
		msload.setSessionData(sessionContext.getKey().get(MxkSessionContext.MXK_PAGE_SESSION), jb.toString());
	}
	
	public CurrentlyBrowsingPagesRespone getSessionPage(){
		String key = sessionContext.getKey().get(MxkSessionContext.MXK_PAGE_SESSION);
		CurrentlyBrowsingPagesRespone res = null;
		if(!StringUtil.stringIsEmpty(key)){
			String respon = msload.getSessionData(key);
			if(respon != null){
				JSONObject json = JSONObject.fromObject(respon);
				res = (CurrentlyBrowsingPagesRespone)JSONObject.toBean(json,CurrentlyBrowsingPagesRespone.class);
			}
		}
		return res;
	}
	
	public void removePageSession(){
		Cookie cook = new Cookie(MxkSessionContext.MXK_PAGE_JSEESION,"");
		cook.setPath("/");
		ServletActionContext.getResponse().addCookie(cook);//����վ�����key
	}
	
	public void removeSession(){
		Cookie cook = new Cookie(MxkSessionContext.MXK_JSEESION,"");
		cook.setPath("/");
		ServletActionContext.getResponse().addCookie(cook);//����վ�����key
	}
	
	public String getSessionKey(){
		String key = sessionContext.getKey().get(MxkSessionContext.MXK_SESSION);
		String userid = null;
		if(!StringUtil.stringIsEmpty(key)){
			userid = msload.getSessionData(key);
		}
		return userid;
	}
	
	public void setSessionKey(String str){
		String mxkjsesson = UUID.randomUUID().toString();
		Cookie cook = new Cookie(MxkSessionContext.MXK_JSEESION,mxkjsesson);
		cook.setPath("/");
		ServletActionContext.getResponse().addCookie(cook);//
		sessionContext.getKey().put(MxkSessionContext.MXK_SESSION, mxkjsesson);
		msload.setSessionData(sessionContext.getKey().get(MxkSessionContext.MXK_SESSION), str);
	}
	
	public void updateCurrentUserVO(UserVO vo){
		redisCacheService.setUserVO(vo.getId(), vo);
	}
	
	public UserVO getCurrentUserVO(){
		String userid = getSessionKey();
		return redisCacheService.getUserVO(userid);
	}
	
	public UserVO getCachedUserVO(String userid){
		return redisCacheService.getUserVO(userid);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public <T> T getSessionData(String key, Class beanClass){
		String jsessionid = sessionContext.getKey().get(MxkSessionContext.MXK_SESSION);
		JSONObject json = JSONObject.fromObject(msload.getSessionData(jsessionid+key));
		return (T)JSONObject.toBean(json,beanClass);
	}
	
	public void setSessionData(String key,Object obj){
		JSONObject jb = JSONObject.fromObject(obj);
		String jsessionid = sessionContext.getKey().get(MxkSessionContext.MXK_SESSION);
		msload.setSessionData(jsessionid+key, jb.toString());
	}

}
