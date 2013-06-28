package com.mxk.org.common.util;

import java.util.HashMap;
import java.util.Map;

public class HttpUtil {
  
	public static Map<String,String> analyseParmFromUrl(String url){
		Map<String,String> map = new HashMap<String,String>();
		String parmstr = url.substring(url.indexOf("&")+1,url.length());
		String[] parms = parmstr.split("&");
		for(String strs : parms){
			String key = strs.substring(0,strs.indexOf("="));
			String value = strs.substring(strs.indexOf("=")+1,strs.length());
			map.put(key, value);
		}
		return map;
	}
	
}
