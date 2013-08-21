package com.mxk.org.common.connect.mencache;

import net.spy.memcached.CASValue;
import net.spy.memcached.MemcachedClient;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * �ֲ�ʽsession ����
 * @author liuyijiang
 *
 */
@Component
public class MemcachSessionLoad {

	@Value("${memcach.exp}")
	private int exptime;//����ʱ��
	
	@Autowired
	@Qualifier("memcachedClient")
	private MemcachedClient mc;
   	
	public void setCachData(String key,String data){
		mc.set(key, exptime, data);
	}
	
	public String getCachDataAndRemove(String key,boolean delete){
		String data = (String) mc.get(key);
		if(data != null && data != "" && delete){
			mc.delete(key);
		}
		return data;
	}
	
	public String getSessionData(String key){
		CASValue<Object> casValue = mc.getAndTouch(key, exptime);
		String session = null;
		if (casValue != null){
			session = casValue.getValue().toString();
		} 
		return session;
	}
	
	public void setSessionData(String key,String str){
		mc.set(key, exptime, str);
	}
	
}
