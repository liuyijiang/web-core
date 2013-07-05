package com.mxk.org.common.message.listener;

import java.util.HashMap;
import java.util.Map;

import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.service.MxkMailService;
import com.mxk.org.common.service.MxkRedisCacheService;
import com.mxk.org.web.user.domain.UserVO;

public class MxkMailPushListener implements MessageListener {

	private static final Log log = LogFactory.getLog(MxkMailPushListener.class);
	
	@Autowired
	private MxkMailService mailService;
	
	@Autowired
	private MxkRedisCacheService redisCacheService;
	
	@Override
	public void onMessage(Message message) {
	   MapMessage m = (MapMessage) message;
	   try{
		  String type = m.getString("type");
		  if(MxkConstant.MAIL_TYPE_REGISTER.equals(type)){
			  String target = m.getString("target");
			  UserVO vo = redisCacheService.getUserVO(target);
			  if(vo != null){
				  pushUserRegistSuccessMail(vo); 
			  }
		  }else if(MxkConstant.MAIL_TYPE_WEEKPUSH.equals(type)){
			  
		  }
	   } catch (Exception e){
			log.error(e.getMessage(),e);
	   }   
		
	}
	
	private void pushUserRegistSuccessMail(UserVO vo){
		Map<String,String> map = new HashMap<String,String>();
		map.put("image",vo.getImage());
		map.put("username", vo.getName());
		map.put("userinfo", vo.getInfo());
		
		mailService.sendTempleteEmail("米兔新用户注册",vo.getEmail(),map);
	}
	

}
