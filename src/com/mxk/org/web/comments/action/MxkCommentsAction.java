package com.mxk.org.web.comments.action;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.base.MxkSessionAction;
import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.util.HttpUtil;
import com.mxk.org.web.comments.domain.CommentsAddRequest;
import com.mxk.org.web.comments.domain.LoadCommentsRequest;
import com.mxk.org.web.comments.domain.LoadCommentsRespone;
import com.mxk.org.web.comments.service.MxkCommentsService;
import com.mxk.org.web.comments.service.MxkMessageService;
import com.mxk.org.web.part.service.MxkPartService;
import com.mxk.org.web.subject.service.MxkSubjectService;
import com.mxk.org.web.user.domain.UserVO;
/**
 * 评论处理
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
	
	private CommentsAddRequest commentsAddRequest;
	private LoadCommentsRequest loadCommentsRequest;
	private LoadCommentsRespone loadCommentsRespone;
	private UserVO uservo;
	private String message;
	
	//加载目标评论 subjetc or part
	public String mxkLoadTrageCommentsAjax(){
		loadCommentsRespone = commentsService.findCommentEntity(loadCommentsRequest);
		return SUCCESS;
	}
	
	//文字评论
	public String mxkAddTextCommentsAjax(){
		uservo = super.getCurrentUserVO();
		message = MxkConstant.AJAX_ERROR;
		if(uservo != null && commentsAddRequest != null){
			commentsAddRequest.setUserid(uservo.getId());
			commentsAddRequest.setUserimage(uservo.getImage());
			commentsAddRequest.setUsername(uservo.getName());
			if(commentsService.saveTextComment(commentsAddRequest)){
				if(MxkConstant.PART.equals(commentsAddRequest.getTarget())){
					partService.updatePartCommentsQuantity(
							commentsAddRequest.getCommentedId(), "comments", true);//更新part评论数量comments audios
					messageService.createMessage(commentsAddRequest);//创建消息提示
					message = MxkConstant.AJAX_SUCCESS;
				}else if(MxkConstant.SUBJECT.equals(commentsAddRequest.getTarget())){
					subjectService.updateSubjectCommentsQuantity(commentsAddRequest.getCommentedId(), true);
					messageService.createMessage(commentsAddRequest);//创建消息提示
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
			if(commentsService.saveVoiceComment(commentsAddRequest,request.getInputStream())){
				message = MxkConstant.AJAX_SUCCESS;
			}
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
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
	
	
	
}
