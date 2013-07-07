package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
/**
 * ����ʵ��
 * @author liuyijiang
 *
 */
@Document
public class CommentEntity implements Serializable {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = 235652964568833050L;
	
	@Id
	private String id;
	private String userid;//�������۵��˵�id;
	private String userimage;//�������۵��˵�ͷ��
	private String username;//���������˵����
	private String commentedUserId;//�����۵��˵�id
	private String commentedId;//if part ���� part id  ruguo subject ����subject id
	private String info;//如果if text else if wav ����url
	private String target;//评论的目标part or subject
	private String type;//text or wav
	private String createTime;//时间
	private String reply;//评论还是 回复
	private String replyUserId;
	private String replyUserName;
	private String replyUserImage;
	
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
	public String getUserimage() {
		return userimage;
	}
	public void setUserimage(String userimage) {
		this.userimage = userimage;
	}
	public String getCommentedUserId() {
		return commentedUserId;
	}
	public void setCommentedUserId(String commentedUserId) {
		this.commentedUserId = commentedUserId;
	}
	public String getCommentedId() {
		return commentedId;
	}
	public void setCommentedId(String commentedId) {
		this.commentedId = commentedId;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getReplyUserId() {
		return replyUserId;
	}
	public void setReplyUserId(String replyUserId) {
		this.replyUserId = replyUserId;
	}
	public String getReplyUserName() {
		return replyUserName;
	}
	public void setReplyUserName(String replyUserName) {
		this.replyUserName = replyUserName;
	}
	public String getReplyUserImage() {
		return replyUserImage;
	}
	public void setReplyUserImage(String replyUserImage) {
		this.replyUserImage = replyUserImage;
	}
	
	
	
}
