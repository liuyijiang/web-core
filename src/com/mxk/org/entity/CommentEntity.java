package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
/**
 * 评论实体
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
	private String userid;//发出评论的人的id;
	private String userimage;//发出评论的人的头像；
	private String username;//发出评论人的名称
	private String commentedUserId;//被评论的人的id
	private String commentedId;//if part 就是 part id  ruguo subject 就是subject id
	private String info;//评论内容 if text 就死文本 else if wav 就是url
	private String target;//评论源 part or subject
	private String type;//text or wav
	private String createTime;//时间
	private String reply;//如果是回复的话 就是字符串 '回复 xxxx'
	
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
	
	
	
}
