package com.mxk.org;

import net.sf.json.JSONObject;

public class Jsontest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Bean b = new Bean();
		b.setAge(21);
		b.setName("liuyijiang");
		b.setSex("kkkk");
		
		JSONObject json1 = JSONObject.fromObject(b);
		String str = json1.toString();
		System.out.println(str);
		
		
		
		//String myJson = "{'age':36,'email':'','id':'2','name':'testName'}";
//		JSONObject jsonObject1 = JSONObject.fromObject( myJson );   
//		TestBean bean = (TestBean) JSONObject.toBean( jsonObject1, TestBean.class );   
//		System.out.println("beanName:" + bean.getName());
	}

}
