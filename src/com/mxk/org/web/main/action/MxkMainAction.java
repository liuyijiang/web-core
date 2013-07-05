package com.mxk.org.web.main.action;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.base.MxkSessionAction;
import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.service.MxkMailService;
import com.mxk.org.web.main.domain.ChangePasswordRequest;
import com.mxk.org.web.main.domain.RegisterCheckRequest;
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
	
	private UserVO uservo;
	private RegisterCheckRequest registerCheckRequest;
	private String message;
	private ChangePasswordRequest changePasswordRequest;
	private String usermail;
	private String uuid;
	
	public String mxkTestMail(){
		mailService.sendTempleteEmail("","liuyijiang3430@qq.com",new HashMap());
		return SUCCESS;
	}
	
	public String mxkRegisterCheckAjax(){
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
	
	
	
}
