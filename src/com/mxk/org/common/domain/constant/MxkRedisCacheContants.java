package com.mxk.org.common.domain.constant;
/**
 * redis ����
 * @author liuyijiang
 *
 */
public class MxkRedisCacheContants {

	public static final String KEY_USER = "user"; //id + key_user �M�� ����uservo��key 
	
	public static final String KEY_USER_FOLLOWER = "follower";//id + key_user_follower ���һ����set(userid)��key �����û��ķ�˿id
	
	public static final String KEY_USER_FOUCSER = "foucser";//id + key_user_foucser ���һ����set(userid)��key �����û��Ĺ�ע��id
			
	public static final String KEY_USER_FOUCS = "foucs"; //�û��Ĺ�ע �����ѷ���part ��������Ϣ��û��follower�Ĺ�עlist��
	
	public static final String KEY_SUBJECT_FOUCS = "subjecter";//��עsubject��Ὣ��ע�ߵ�id����set��
	
}
