package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * 分部实体类 
 * @author liuyijiang
 *
 */
@Document
public class PartEntity implements Serializable {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = 6227118969452659807L;
	
	@Id
	private String id;
	private String userid;
	private String subjectid;
	private String subname;
	private String desc;
	private String type;//继承subject
	private String image;
	private String minimage;
	private String createTime;
	private int collect;//收藏次数
	private int comments;//评论次数
	private int audios;//音频次数
	
	private String username;//冗余 用户名称
	private String userimage;//冗余 用户头像
	private String status;//PUBLIC FOR-ALL
	
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
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}
	public String getSubname() {
		return subname;
	}
	public void setSubname(String subname) {
		this.subname = subname;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getMinimage() {
		return minimage;
	}
	public void setMinimage(String minimage) {
		this.minimage = minimage;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public int getCollect() {
		return collect;
	}
	public void setCollect(int collect) {
		this.collect = collect;
	}
	public int getComments() {
		return comments;
	}
	public void setComments(int comments) {
		this.comments = comments;
	}
	public int getAudios() {
		return audios;
	}
	public void setAudios(int audios) {
		this.audios = audios;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
