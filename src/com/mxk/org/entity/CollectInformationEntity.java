package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * 收藏信息
 * @author Administrator
 *
 */
@Document
public class CollectInformationEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 488677473701496932L;
	
	@Id
	private String id;
	private String tragetId;
	private String createTime;
	private String collecterName;//收藏者 name
	private String collecterImg;//收藏者 img
	private String collecterId;//收藏者id
	private String pin;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTragetId() {
		return tragetId;
	}
	public void setTragetId(String tragetId) {
		this.tragetId = tragetId;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getCollecterName() {
		return collecterName;
	}
	public void setCollecterName(String collecterName) {
		this.collecterName = collecterName;
	}
	public String getCollecterImg() {
		return collecterImg;
	}
	public void setCollecterImg(String collecterImg) {
		this.collecterImg = collecterImg;
	}
	public String getCollecterId() {
		return collecterId;
	}
	public void setCollecterId(String collecterId) {
		this.collecterId = collecterId;
	}
	public String getPin() {
		return pin;
	}
	public void setPin(String pin) {
		this.pin = pin;
	}
    
	
	
}
