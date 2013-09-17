package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * part
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
	private String type;//�̳�subject
	private String image;
	private String minimage;
	private String createTime;
	private int collect;//�ղش���
	private int comments;//���۴���
	private int audios;//��Ƶ����
	
	private String username;//���� �û����
	private String userimage;//���� �û�ͷ��
	private String status;//PUBLIC FOR-ALL
	private String shadow;//影子css
	
	private int gifts;
	private int likes;
	private int highPoint;
	private int highPointTime;//评分次数
	
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
	public String getShadow() {
		return shadow;
	}
	public void setShadow(String shadow) {
		this.shadow = shadow;
	}
	public int getGifts() {
		return gifts;
	}
	public void setGifts(int gifts) {
		this.gifts = gifts;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getHighPoint() {
		return highPoint;
	}
	public void setHighPoint(int highPoint) {
		this.highPoint = highPoint;
	}
	public int getHighPointTime() {
		return highPointTime;
	}
	public void setHighPointTime(int highPointTime) {
		this.highPointTime = highPointTime;
	}
	
	
}
