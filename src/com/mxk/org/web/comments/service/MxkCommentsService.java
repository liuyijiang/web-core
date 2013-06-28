package com.mxk.org.web.comments.service;

import java.io.File;
import java.io.InputStream;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.mxk.org.common.factory.EntityFactory;
import com.mxk.org.common.message.domain.VoiceTransformMessage;
import com.mxk.org.common.message.serivce.MxkMessageQueueService;
import com.mxk.org.common.util.VoiceTransformUtil;
import com.mxk.org.entity.CommentEntity;
import com.mxk.org.web.comments.dao.MxkCommentsDao;
import com.mxk.org.web.comments.domain.CommentsAddRequest;
import com.mxk.org.web.comments.domain.LoadCommentsRequest;
import com.mxk.org.web.comments.domain.LoadCommentsRespone;

@Service
public class MxkCommentsService {

	private static final Log log = LogFactory.getLog(MxkCommentsService.class);
	
	@Value("${moosefs.file.voice.comments}")
	private String voicepath;
	
	private static final String FOLDER = "comments";
	
	@Autowired
	private MxkMessageQueueService messageQueueService;
	
	@Autowired
	private MxkCommentsDao commentsDao;
	
	public LoadCommentsRespone findCommentEntity(LoadCommentsRequest request){
		LoadCommentsRespone respone = new LoadCommentsRespone();
		List<CommentEntity> list = commentsDao.findCommentEntity(request);
		respone.setList(list);
		return respone;
	}
	
	public boolean saveTextComment(CommentsAddRequest commentsAddRequest){
		CommentEntity commentEntity = EntityFactory.createCommentEntity(commentsAddRequest);
		return commentsDao.saveCommentEntity(commentEntity);
	}
	
	public boolean saveVoiceComment(CommentsAddRequest commentsAddRequest,InputStream inputStream){
		CommentEntity commentEntity = EntityFactory.createCommentEntity(commentsAddRequest);
		commentsDao.saveCommentEntity(commentEntity);
		if(commentEntity.getId() != null){
			String path = File.separator + FOLDER + File.separator + commentEntity.getId() + VoiceTransformUtil.VOICE_TYPE_WAV;
			String filePath = voicepath + path;
			VoiceTransformUtil util = new VoiceTransformUtil();
			try{
			   util.saveVoiceStearm(inputStream, filePath);
			   VoiceTransformMessage message = new VoiceTransformMessage();
			   message.setTrageId(commentEntity.getId());
			   message.setWavUrl(filePath);
			   messageQueueService.startVioceTransformTask(message);
			   //commentsDao.updateCommentInfo(commentEntity.getId(), path);
			   //×ª»»wav -> mp3
			}catch(Exception e){
				log.error(e.getMessage(),e);
			}
			return true;
		}else{
			return false;
		}	
	}
	
	public boolean updateCommentInfo(String id,String info){
		return commentsDao.updateCommentInfo(id, info);
	}
}
