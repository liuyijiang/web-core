package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class GiftEntity implements Serializable {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = 3384575271940151301L;
	@Id
	private String id;
	private String gifType;
	private String gifImage;
	private String giftName;
	private String gifMessage;
	private int point;//对应分数
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGifType() {
		return gifType;
	}
	public void setGifType(String gifType) {
		this.gifType = gifType;
	}
	public String getGiftName() {
		return giftName;
	}
	public void setGiftName(String giftName) {
		this.giftName = giftName;
	}
	public String getGifMessage() {
		return gifMessage;
	}
	public void setGifMessage(String gifMessage) {
		this.gifMessage = gifMessage;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getGifImage() {
		return gifImage;
	}
	public void setGifImage(String gifImage) {
		this.gifImage = gifImage;
	}
	
	
}
