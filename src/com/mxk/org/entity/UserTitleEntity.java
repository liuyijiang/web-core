package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class UserTitleEntity implements Serializable {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = -4997298154309276238L;
	@Id
	private String id;
	private String userid;
	private String level;
	private long levelPoint;
	private long sharePoint;
	private String shareTitle;
	private long commentPoint;
	private String commentTitle;
	private long subjectPoint;
	private String subjectTitle;
	
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
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public long getLevelPoint() {
		return levelPoint;
	}
	public void setLevelPoint(long levelPoint) {
		this.levelPoint = levelPoint;
	}
	public long getSharePoint() {
		return sharePoint;
	}
	public void setSharePoint(long sharePoint) {
		this.sharePoint = sharePoint;
	}
	public String getShareTitle() {
		return shareTitle;
	}
	public void setShareTitle(String shareTitle) {
		this.shareTitle = shareTitle;
	}
	public long getCommentPoint() {
		return commentPoint;
	}
	public void setCommentPoint(long commentPoint) {
		this.commentPoint = commentPoint;
	}
	public String getCommentTitle() {
		return commentTitle;
	}
	public void setCommentTitle(String commentTitle) {
		this.commentTitle = commentTitle;
	}
	public long getSubjectPoint() {
		return subjectPoint;
	}
	public void setSubjectPoint(long subjectPoint) {
		this.subjectPoint = subjectPoint;
	}
	public String getSubjectTitle() {
		return subjectTitle;
	}
	public void setSubjectTitle(String subjectTitle) {
		this.subjectTitle = subjectTitle;
	}
	
	
	
}
