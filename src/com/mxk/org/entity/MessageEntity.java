package com.mxk.org.entity;

import java.io.Serializable;

/**
 * 当用户评论后 会生成一个消息给被评论的人
 * @author liuyijiang
 *
 */
public class MessageEntity implements Serializable {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = 1574003454468699090L;
	
	private String id;
	private String userId;//message 发起人id
	private String username;
	private String userimage;
	private String targetUserId;//message 收到人id
	private String type;//subject part
	private String targetId;//subject part id
	private int deleteItSelf;//自动删除 1删除 0不自动删除
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTargetUserId() {
		return targetUserId;
	}
	public void setTargetUserId(String targetUserId) {
		this.targetUserId = targetUserId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTargetId() {
		return targetId;
	}
	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}
	public int getDeleteItSelf() {
		return deleteItSelf;
	}
	public void setDeleteItSelf(int deleteItSelf) {
		this.deleteItSelf = deleteItSelf;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserimage() {
		return userimage;
	}
	public void setUserimage(String userimage) {
		this.userimage = userimage;
	}
	
	
	
	
}
