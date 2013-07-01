package com.mxk.org.common.message.domain;

import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.Session;

import org.springframework.jms.core.MessageCreator;

public class NewMessagePushMessage implements MessageCreator {
   
	private String tragetId; //part µÄ id
	private String userid;
	
	@Override
	public Message createMessage(Session session) throws JMSException {
		MapMessage message = session.createMapMessage();
        message.setString("tragetId", tragetId);
        message.setString("userid", userid);
		return message;
	}
	
	public String getTragetId() {
		return tragetId;
	}
	public void setTragetId(String tragetId) {
		this.tragetId = tragetId;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	
}
