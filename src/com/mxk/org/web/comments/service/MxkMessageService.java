package com.mxk.org.web.comments.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.entity.MessageEntity;
import com.mxk.org.web.comments.dao.MxkMessageDao;
import com.mxk.org.web.comments.domain.CommentsAddRequest;
import com.mxk.org.web.user.domain.LoadUserMessageRequest;
import com.mxk.org.web.user.domain.LoadUserMessageRespone;

@Service
public class MxkMessageService {
   
	@Autowired
	private MxkMessageDao messageDao;
	
	public boolean createMessage(CommentsAddRequest commentsAddRequest) {
		MessageEntity messageEntity = new MessageEntity();
		messageEntity.setTargetId(commentsAddRequest.getCommentedId());
		messageEntity.setTargetUserId(commentsAddRequest.getCommentedUserId());
		messageEntity.setType(commentsAddRequest.getTarget());
		messageEntity.setUserId(commentsAddRequest.getUserid());
		messageEntity.setUsername(commentsAddRequest.getUsername());
		messageEntity.setUserimage(commentsAddRequest.getUserimage());
		return messageDao.createMessage(messageEntity);
	}
	
	public boolean createMessage(MessageEntity messageEntity) {
		return messageDao.createMessage(messageEntity);
	}

	public MessageEntity findMessageEntityById(String id){
		return messageDao.findMessageEntityById(id);
	}
	
	public long findMessageCount(String userid){
		return messageDao.findMessageCount(userid);
	}
	
	public boolean removeMesage(String id){
		return messageDao.removeMesage(id);
	}
	
	public LoadUserMessageRespone findMessageEntity(LoadUserMessageRequest loadUserMessageRequest){
		LoadUserMessageRespone loadUserMessageRespone = new LoadUserMessageRespone();
		List<MessageEntity> list = messageDao.findMessageEntity(loadUserMessageRequest.getUserid(),loadUserMessageRequest.getPage());
		loadUserMessageRespone.setPage(loadUserMessageRequest.getPage());
		loadUserMessageRespone.setList(list);
		return loadUserMessageRespone;
	}
	
}
