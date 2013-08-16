package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class SubjectPriceEntity implements Serializable {
  
	/**
	 * 
	 */
	private static final long serialVersionUID = -2128859046696353017L;
	
	@Id
	private String id;
	private String subjectid;
	private String setPriceUserId;
	private String setPriceUserName;
	private String setPriceUserImage;
	private double money;
	private String createTime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}
	public String getSetPriceUserId() {
		return setPriceUserId;
	}
	public void setSetPriceUserId(String setPriceUserId) {
		this.setPriceUserId = setPriceUserId;
	}
	public String getSetPriceUserName() {
		return setPriceUserName;
	}
	public void setSetPriceUserName(String setPriceUserName) {
		this.setPriceUserName = setPriceUserName;
	}
	public String getSetPriceUserImage() {
		return setPriceUserImage;
	}
	public void setSetPriceUserImage(String setPriceUserImage) {
		this.setPriceUserImage = setPriceUserImage;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	
	
}
