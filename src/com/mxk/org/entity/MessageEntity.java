package com.mxk.org.entity;

import java.io.Serializable;

/**
 * ���û����ۺ� �����һ����Ϣ�����۵���
 * @author liuyijiang
 *
 */
public class MessageEntity implements Serializable {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = 1574003454468699090L;
	
	private String id;
	private String userId;//message ������id
	private String username;
	private String userimage;
	private String targetUserId;//message �յ���id
	private String type;//subject part
	private String targetId;//subject part id
	private int deleteItSelf;//�Զ�ɾ�� 1ɾ�� 0���Զ�ɾ��
	private String mess;
	
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
	public String getMess() {
		return mess;
	}
	public void setMess(String mess) {
		this.mess = mess;
	}
	
	
	
	
}
