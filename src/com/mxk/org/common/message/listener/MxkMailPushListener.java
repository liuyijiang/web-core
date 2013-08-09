package com.mxk.org.common.message.listener;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import com.mxk.org.common.util.StringUtil;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.UserEntity;
import com.mxk.org.web.part.service.MxkPartService;
import com.mxk.org.web.user.domain.UserVO;
import com.mxk.org.web.user.service.MxkUserService;

public class MxkMailPushListener implements MessageListener {

	private static final Log log = LogFactory.getLog(MxkMailPushListener.class);
	
	@Autowired
	private MxkMailService mailService;
	
	@Autowired
	private MxkRedisCacheService redisCacheService;
	
	@Autowired
	private MxkPartService partService;
	
	@Autowired
	private MxkUserService userService;
	
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
			  pushAllUserPartsCollectHigh();
		  }
	   } catch (Exception e){
		   e.printStackTrace();
			log.error(e.getMessage(),e);
	   }   
		
	}
	
	private void pushUserRegistSuccessMail(UserVO vo){
		Map<String,String> map = new HashMap<String,String>();
		map.put("image",vo.getImage());
		map.put("username", vo.getName());
		map.put("userinfo", vo.getInfo());
		mailService.sendTempleteEmail("米兔Metoo 新用户注册",vo.getEmail(),map,"mailtemplate/regist_success_template.vm");
	}
	
	//每周5发送邮件
	public void pushAllUserPartsCollectHigh(){
		//1 查询本周最后的8条 
		Date end = new Date();
		Calendar rightNow = Calendar.getInstance();
	    rightNow.setTime(end);
	    rightNow.add(Calendar.DAY_OF_YEAR,-7);
	    Date start =rightNow.getTime();
	    String startTime = StringUtil.dateToString(start, null);
	    String endTime = StringUtil.dateToString(end, null);
	    List<PartEntity> list = partService.findCollectHighPartsByTime(startTime, endTime,8);
	    List<UserEntity> ulist = userService.findAllUsers();
	    Map<String,String> map = new HashMap<String,String>();
	    for(int i=0 ;i<list.size();i++){
	    	PartEntity p = list.get(i);
	    	int num=i+1;
	    	map.put("id"+num, p.getId());
	    	map.put("image"+num, p.getMinimage());
	    	map.put("desc"+num, p.getDesc());
	    	map.put("info"+num, "收藏"+p.getCollect()+"次  | 评论"+ (p.getAudios()+p.getComments()) + "次");
	    }
	    for(UserEntity u:ulist){
	    	map.put("username", u.getName());
	    	String mail = u.getEmail();
	    	String host = mail.substring(mail.indexOf("@")+1,mail.lastIndexOf("."));
	    	if(!"xt".equals(host)){
	    		mailService.sendTempleteEmail("米兔Metoo 周末精选",u.getEmail(),map,"mailtemplate/weekpush_template.vm");	
	    	}
	    }
	}

}
