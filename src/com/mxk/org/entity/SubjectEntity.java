package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * ����ʵ����
 * @author liuyijiang
 *
 */
@Document
public class SubjectEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3679247366419358912L;
	
	@Id
	private String id;
	private String userid;
	private String name;
	private String info;//����
	private String faceimage;//����ͼ
	private String type;//���� PUBLIC PRIVATE FOR-ALL
	private String tags;//
	private String createTime;
	private int comments;//���۴���
	private int attention;//����
	private int level;//����
	private int parts;//part����
	private int joinpeople;//����ר���������
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getFaceimage() {
		return faceimage;
	}
	public void setFaceimage(String faceimage) {
		this.faceimage = faceimage;
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
	public int getComments() {
		return comments;
	}
	public void setComments(int comments) {
		this.comments = comments;
	}
	public int getAttention() {
		return attention;
	}
	public void setAttention(int attention) {
		this.attention = attention;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getParts() {
		return parts;
	}
	public void setParts(int parts) {
		this.parts = parts;
	}
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	public int getJoinpeople() {
		return joinpeople;
	}
	public void setJoinpeople(int joinpeople) {
		this.joinpeople = joinpeople;
	}
    
	

}
