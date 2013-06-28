package com.mxk.org.common.message.serivce;

import javax.jms.Destination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Service;

import com.mxk.org.common.message.domain.ExcelCreateMessage;
import com.mxk.org.common.message.domain.VoiceTransformMessage;

/**
 * ϵͳ����һ����Ϣ����service
 * @author liuyijiang
 *
 */
@Service
public class MxkMessageQueueService {
  
	@Autowired
	private JmsTemplate jmsTemplate;
	
	@Autowired
	@Qualifier("voicetransform")
	private Destination voicetransform;//��Ƶת��Ŀ�ĵ�
	
	@Autowired
	@Qualifier("excelform")
	private Destination excelform;//excel����
	
	//��Ƶת������
	public void startVioceTransformTask(VoiceTransformMessage message){
		jmsTemplate.send(voicetransform,message);
	}
	
	public void startExcelCreateTask(ExcelCreateMessage message){
		jmsTemplate.send(excelform,message);
	}
}
