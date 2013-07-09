package com.mxk.org.web.comments.service;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
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
import com.mxk.org.web.part.domain.PartNewCommentsResponse;

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
	
	public List<CommentEntity> findTargetAllComment(String target){
		return commentsDao.findTargetAllComment(target);
	}
	
	public PartNewCommentsResponse findNewComments(String commentid){
		PartNewCommentsResponse p = new PartNewCommentsResponse();
		p.setList(commentsDao.findNewComments(commentid));
		return p;
	}
	
	public boolean removeComments(String id){
		return commentsDao.removeComments(id);
	}
	
	public CommentEntity findSingleCommentEntity(String id){
		return commentsDao.findSingleCommentEntity(id);
	}
	
	public long findCommentsPage(LoadCommentsRequest request){
		return commentsDao.findCommentsPage(request);
	}
	
	public LoadCommentsRespone findCommentEntity(LoadCommentsRequest request){
		LoadCommentsRespone respone = null;
		List<CommentEntity> list = commentsDao.findCommentEntity(request);
		//List<CommentEntity> list = commentsDao.testfindCommentEntity(request);
		if(list != null && !list.isEmpty()){
			respone = new LoadCommentsRespone();
			int index = 0;
			List<CommentEntity> list1 = new ArrayList<CommentEntity>();
			List<CommentEntity> list2 = new ArrayList<CommentEntity>();
			List<CommentEntity> list3 = new ArrayList<CommentEntity>();
			List<CommentEntity> list4 = new ArrayList<CommentEntity>();
			respone.setList1(list1);
			respone.setList2(list2);
			respone.setList3(list3);
			respone.setList4(list4);
			for (CommentEntity entity : list) {
				if(index == 0){
					list1.add(entity);
					index ++ ;
				}
				else if(index == 1){
					list2.add(entity);
					index ++ ;
				}
				else if(index == 2){
					list3.add(entity);
					index ++ ;
				}
				else if(index == 3){
					list4.add(entity);
					index = 0;
				}
			}
		}
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
			   //ת��wav -> mp3
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
