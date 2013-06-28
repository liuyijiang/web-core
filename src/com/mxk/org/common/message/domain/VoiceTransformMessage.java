package com.mxk.org.common.message.domain;

import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.Session;

import org.springframework.jms.core.MessageCreator;

public class VoiceTransformMessage implements MessageCreator {
  
	private String trageId;
	private String wavUrl;
	
	@Override
	public Message createMessage(Session session) throws JMSException {
		MapMessage message = session.createMapMessage();
        message.setString("trageId", trageId);
        message.setString("wavUrl", wavUrl);
		return message;
	}

	public String getTrageId() {
		return trageId;
	}

	public void setTrageId(String trageId) {
		this.trageId = trageId;
	}

	public String getWavUrl() {
		return wavUrl;
	}

	public void setWavUrl(String wavUrl) {
		this.wavUrl = wavUrl;
	}
	
	
	
}
