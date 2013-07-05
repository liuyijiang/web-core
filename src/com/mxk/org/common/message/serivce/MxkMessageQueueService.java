package com.mxk.org.common.message.serivce;

import javax.jms.Destination;

import org.apache.activemq.command.ActiveMQQueue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Service;

import com.mxk.org.common.message.domain.DeleteSubjectMessage;
import com.mxk.org.common.message.domain.ExcelCreateMessage;
import com.mxk.org.common.message.domain.MailPushMessage;
import com.mxk.org.common.message.domain.NewMessagePushMessage;
import com.mxk.org.common.message.domain.VoiceTransformMessage;

/**
 * 消息队列service 
 * @author liuyijiang
 *
 */
@Service
public class MxkMessageQueueService {
  
	@Autowired
	private JmsTemplate jmsTemplate;
	
	@Autowired
	@Qualifier("newrsspushstination")
	private ActiveMQQueue newrsspushstination;
	
	@Autowired
	@Qualifier("mailform")
	private Destination mailform;
	
	@Autowired
	@Qualifier("deletesubejctstination")
	private ActiveMQQueue deletesubejctstination;
	
	@Autowired
	@Qualifier("voicetransform")
	private Destination voicetransform;
	
	@Autowired
	@Qualifier("excelform")
	private Destination excelform;
	
	//wav转换为mp3
	public void startVioceTransformTask(VoiceTransformMessage message){
		jmsTemplate.send(voicetransform,message);
	}
	
	//excels
	public void startExcelCreateTask(ExcelCreateMessage message){
		jmsTemplate.send(excelform,message);
	}
	
	//
	public void startNewRssPushTask(NewMessagePushMessage message){
		jmsTemplate.send(newrsspushstination,message);
	}
	
	public void startDeleteSubjectTask(DeleteSubjectMessage message){
		jmsTemplate.send(deletesubejctstination,message);
	}
	
	public void startMailTask(MailPushMessage message){
		jmsTemplate.send(mailform,message);
	}
}
