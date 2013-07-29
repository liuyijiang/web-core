package com.mxk.org.common.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
    
    public static String todayStartTime(){
    	 Calendar cal = Calendar.getInstance();//使用日历类
    	 StringBuffer sb = new StringBuffer();
    	 sb.append(String.valueOf(cal.get(Calendar.YEAR))+"-");
    	 sb.append(String.valueOf(cal.get(Calendar.MONTH)+1)+"-");
    	 sb.append(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
    	 sb.append(" 00:00:00");
    	 return sb.toString();
    }
    
    public static String todatEndTime(){
    	 Calendar cal = Calendar.getInstance();//使用日历类
   	     StringBuffer sb = new StringBuffer();
   	     sb.append(String.valueOf(cal.get(Calendar.YEAR))+"-");
	   	 sb.append(String.valueOf(cal.get(Calendar.MONTH)+1)+"-");
	   	 sb.append(String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));
	   	 sb.append(" 23:59:59");
	   	 return sb.toString();
    }
    
    public static void main(String[] args) {
     	String str = "dassdaadewawadwadwadwa";
//		String[] ar = str.split("#");
//		for (String s : ar) {
//			System.out.println(s);
//		}
     	str = str.replaceAll("#", " ");
     	System.out.println(str);
	}
    
}
