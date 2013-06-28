package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
/**
 * 关系实体
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
	private String userid;//用户id   索引
	private String friendid;//粉丝id  索引
	
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
