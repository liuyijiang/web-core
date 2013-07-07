package com.mxk.org.web.comments.domain;

public class CommentsAddRequest {
  
	private String commentedUserId;
	private String commentedId;
	private String target;
	private String info;
	private String type;
	
	private String userid;
	private String userimage;
	private String username;
	private String reply;
	private String replyUserId;
	private String replyUserName;
	private String replyUserImage;
	
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
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
