package com.mxk.org.web.system;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.mxk.org.entity.GiftEntity;

public class MetooSystemMain {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		File file = new File("E:\\json\\gift_data.json"); 
	    BufferedReader reader = null; 
	     //System.out.println("以行为单位读取文件内容，一次读一整行："); 
	    reader =new BufferedReader(new InputStreamReader(new FileInputStream(file),"UTF-8"));
	     //reader = new BufferedReader(new FileReader(file),"UTF-8"); 
	     String tempString = null; 
	     StringBuffer sb = new StringBuffer();
	     //一次读入一行，直到读入null为文件结束
	     while ((tempString = reader.readLine()) != null) { 
	    	 sb.append(tempString);
	     } 
	     System.out.println(sb.toString());
	     reader.close();  
	    // JSONObject  jsonObj  = JSONObject.fromObject(sb.toString());
	    //得到A对象""
	     JSONArray arrayA =  JSONArray.fromObject("[" + sb.toString() + "]"); 
	    //JSONArray arrayA= jsonObj.getJSONArray(sb.toString());
	    for(int i=0;i<arrayA.size();i++){
	    	GiftEntity a = (GiftEntity) JSONObject.toBean((JSONArray.fromObject(arrayA.toString()).getJSONObject(i)),GiftEntity.class);
	     System.out.println(a.getGiftName());
	    }
	  }

}
