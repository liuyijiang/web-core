package com.mxk.org.common.quartz;

import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.message.domain.MailPushMessage;
import com.mxk.org.common.message.serivce.MxkMessageQueueService;

public class MxkQuartzJobTask {

	@Autowired
	private MxkMessageQueueService messageQueueService;
	
	 public void work() {
		 System.out.println("分发邮件");
		 MailPushMessage mes = new MailPushMessage();
	     mes.setType(MxkConstant.MAIL_TYPE_WEEKPUSH);
		 messageQueueService.startMailTask(mes);
	 }

}
