package com.mxk.org.common.mail;

import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class MxkSimpleMailSender {

	
	public boolean sendTextMail(MxkMailSenderInfo mailInfo) {    
	      MxkMailAuthenticator authenticator = null;    
	      Properties pro = mailInfo.getProperties();   
	      if (mailInfo.isValidate()) {    
	        authenticator = new MxkMailAuthenticator(mailInfo.getUserName(), mailInfo.getPassword());    
	      }   
	      Session sendMailSession = Session.getDefaultInstance(pro,authenticator);    
	      try {    
	      Message mailMessage = new MimeMessage(sendMailSession);    
	      Address from = new InternetAddress(mailInfo.getFromAddress());    
	      mailMessage.setFrom(from);    
	      Address to = new InternetAddress(mailInfo.getToAddress());    
	      mailMessage.setRecipient(Message.RecipientType.TO,to);    
	      mailMessage.setSubject(mailInfo.getSubject());    
	      mailMessage.setSentDate(new Date());    
	      String mailContent = mailInfo.getContent();    
	      mailMessage.setText(mailContent);    
	      Transport.send(mailMessage);   
	      return true;    
	      } catch (MessagingException ex) {    
	          ex.printStackTrace();    
	      }    
	      return false;    
	    }    
	       
	    public boolean sendHtmlMail(MxkMailSenderInfo mailInfo){    
	      MxkMailAuthenticator authenticator = null;   
	      Properties pro = mailInfo.getProperties();   
	      if (mailInfo.isValidate()) {    
	        authenticator = new MxkMailAuthenticator(mailInfo.getUserName(), mailInfo.getPassword());   
	      }    
	      Session sendMailSession = Session.getDefaultInstance(pro,authenticator);    
	      try {    
	      Message mailMessage = new MimeMessage(sendMailSession);    
	      Address from = new InternetAddress(mailInfo.getFromAddress());    
	      mailMessage.setFrom(from);    
	      Address to = new InternetAddress(mailInfo.getToAddress());    
	      mailMessage.setRecipient(Message.RecipientType.TO,to);    
	      mailMessage.setSubject(mailInfo.getSubject());    
	      mailMessage.setSentDate(new Date());    
	      Multipart mainPart = new MimeMultipart();    
	      BodyPart html = new MimeBodyPart();    
	      html.setContent(mailInfo.getContent(), "text/html; charset=utf-8");    
	      mainPart.addBodyPart(html);    
	      mailMessage.setContent(mainPart);    
	      Transport.send(mailMessage);    
	      return true;    
	      } catch (MessagingException ex) {    
	          ex.printStackTrace();    
	      }    
	      return false;    
	    }  
	       
//	    public void sendWithTemplate(MxkMailSenderInfo mailInfo,Map<String,String> model,VelocityEngine velocityEngine){  
//	    	 MxkMailAuthenticator authenticator = null;    
//		      Properties pro = mailInfo.getProperties();   
//		      if (mailInfo.isValidate()) {    
//		        authenticator = new MxkMailAuthenticator(mailInfo.getUserName(), mailInfo.getPassword());    
//		      }   
//		      Session sendMailSession = Session.getDefaultInstance(pro,authenticator);
//		      try {    
//			      Message mailMessage = new MimeMessage(sendMailSession);    
//			      Address from = new InternetAddress(mailInfo.getFromAddress());    
//			      mailMessage.setFrom(from);    
//			      Address to = new InternetAddress(mailInfo.getToAddress());    
//			      mailMessage.setRecipient(Message.RecipientType.TO,to);    
//			      mailMessage.setSubject(mailInfo.getSubject());    
//			      mailMessage.setSentDate(new Date());    
//			      
//			      String result = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "regist_success_template.vm", "UTF-8",model);  
//			      
//			      mailMessage.setText(result);    
//			      Transport.send(mailMessage);   
//			      } catch (MessagingException ex) {    
//			          ex.printStackTrace();    
//			      }    
//		      
//	    }   
}   

