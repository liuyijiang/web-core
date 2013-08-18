package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
/**
 * �û�ʵ����
 * @author liuyijiang
 *
 */
@Document
public class UserEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1868329679465753638L;
	
	@Id
	private String id;
	private String name;
	private String email;
	private String password;
	private String createTime;
	private String info;//心情
	private String interest;//
	private String image;
	private String minimage;//小头像
	private int sex;//1nman  0woman
	private int level;//等级
	private int followors;//粉丝
	private int focus;//关注
	private int subject;//专辑数
	
	private int parts;
	private int gifts;
	private int eCret;//证书
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
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
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getFollowors() {
		return followors;
	}
	public void setFollowors(int followors) {
		this.followors = followors;
	}
	public int getFocus() {
		return focus;
	}
	public void setFocus(int focus) {
		this.focus = focus;
	}
	public int getSubject() {
		return subject;
	}
	public void setSubject(int subject) {
		this.subject = subject;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public int getParts() {
		return parts;
	}
	public void setParts(int parts) {
		this.parts = parts;
	}
	public int getGifts() {
		return gifts;
	}
	public void setGifts(int gifts) {
		this.gifts = gifts;
	}
	public int geteCret() {
		return eCret;
	}
	public void seteCret(int eCret) {
		this.eCret = eCret;
	}
    	
	
}
