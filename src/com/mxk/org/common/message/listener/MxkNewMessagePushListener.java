package com.mxk.org.common.message.listener;

import java.util.Set;

import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import redis.clients.jedis.Jedis;

import com.mxk.org.common.connect.redis.MxkJedisPool;
import com.mxk.org.common.domain.constant.MxkRedisCacheContants;
import com.mxk.org.common.util.StringUtil;
/**
 * 新建part push
 * @author Administrator
 *
 */
public class MxkNewMessagePushListener implements MessageListener{

	private static final Log log = LogFactory.getLog(MxkNewMessagePushListener.class);
	
	@Autowired
	public MxkJedisPool jedisPool;
	
	@Override
	public void onMessage(Message message) {
		MapMessage m = (MapMessage) message;
		try {
			String tragetId = m.getString("tragetId");
			String userid = m.getString("userid");
			String subjectId = m.getString("subjectId");
			if(!StringUtil.stringIsEmpty(tragetId) && !StringUtil.stringIsEmpty(userid)){
				//1所有好友
				pushForRssUser(userid,tragetId);
				//2订阅专辑者
				if(!StringUtil.stringIsEmpty(subjectId)){
					pushForRssSubejct(subjectId,tragetId);
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}

	//���͸��˿
	private void pushForRssUser(String userid,String tragetId){
		Jedis jedis = null;
		try{
			jedis = jedisPool.getJedis();
			String key = userid + MxkRedisCacheContants.KEY_USER_FOLLOWER;
			Set<String> followers = jedis.smembers(key);
			for (String id : followers) {
				 String userkey = id + MxkRedisCacheContants.KEY_USER_FOUCS;
				 if(jedis.llen(userkey) > 120 ){
				    jedis.ltrim(userkey, 0, 50); //ȥ��
				 }
				 jedis.lpush(userkey, tragetId);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			e.printStackTrace();
			jedis.disconnect(); 
		}finally{
		   jedisPool.getJedisPool().returnResource(jedis);
		}
	}
	
	//���͸�����
    private void pushForRssSubejct(String subjectId,String tragetId){
    	Jedis jedis = null;
		try{
			jedis = jedisPool.getJedis();
			String key = subjectId + MxkRedisCacheContants.KEY_SUBJECT_FOUCS;
			Set<String> followers = jedis.smembers(key);
			for (String id : followers) {
				 String userkey = id + MxkRedisCacheContants.KEY_USER_FOUCS;
				 if(jedis.llen(userkey) > 120 ){
				    jedis.ltrim(userkey, 0, 50); //ȥ��
				 }
				 jedis.lpush(userkey, tragetId);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			e.printStackTrace();
			jedis.disconnect(); 
		}finally{
		   jedisPool.getJedisPool().returnResource(jedis);
		}
	}
}
