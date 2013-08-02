package com.mxk.org.web.comments.action;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.base.MxkSessionAction;
import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.message.serivce.MxkMessageQueueService;
import com.mxk.org.common.service.MxkGridFSFileUploadService;
import com.mxk.org.common.util.HttpUtil;
import com.mxk.org.common.util.StringUtil;
import com.mxk.org.entity.CommentEntity;
import com.mxk.org.web.comments.domain.CommentsAddRequest;
import com.mxk.org.web.comments.domain.LoadCommentsRequest;
import com.mxk.org.web.comments.domain.LoadCommentsRespone;
import com.mxk.org.web.comments.service.MxkCommentsService;
import com.mxk.org.web.comments.service.MxkMessageService;
import com.mxk.org.web.part.service.MxkPartService;
import com.mxk.org.web.subject.service.MxkSubjectService;
import com.mxk.org.web.user.domain.UserVO;
/**
 * 评论
 * @author liuyijiang
 *
 */
public class MxkCommentsAction extends MxkSessionAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8078488954085798377L;

	@Autowired
	private MxkCommentsService commentsService;
	
	@Autowired
	private MxkPartService partService;
	
	@Autowired
	private MxkSubjectService subjectService;
	
	@Autowired
	private MxkMessageService messageService;
	
	@Autowired
	private MxkGridFSFileUploadService gridFSFileUploadService;
	
	@Autowired
	private MxkMessageQueueService messageQueueService;
	
	private CommentsAddRequest commentsAddRequest;
	private LoadCommentsRequest loadCommentsRequest;
	private LoadCommentsRespone loadCommentsRespone;
	private UserVO uservo;
	private String message;
	private String traget;
	
	//
	public String mxkLoadTrageCommentsAjax(){
		loadCommentsRespone = commentsService.findCommentEntity(loadCommentsRequest);
		return SUCCESS;
	}
	

	public String mxkAddTextCommentsAjax(){ 
		uservo = super.getCurrentUserVO();
		message = MxkConstant.AJAX_ERROR;
		if(uservo != null && commentsAddRequest != null){
			commentsAddRequest.setUserid(uservo.getId());
			commentsAddRequest.setUserimage(uservo.getImage());
			commentsAddRequest.setUsername(uservo.getName());
			commentsAddRequest.setReply(MxkConstant.COMMENT_COM);
			String replyUserId = commentsAddRequest.getReplyUserId();
			if(!StringUtil.stringIsEmpty(replyUserId)){
				UserVO vo = super.getCachedUserVO(replyUserId);
				if(vo != null){
					commentsAddRequest.setReplyUserId(vo.getId());
					commentsAddRequest.setReplyUserImage(vo.getImage());
					commentsAddRequest.setReplyUserName(vo.getName());
					commentsAddRequest.setReply(MxkConstant.COMMENT_REPLY);
				}
			}
			if(commentsService.saveTextComment(commentsAddRequest)){
				if(MxkConstant.PART.equals(commentsAddRequest.getTarget())){
					partService.updatePartCommentsQuantity(
							commentsAddRequest.getCommentedId(), "text", true);//����part��������comments audios
					messageService.createMessage(commentsAddRequest);//������Ϣ��ʾ
					partService.changePartsBackShadow(commentsAddRequest.getCommentedId());
					message = MxkConstant.AJAX_SUCCESS;
				}else if(MxkConstant.SUBJECT.equals(commentsAddRequest.getTarget())){
					subjectService.updateSubjectCommentsQuantity(commentsAddRequest.getCommentedId(), true);
					messageService.createMessage(commentsAddRequest);//������Ϣ��ʾ
					message = MxkConstant.AJAX_SUCCESS;
				}
			}
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
	}
	
	//语音评论
	public String mxkAddVoiceComments() throws IOException{
		uservo = super.getCurrentUserVO();
		message = MxkConstant.AJAX_ERROR;
		if(uservo != null){
			CommentsAddRequest commentsAddRequest = new CommentsAddRequest();
			Map<String,String> parm = HttpUtil.analyseParmFromUrl(request.getHeader("referer"));
			commentsAddRequest.setCommentedId(parm.get("commentedId"));
			commentsAddRequest.setCommentedUserId(parm.get("commentedUserId"));
			commentsAddRequest.setTarget(parm.get("target"));
			commentsAddRequest.setType(parm.get("type"));
			commentsAddRequest.setUserid(uservo.getId());
			commentsAddRequest.setUserimage(uservo.getImage());
			commentsAddRequest.setUsername(uservo.getName());
			commentsAddRequest.setReply(MxkConstant.COMMENT_COM);
			String replyUserId = parm.get("replyUserId");
			if(!StringUtil.stringIsEmpty(replyUserId)){
				UserVO vo = super.getCachedUserVO(replyUserId);
				if(vo != null){
					commentsAddRequest.setReplyUserId(vo.getId());
					commentsAddRequest.setReplyUserImage(vo.getImage());
					commentsAddRequest.setReplyUserName(vo.getName());
					commentsAddRequest.setReply(MxkConstant.COMMENT_REPLY);
				}
			}
			if(commentsService.saveVoiceComment(commentsAddRequest,request.getInputStream())){
				if(MxkConstant.PART.equals(commentsAddRequest.getTarget())){
					partService.updatePartCommentsQuantity(
							commentsAddRequest.getCommentedId(), "wav", true);//����part��������comments audios
					messageService.createMessage(commentsAddRequest);//������Ϣ��ʾ
					partService.changePartsBackShadow(commentsAddRequest.getCommentedId());
					message = MxkConstant.AJAX_SUCCESS;
				}else if(MxkConstant.SUBJECT.equals(commentsAddRequest.getTarget())){
					subjectService.updateSubjectCommentsQuantity(commentsAddRequest.getCommentedId(), true);
					messageService.createMessage(commentsAddRequest);//������Ϣ��ʾ
					message = MxkConstant.AJAX_SUCCESS;
				}
			}
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
	}
	
    public String mxkDeleteCommentsAjax(){
    	UserVO uservo = super.getCurrentUserVO();
    	if(traget != null && uservo != null){
    		CommentEntity en = commentsService.findSingleCommentEntity(traget);
    		if(valiteOuner(uservo.getId(),en)){
	    		if(MxkConstant.COMMENT_TYPE_WAV.equals(en.getType())){
	    			gridFSFileUploadService.removeFile(en.getInfo(), MxkGridFSFileUploadService.FILE_TYPE_VOICE);
	    		}
	    		commentsService.removeComments(en.getId());
				if (MxkConstant.PART.equals(en.getTarget())) {
					partService.updatePartCommentsQuantity(en.getCommentedId(),en.getType(),false);
	    		}else {
	    			subjectService.updateSubjectCommentsQuantity(en.getCommentedId(), false);
	    		}
    		}
    		message = MxkConstant.AJAX_SUCCESS;
    	}else{
    		message = MxkConstant.USER_NO_LOGIN;
    	}
    	return SUCCESS;
    }
	
	private boolean valiteOuner(String userid,CommentEntity en){
		if(en == null){
			return false;
		}
		if(userid.equals(en.getUserid())){ //我评论的 我可以删
		   return true;	
		}
		if(userid.equals(en.getCommentedUserId())){ //评论我的我可以删
			return true;
		}
		return false;//不能删
	}
    
    
	public CommentsAddRequest getCommentsAddRequest() {
		return commentsAddRequest;
	}

	public void setCommentsAddRequest(CommentsAddRequest commentsAddRequest) {
		this.commentsAddRequest = commentsAddRequest;
	}

	public UserVO getUservo() {
		return uservo;
	}

	public void setUservo(UserVO uservo) {
		this.uservo = uservo;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}


	public LoadCommentsRequest getLoadCommentsRequest() {
		return loadCommentsRequest;
	}


	public void setLoadCommentsRequest(LoadCommentsRequest loadCommentsRequest) {
		this.loadCommentsRequest = loadCommentsRequest;
	}


	public LoadCommentsRespone getLoadCommentsRespone() {
		return loadCommentsRespone;
	}


	public void setLoadCommentsRespone(LoadCommentsRespone loadCommentsRespone) {
		this.loadCommentsRespone = loadCommentsRespone;
	}

	public String getTraget() {
		return traget;
	}

	public void setTraget(String traget) {
		this.traget = traget;
	} 
	
}
