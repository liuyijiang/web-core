package com.mxk.org.common.service.impl;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import redis.clients.jedis.Jedis;

import com.mxk.org.common.connect.redis.MxkJedisPool;
import com.mxk.org.common.domain.constant.MxkRedisCacheContants;
import com.mxk.org.common.service.MxkRedisCacheService;
import com.mxk.org.web.user.domain.UserVO;
/**
 * redis cache 
 * @author liuyijiang
 *
 */
@Service
public class MxkRedisCacheServiceImpl implements MxkRedisCacheService {

	private static final Log log = LogFactory.getLog(MxkRedisCacheServiceImpl.class);
	
	@Autowired
	public MxkJedisPool jedisPool;
	
	@Value("${mxk.page.small.pagesize}")
	private int size;
	
	
	@SuppressWarnings("unchecked")
	@Override
	public <T> T getData(String key,Class<T> clzss){
		Jedis jedis = null;
		T obj = null;
		try{
			jedis = jedisPool.getJedis();
			String join = jedis.get(key);
			JSONObject jsonObj = JSONObject.fromObject(join);   
			obj = (T) JSONObject.toBean(jsonObj,clzss);
		}catch(Exception e){
			log.error(e.getMessage(), e);
			e.printStackTrace();
			jedis.disconnect(); 
		}finally{
		   jedisPool.getJedisPool().returnResource(jedis);
		}
		return obj;
	}
	
	@Override
	public void setData(String key, Object obj){
		Jedis jedis = null;
		try{
			jedis = jedisPool.getJedis();
			JSONObject jsonObj = JSONObject.fromObject(obj);
			jedis.set(key, jsonObj.toString());
		}catch(Exception e){
			log.error(e.getMessage(), e);
			e.printStackTrace();
			jedis.disconnect(); 
		}finally{
		   jedisPool.getJedisPool().returnResource(jedis);
		}
	}

	@Override
	public void setUserVO(String key, UserVO vo) {
		Jedis jedis = null;
		try{
			jedis = jedisPool.getJedis();
			JSONObject jsonObj = JSONObject.fromObject(vo);
			key = key + MxkRedisCacheContants.KEY_USER;
			jedis.set(key, jsonObj.toString());
		}catch(Exception e){
			log.error(e.getMessage(), e);
			e.printStackTrace();
			jedis.disconnect(); 
		}finally{
		   jedisPool.getJedisPool().returnResource(jedis);
		}
		
	}

	@Override
	public UserVO getUserVO(String key) {
		Jedis jedis = null;
		UserVO vo = null;
		try{
			jedis = jedisPool.getJedis();
			key = key + MxkRedisCacheContants.KEY_USER;
			String join = jedis.get(key);
			JSONObject jsonObj = JSONObject.fromObject(join);   
			vo = (UserVO) JSONObject.toBean(jsonObj,UserVO.class);
		}catch(Exception e){
			log.error(e.getMessage(), e);
			e.printStackTrace();
			jedis.disconnect(); 
		}finally{
		   jedisPool.getJedisPool().returnResource(jedis);
		}
		return vo;
	}

	@Override
	public boolean cachUserRelation(String userid, String friendid) {
		Jedis jedis = null;
		boolean suucess = true;
		try{
			jedis = jedisPool.getJedis();
			String userkey = userid + MxkRedisCacheContants.KEY_USER_FOUCS;
			jedis.sadd(userkey,friendid);//¹Ø×¢
			String friendkey = friendid + MxkRedisCacheContants.KEY_USER_FOLLOWER;
			jedis.sadd(friendkey, userid);
		}catch(Exception e){
			log.error(e.getMessage(), e);
			e.printStackTrace();
			jedis.disconnect(); 
			suucess = false;
		}finally{
		   jedisPool.getJedisPool().returnResource(jedis);
		}
		return suucess;
	}

	@Override
	public boolean cachUserRssSubject(String userid, String subjectid) {
		Jedis jedis = null;
		boolean suucess = true;
		try{
			jedis = jedisPool.getJedis();
			String key = subjectid + MxkRedisCacheContants.KEY_SUBJECT_FOUCS;
			jedis.sadd(key,userid);//¹Ø×¢
		}catch(Exception e){
			log.error(e.getMessage(), e);
			e.printStackTrace();
			jedis.disconnect(); 
			suucess = false;
		}finally{
		   jedisPool.getJedisPool().returnResource(jedis);
		}
		return suucess;
	}

	@Override
	public boolean removeCachUserRssSubject(String userid, String subjectid) {
		Jedis jedis = null;
		boolean suucess = true;
		try{
			jedis = jedisPool.getJedis();
			String key = subjectid + MxkRedisCacheContants.KEY_SUBJECT_FOUCS;
			jedis.srem(key, userid);
		}catch(Exception e){
			log.error(e.getMessage(), e);
			e.printStackTrace();
			jedis.disconnect(); 
			suucess = false;
		}finally{
		   jedisPool.getJedisPool().returnResource(jedis);
		}
		return suucess;
	}
	
}
