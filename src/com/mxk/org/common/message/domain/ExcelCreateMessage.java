package com.mxk.org.common.message.domain;

import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.Session;

import org.springframework.jms.core.MessageCreator;

public class ExcelCreateMessage implements MessageCreator {
   
	private String summaryId;

	@Override
	public Message createMessage(Session session) throws JMSException {
		MapMessage message = session.createMapMessage();
        message.setString("summaryId", summaryId);
		return message;
	}

	public String getSummaryId() {
		return summaryId;
	}

	public void setSummaryId(String summaryId) {
		this.summaryId = summaryId;
	}

     	
	
	
}
