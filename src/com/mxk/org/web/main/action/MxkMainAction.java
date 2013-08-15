package com.mxk.org.web.main.action;

import java.util.Timer;
import java.util.TimerTask;

import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.base.MxkSessionAction;
import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.message.domain.MailPushMessage;
import com.mxk.org.common.message.serivce.MxkMessageQueueService;
import com.mxk.org.common.service.MxkMailService;
import com.mxk.org.entity.MessageEntity;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.web.comments.domain.LoadCommentsRequest;
import com.mxk.org.web.comments.domain.LoadCommentsRespone;
import com.mxk.org.web.comments.service.MxkCommentsService;
import com.mxk.org.web.comments.service.MxkMessageService;
import com.mxk.org.web.main.domain.ChangePasswordRequest;
import com.mxk.org.web.main.domain.RegisterCheckRequest;
import com.mxk.org.web.part.service.MxkPartService;
import com.mxk.org.web.subject.domain.CreateSubjectWorkingRequest;
import com.mxk.org.web.subject.domain.SubjectNewPartsVO;
import com.mxk.org.web.subject.domain.SubjectTop5NewPartsRespone;
import com.mxk.org.web.subject.service.MxkSubjectService;
import com.mxk.org.web.user.domain.UserVO;
import com.mxk.org.web.user.service.MxkUserService;

public class MxkMainAction extends MxkSessionAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8591289247435587252L;
  
	@Autowired
	private MxkUserService userService;
	
	@Autowired
	private MxkMailService mailService;
	
	@Autowired
	private MxkMessageService messageService;
	
	@Autowired
	private MxkMessageQueueService messageQueueService;
	
	@Autowired
	private MxkPartService partService;
	
	@Autowired
	private MxkCommentsService commentsService;
	
	@Autowired
	private MxkSubjectService subjectService;
	
	private UserVO uservo;
	private RegisterCheckRequest registerCheckRequest;
	private String message;
	private ChangePasswordRequest changePasswordRequest;
	private LoadCommentsRespone loadCommentsRespone;
	private SubjectEntity currentSubjectEntity;
	private SubjectNewPartsVO subjectNewPartsVO;
	private PartEntity partEntity;
	private String usermail;
	private String uuid;
	private String target;//
	private SubjectTop5NewPartsRespone subjectTop5NewPartsRespone;
	private CreateSubjectWorkingRequest createSubjectWorkingRequest;
	private LoadCommentsRequest loadCommentsRequest;
	
	
	//update
	public String updateSubjectActionss(){
		subjectService.btnUpdateSubjects();
		return SUCCESS;
	}
	
	//测试提示
	public String mxkShowRegist(){
		return SUCCESS;
	}
	
	public String mxkTestStyle(){
		//1 查询本周最后的8条 
		//为每个用户发邮件
		return SUCCESS;
	}
	
	public String mxkTestMail(){
		//mailService.sendTempleteEmail("","liuyijiang3430@qq.com",new HashMap());
		 MailPushMessage mes = new MailPushMessage();
	     mes.setType(MxkConstant.MAIL_TYPE_WEEKPUSH);
		 messageQueueService.startMailTask(mes);
		return SUCCESS;
	}
	
	//用户
	public String mxkUserShowNewMessageOfComView(){
		MessageEntity messageEntity = messageService.findMessageEntityById(target);
		if(messageEntity != null){
			target = messageEntity.getTargetId();
			uuid =  messageEntity.getId();
			Timer t = new Timer();
			t.schedule(new TimerTask() {
				
				@Override
				public void run() {
					messageService.removeMesage(uuid);
					
				}
				
			}, 10000);
			uservo = super.getCurrentUserVO();
			partEntity = partService.findPartEntityById(messageEntity.getTargetId());
			currentSubjectEntity =   subjectService.findSubjectEntityById(partEntity.getSubjectid());
			if(partEntity != null){
				subjectNewPartsVO = partService.findSubjectNewParts(partEntity.getSubjectid());
				LoadCommentsRequest request = new LoadCommentsRequest();
				request.setPage(1);
				request.setTargeid(partEntity.getId());
				request.setType(null);
				loadCommentsRespone = commentsService.findCommentEntityByPage(request);
				//loadCommentsRespone = commentsService.findCommentEntity(request);
			}
		}	
		return SUCCESS;
	}
	
	public String mxkUserShowNewMessageOfSubjectComView(){
		
		MessageEntity messageEntity = messageService.findMessageEntityById(target);
		if(messageEntity != null){
			target = messageEntity.getTargetId();
			uuid =  messageEntity.getId();
			Timer t = new Timer();
			t.schedule(new TimerTask() {
				
				@Override
				public void run() {
					messageService.removeMesage(uuid);
					
				}
				
			}, 10000);
			uservo = super.getCurrentUserVO();
			currentSubjectEntity =  subjectService.findSubjectEntityById(target);
			if(currentSubjectEntity != null){
				subjectTop5NewPartsRespone = partService.findNewTop5Parts(currentSubjectEntity.getId());
				loadCommentsRequest = new LoadCommentsRequest();
				loadCommentsRequest.setPage(1);
				loadCommentsRequest.setTargeid(currentSubjectEntity.getId());
				loadCommentsRequest.setType(null);
				loadCommentsRespone = commentsService.findCommentEntityByPage(loadCommentsRequest);
				if(loadCommentsRespone != null){
					long allpage = commentsService.findCommentsPage(loadCommentsRequest);
					loadCommentsRespone.setAllpage(allpage);
				}
			}
			
		}
		return SUCCESS;
	}
	
	
	public String mxkRegisterCheckAjax(){
		UserVO user = super.getCurrentUserVO();
		if(user != null){
			registerCheckRequest.setCurrentName(user.getName());
		}
		if(userService.checkParmUnique(registerCheckRequest)){
			message = MxkConstant.AJAX_SUCCESS;
		}else{
			message = MxkConstant.AJAX_ERROR;
		}
		return SUCCESS;
	}
	
	public String mxkIndex(){
		uservo = super.getCurrentUserVO();
		if(uservo != null){
			return "userindex";
		}else{
			return "index";
		}
	}
	
	public String mxkLoginOutView(){
		return SUCCESS;
	}
	
	public String mxkSendChangePasswordMailAjax(){
		if(changePasswordRequest != null){
			mailService.sendMail(changePasswordRequest.getUsermail());
			message = MxkConstant.AJAX_SUCCESS;
		}else{
			message = MxkConstant.AJAX_ERROR;
		}
		return SUCCESS;
	}

	public String mxkShowChangePasswordView(){
		if(mailService.checkUuid(usermail,uuid,false)){
			message = MxkConstant.AJAX_SUCCESS;
		}else{
			message = MxkConstant.AJAX_ERROR;
		}
		return SUCCESS;
	}

	public String mxkShowHelpView(){
		uservo = super.getCurrentUserVO();
		return SUCCESS;
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

	public RegisterCheckRequest getRegisterCheckRequest() {
		return registerCheckRequest;
	}

	public void setRegisterCheckRequest(RegisterCheckRequest registerCheckRequest) {
		this.registerCheckRequest = registerCheckRequest;
	}

	public ChangePasswordRequest getChangePasswordRequest() {
		return changePasswordRequest;
	}

	public void setChangePasswordRequest(ChangePasswordRequest changePasswordRequest) {
		this.changePasswordRequest = changePasswordRequest;
	}

	public String getUsermail() {
		return usermail;
	}

	public void setUsermail(String usermail) {
		this.usermail = usermail;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public SubjectEntity getCurrentSubjectEntity() {
		return currentSubjectEntity;
	}

	public void setCurrentSubjectEntity(SubjectEntity currentSubjectEntity) {
		this.currentSubjectEntity = currentSubjectEntity;
	}

	public PartEntity getPartEntity() {
		return partEntity;
	}

	public void setPartEntity(PartEntity partEntity) {
		this.partEntity = partEntity;
	}

	public SubjectNewPartsVO getSubjectNewPartsVO() {
		return subjectNewPartsVO;
	}

	public void setSubjectNewPartsVO(SubjectNewPartsVO subjectNewPartsVO) {
		this.subjectNewPartsVO = subjectNewPartsVO;
	}

	public LoadCommentsRespone getLoadCommentsRespone() {
		return loadCommentsRespone;
	}

	public void setLoadCommentsRespone(LoadCommentsRespone loadCommentsRespone) {
		this.loadCommentsRespone = loadCommentsRespone;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public SubjectTop5NewPartsRespone getSubjectTop5NewPartsRespone() {
		return subjectTop5NewPartsRespone;
	}

	public void setSubjectTop5NewPartsRespone(
			SubjectTop5NewPartsRespone subjectTop5NewPartsRespone) {
		this.subjectTop5NewPartsRespone = subjectTop5NewPartsRespone;
	}

	public CreateSubjectWorkingRequest getCreateSubjectWorkingRequest() {
		return createSubjectWorkingRequest;
	}

	public void setCreateSubjectWorkingRequest(
			CreateSubjectWorkingRequest createSubjectWorkingRequest) {
		this.createSubjectWorkingRequest = createSubjectWorkingRequest;
	}

	public LoadCommentsRequest getLoadCommentsRequest() {
		return loadCommentsRequest;
	}

	public void setLoadCommentsRequest(LoadCommentsRequest loadCommentsRequest) {
		this.loadCommentsRequest = loadCommentsRequest;
	}

	
	
}
