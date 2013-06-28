package com.mxk.org.common.service;

public interface MxkMailService {
  
	public void sendMail(String toMail);
	
	public boolean checkUuid(String toMail,String uuid,boolean delete);
	
	public boolean sendTempleteEmail();
}
