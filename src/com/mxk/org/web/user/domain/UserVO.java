package com.mxk.org.web.user.domain;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
/**
 * userentity 的值對象 隱藏password
 * @author liuyijiang
 *
 */
public class UserVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4072865054588251284L;
	
	@Id
	private String id;
	private String name;
	private String email;
	private String createTime;
	private String info;//个人描述
	private String interest;//星球
	private String image;
	private String minimage;//大图
	private int sex;//1nman  0woman
	private int level;//等级
	private int followors;//粉丝数量
	private int focus;//关注数量
	private int subject;//专题数量
	
	private long message;//提醒
	private long joinsubject;
	private long rsssubject;
	
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
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
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
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
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
	public long getMessage() {
		return message;
	}
	public void setMessage(long message) {
		this.message = message;
	}
	public long getJoinsubject() {
		return joinsubject;
	}
	public void setJoinsubject(long joinsubject) {
		this.joinsubject = joinsubject;
	}
	public long getRsssubject() {
		return rsssubject;
	}
	public void setRsssubject(long rsssubject) {
		this.rsssubject = rsssubject;
	}
	
	
}
