package com.mxk.org;

import java.util.ArrayList;
import java.util.List;

public class ListTest {

	public static void main(String[] args) {
		
//		List<String> list = new ArrayList<String>();
//		list.add("A");
//		list.add("B");
//		list.add("C");
//		System.out.println(list.size());
//		for(String str : list){
//			System.out.println(str);
//		}
//		list.remove(0);
//		list.add("D");
//		System.out.println(list.size());
//		for(String str : list){
//			System.out.println(str);
//		}
		
		String str = "http://localhost:8080/webmxk/jRecorder.swf?host=http://localhost:8080/webmxk/addVoiceComments?savefile=hello.wav&target=parts&type=wav&commentedId=51bc0f24d2f4db0f67fa5cd3&commentedUserId=";
		String parmstr = str.substring(str.indexOf("&")+1,str.length());
		String[] parms = parmstr.split("&");
		for(String strs : parms){
			System.out.println(strs.substring(0,strs.indexOf("=")));
			System.out.println(strs.substring(strs.indexOf("=")+1,strs.length()));
		}
	
	}
	
}
