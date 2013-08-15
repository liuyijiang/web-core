package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class UserGiftEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1075596102886736031L;
	
	@Id
	private String id;
	private String giftType;
	private String userid;
	private String sendGifttUserId;
	private String sendGiftUserName;
	private String sendGiftUserImage;
	private String tragetType;
	private String tragetId;
	private String sendGiftTime;
	private String gifImage;
	private String giftName;
	private String gifMessage;
	private int used;//1 0
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGiftType() {
		return giftType;
	}
	public void setGiftType(String giftType) {
		this.giftType = giftType;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSendGiftUserName() {
		return sendGiftUserName;
	}
	public void setSendGiftUserName(String sendGiftUserName) {
		this.sendGiftUserName = sendGiftUserName;
	}
	public String getSendGiftUserImage() {
		return sendGiftUserImage;
	}
	public void setSendGiftUserImage(String sendGiftUserImage) {
		this.sendGiftUserImage = sendGiftUserImage;
	}
	public String getTragetType() {
		return tragetType;
	}
	public void setTragetType(String tragetType) {
		this.tragetType = tragetType;
	}
	public String getTragetId() {
		return tragetId;
	}
	public void setTragetId(String tragetId) {
		this.tragetId = tragetId;
	}
	public String getSendGiftTime() {
		return sendGiftTime;
	}
	public void setSendGiftTime(String sendGiftTime) {
		this.sendGiftTime = sendGiftTime;
	}
	public int getUsed() {
		return used;
	}
	public void setUsed(int used) {
		this.used = used;
	}
	public String getSendGifttUserId() {
		return sendGifttUserId;
	}
	public void setSendGifttUserId(String sendGifttUserId) {
		this.sendGifttUserId = sendGifttUserId;
	}
	public String getGifImage() {
		return gifImage;
	}
	public void setGifImage(String gifImage) {
		this.gifImage = gifImage;
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
	
	
	
}
