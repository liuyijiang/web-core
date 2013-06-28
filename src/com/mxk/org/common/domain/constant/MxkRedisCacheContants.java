package com.mxk.org.common.domain.constant;
/**
 * redis 常量
 * @author liuyijiang
 *
 */
public class MxkRedisCacheContants {

	public static final String KEY_USER = "user"; //id + key_user 組合 生成uservo的key 
	
	public static final String KEY_USER_FOLLOWER = "follower";//id + key_user_follower 组成一个可set(userid)的key 保存用户的粉丝id
	
	public static final String KEY_USER_FOUCSER = "foucser";//id + key_user_foucser 组成一个可set(userid)的key 保存用户的关注者id
			
	public static final String KEY_USER_FOUCS = "foucs"; //用户的关注 当好友发布part 会推送信息到没有follower的关注list中
	
	public static final String KEY_SUBJECT_FOUCS = "subjecter";//关注subject后会将关注者的id放入set中
	
}
