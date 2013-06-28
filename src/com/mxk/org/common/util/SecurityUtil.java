package com.mxk.org.common.util;

import java.security.MessageDigest;

import sun.misc.BASE64Encoder;

public class SecurityUtil {
	
	private static BASE64Encoder base64encoder = new BASE64Encoder();
	
	public static String digestByMd5(String message) {
		try{
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			byte[] source = message.getBytes("UTF-8");
			byte[] outCome = md5.digest(source);
			String result = base64encoder.encode(outCome);
			return result;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		} 
	}
	
	public static String digestBySHA(String message){
		try{
			MessageDigest sha = MessageDigest.getInstance("SHA-256");
			byte[] source = message.getBytes("UTF-8");
			byte[] outCome = sha.digest(source);
			String result = base64encoder.encode(outCome);
			return result;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		} 
	}
	
}
