package com.mxk.org.web.comments.domain;

public class SendGiftRequest {
	
	private String sendGifttToUserId;
	private String targetId;
	private String type;
	
	public String getTargetId() {
		return targetId;
	}
	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSendGifttToUserId() {
		return sendGifttToUserId;
	}
	public void setSendGifttToUserId(String sendGifttToUserId) {
		this.sendGifttToUserId = sendGifttToUserId;
	}
	
	
	
}
