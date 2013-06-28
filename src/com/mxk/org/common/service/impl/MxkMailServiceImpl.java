package com.mxk.org.common.service.impl;

import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineFactory;

import com.mxk.org.common.connect.mencache.MemcachSessionLoad;
import com.mxk.org.common.mail.MxkMailSenderInfo;
import com.mxk.org.common.mail.MxkSimpleMailSender;
import com.mxk.org.common.service.MxkMailService;

@Service
public class MxkMailServiceImpl implements MxkMailService {

	private static final Log log = LogFactory.getLog(MxkMailServiceImpl.class);
	
	@Value("${mxk.mail.hostmainl}")
	private String hostmail;
	
	@Value("${mxk.mail.host}")
	private String host;
	
	@Value("${mxk.mail.hostpass}")
	private String  hostpassword;
	
	@Value("${mxk.mail.context}")
	private String context;
	
	@Value("${mxk.mail.title}")
	private String title;
	
	@Autowired
	private MemcachSessionLoad msload;
	
	@Override
	public void sendMail(String toMail) {
		try{
		   String uuid = UUID.randomUUID().toString();
		   msload.setCachData(uuid,toMail);//uuid is key mail is value
		   MxkMailSenderInfo mailInfo = new MxkMailSenderInfo();    
		   mailInfo.setMailServerHost(host);    
	       mailInfo.setMailServerPort("25");    
	       mailInfo.setValidate(true);    
	       mailInfo.setUserName(hostmail);    
	       mailInfo.setPassword(hostpassword);//您的邮箱密码    
	       mailInfo.setFromAddress(hostmail);    
	       mailInfo.setToAddress(toMail);    
	       mailInfo.setSubject(title);    
	       mailInfo.setContent("<a href='"+ context +"showChangePasswordView?usermail="+ toMail +"&uuid="+ uuid +"'>修改密码请在3分钟内完成</a></br>");
	       MxkSimpleMailSender m = new MxkSimpleMailSender();
	       m.sendHtmlMail(mailInfo);
	    }catch(Exception e){
	       log.error(e.getMessage(), e);
	    }		
	}

	@Override
	public boolean checkUuid(String toMail, String uuid, boolean delete) {
		String cashmail = msload.getCachDataAndRemove(uuid,delete);
		if(cashmail != null){
			if(toMail.equals(cashmail)){
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}
	}

	@Override
	public boolean sendTempleteEmail() {
		try{
			   String uuid = UUID.randomUUID().toString();
			   MxkMailSenderInfo mailInfo = new MxkMailSenderInfo();    
			   mailInfo.setMailServerHost(host);    
		       mailInfo.setMailServerPort("25");    
		       mailInfo.setValidate(true);    
		       mailInfo.setUserName(hostmail);    
		       mailInfo.setPassword(hostpassword);//您的邮箱密码    
		       mailInfo.setFromAddress(hostmail);    
		       mailInfo.setToAddress("liuyijiang3430@qq.com");    
		       mailInfo.setSubject(title); 
		       //mailInfo.setContent("<a href='"+ context +"showChangePasswordView?usermail="+ toMail +"&uuid="+ uuid +"'>修改密码请在3分钟内完成</a></br>");
		       MxkSimpleMailSender m = new MxkSimpleMailSender();
		       m.sendHtmlMail(mailInfo);
		    }catch(Exception e){
		       log.error(e.getMessage(), e);
		    }	
		return true;
	}

}
