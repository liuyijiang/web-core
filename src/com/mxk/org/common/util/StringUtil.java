package com.mxk.org.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
/**
 * StringUtil
 * @author liuyijiang
 *
 */
public class StringUtil {
   
	public static boolean stringIsEmpty(String str) {
		if (str == null || str.trim().equals("")) {
			return true;
		} else {
			return false;
		}
	}
	
    public static String dateToString(Date date,String formater){
    	if(formater == null){
    		formater = "yyyy-MM-dd HH:mm:ss";
    	}
    	SimpleDateFormat s  = new SimpleDateFormat(formater);
    	return s.format(date);
	}
}
