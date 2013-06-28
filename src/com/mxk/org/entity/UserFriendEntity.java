package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
/**
 * ��ϵʵ��
 * @author liuyijiang
 *
 */
@Document
public class UserFriendEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2853147018779683344L;
	
	@Id
	private String id;
	private String userid;//�û�id   ����
	private String friendid;//��˿id  ����
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getFriendid() {
		return friendid;
	}
	public void setFriendid(String friendid) {
		this.friendid = friendid;
	}
	
}
