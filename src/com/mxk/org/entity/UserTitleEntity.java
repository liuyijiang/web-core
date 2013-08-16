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
	private int level;
	private long levelPoint;
	private long sharePoint;
	private String shareTitle;
	private String shareTileCode;
	private String shareTileImage;
	private long commentPoint;
	private String commentTitle;
	private String commentTileCode;
	private String commentTileImage;
	private long subjectPoint;
	private String subjectTitle;
	private String subjectTileCode;
	private String subjectTileImage;
	
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
	public String getShareTileCode() {
		return shareTileCode;
	}
	public void setShareTileCode(String shareTileCode) {
		this.shareTileCode = shareTileCode;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getCommentTileCode() {
		return commentTileCode;
	}
	public void setCommentTileCode(String commentTileCode) {
		this.commentTileCode = commentTileCode;
	}
	public String getSubjectTileCode() {
		return subjectTileCode;
	}
	public void setSubjectTileCode(String subjectTileCode) {
		this.subjectTileCode = subjectTileCode;
	}
	public String getShareTileImage() {
		return shareTileImage;
	}
	public void setShareTileImage(String shareTileImage) {
		this.shareTileImage = shareTileImage;
	}
	public String getCommentTileImage() {
		return commentTileImage;
	}
	public void setCommentTileImage(String commentTileImage) {
		this.commentTileImage = commentTileImage;
	}
	public String getSubjectTileImage() {
		return subjectTileImage;
	}
	public void setSubjectTileImage(String subjectTileImage) {
		this.subjectTileImage = subjectTileImage;
	}
	
}
