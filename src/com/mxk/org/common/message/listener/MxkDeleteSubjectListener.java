package com.mxk.org.common.message.listener;


import java.util.List;

import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.service.MxkGridFSFileUploadService;
import com.mxk.org.entity.CommentEntity;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.web.comments.service.MxkCommentsService;
import com.mxk.org.web.part.service.MxkPartService;
/**
 * 
 * @author Administrator
 *
 */
public class MxkDeleteSubjectListener implements MessageListener{

	private static final Log log = LogFactory.getLog(MxkDeleteSubjectListener.class);
	
	@Autowired
	private MxkCommentsService commentsService;
	
	@Autowired
	private MxkGridFSFileUploadService gridFSFileUploadService;
	
	@Autowired
	private MxkPartService partService;
	
	@Override
	public void onMessage(Message message) {
		MapMessage m = (MapMessage) message;
		try{
		   String subjectid = m.getString("subjectid");
		   if(subjectid != null){
			   //先删除所有subject 评论
			   List<CommentEntity> subComList = commentsService.findTargetAllComment(subjectid);
			   if(subComList != null && !subComList.isEmpty()){
				   for(CommentEntity cm:subComList){
					   deleteComments(cm.getId());
				   }
			   }
			   List<PartEntity> partList = partService.findPartEntityAll(subjectid);
			   for(PartEntity p : partList){
				   if(partService.removePartById(p.getId())){
					   List<CommentEntity> partComList = commentsService.findTargetAllComment(p.getId());
					   if(partComList != null && !partComList.isEmpty()){
						   for(CommentEntity pm:partComList){
							   deleteComments(pm.getId());
						   }
					   }
				   }
			   }
		   }
		} catch (Exception e){
			log.error(e.getMessage(),e);
		}
	}

	private void deleteComments(String target){
		CommentEntity en = commentsService.findSingleCommentEntity(target);
		if(MxkConstant.COMMENT_TYPE_WAV.equals(en.getType())){
			gridFSFileUploadService.removeFile(en.getInfo(), MxkGridFSFileUploadService.FILE_TYPE_VOICE);
		}
		commentsService.removeComments(en.getId());
	}
	
}
