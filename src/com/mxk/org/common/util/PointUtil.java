package com.mxk.org.common.util;

import java.util.Random;


public class PointUtil {
 
	private static final String PIN = "pin";
	private static final String PIN_TYPE = ".png";
	
	public static String randomPIN(){
		int i = new Random().nextInt(5)+1;
		return PIN+i+PIN_TYPE;
	}
	
	private int randomNum(int min, int max){
		return new Random().nextInt(max - min + 1) + min; 
	}
   
	public int[] createnPositionList(int maxwidth,int maxheight){
		boolean flag = true;
		int left = 0;
		int top = 0;
		while(flag){
			left = randomNum(0, maxwidth);
			top =  randomNum(0, maxheight);
			if(left > maxwidth - 30 || top > maxheight - 30){
				flag = true;
			}else{
				flag = false;
			}
		}
		int[] data = new int[2];
		data[0] = top;
		data[1] = left;
		return data;
	}
	
}
 