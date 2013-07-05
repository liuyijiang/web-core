package com.mxk.org.common.message.serivce;

import javax.jms.Destination;

import org.apache.activemq.command.ActiveMQQueue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Service;

import com.mxk.org.common.message.domain.DeleteSubjectMessage;
import com.mxk.org.common.message.domain.ExcelCreateMessage;
import com.mxk.org.common.message.domain.NewMessagePushMessage;
import com.mxk.org.common.message.domain.VoiceTransformMessage;

/**
 * 系统各种一步消息处理service
 * @author liuyijiang
 *
 */
@Service
public class MxkMessageQueueService {
  
	@Autowired
	private JmsTemplate jmsTemplate;
	
	@Autowired
	@Qualifier("newrsspushstination")
	private ActiveMQQueue newrsspushstination;//目的地
	
	
	@Autowired
	@Qualifier("deletesubejctstination")
	private ActiveMQQueue deletesubejctstination;//目的地
	
	@Autowired
	@Qualifier("voicetransform")
	private Destination voicetransform;//音频转换目的地
	
	@Autowired
	@Qualifier("excelform")
	private Destination excelform;//excel生成
	
	//音频转换任务
	public void startVioceTransformTask(VoiceTransformMessage message){
		jmsTemplate.send(voicetransform,message);
	}
	
	//excels生成任务
	public void startExcelCreateTask(ExcelCreateMessage message){
		jmsTemplate.send(excelform,message);
	}
	
	public void startNewRssPushTask(NewMessagePushMessage message){
		jmsTemplate.send(newrsspushstination,message);
	}
	
	public void startDeleteSubjectTask(DeleteSubjectMessage message){
		jmsTemplate.send(deletesubejctstination,message);
	}
	
}
