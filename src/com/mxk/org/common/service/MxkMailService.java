package com.mxk.org.common.service;

import java.util.Map;

public interface MxkMailService {
  
	public void sendMail(String toMail);
	
	public boolean checkUuid(String toMail,String uuid,boolean delete);
	
	public boolean sendTempleteEmail(String title,String toMail,Map<String,String> model,String template);
}
