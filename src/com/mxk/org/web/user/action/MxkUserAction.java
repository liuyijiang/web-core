package com.mxk.org.web.user.action;

import java.awt.Color;
import java.awt.Font;
import java.io.File;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.mxk.org.common.base.MxkSessionAction;
import com.mxk.org.common.domain.constant.MetooCertificateConstant;
import com.mxk.org.common.domain.constant.MetooResultMessage;
import com.mxk.org.common.domain.constant.MetooTitleConstant;
import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.factory.VOFactory;
import com.mxk.org.common.message.domain.MailPushMessage;
import com.mxk.org.common.message.serivce.MxkMessageQueueService;
import com.mxk.org.common.service.MxkFileUploadService;
import com.mxk.org.common.service.MxkGridFSFileUploadService;
import com.mxk.org.common.service.MxkMailService;
import com.mxk.org.common.service.MxkRedisCacheService;
import com.mxk.org.common.util.ImageUtil;
import com.mxk.org.common.util.PointUtil;
import com.mxk.org.common.util.StringUtil;
import com.mxk.org.common.util.ValidateUtil;
import com.mxk.org.entity.CollectInformationEntity;
import com.mxk.org.entity.MessageEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.entity.UserCertificateEntity;
import com.mxk.org.entity.UserEntity;
import com.mxk.org.entity.UserFriendEntity;
import com.mxk.org.entity.UserTitleEntity;
import com.mxk.org.web.comments.service.MxkMessageService;
import com.mxk.org.web.part.domain.PartShowResponse;
import com.mxk.org.web.part.domain.SearchPartRequest;
import com.mxk.org.web.part.service.MxkPartService;
import com.mxk.org.web.subject.domain.SearchSubjectRequest;
import com.mxk.org.web.subject.domain.SubjectsShowResponse;
import com.mxk.org.web.subject.service.MxkSubjectJoinPeopleService;
import com.mxk.org.web.subject.service.MxkSubjectService;
import com.mxk.org.web.user.domain.CertificateRespone;
import com.mxk.org.web.user.domain.CreateRelationShipRequest;
import com.mxk.org.web.user.domain.LoadUserMessageRequest;
import com.mxk.org.web.user.domain.LoadUserMessageRespone;
import com.mxk.org.web.user.domain.SearchUserJoinSubjectRequest;
import com.mxk.org.web.user.domain.SearchUserRequest;
import com.mxk.org.web.user.domain.SearchUserResponse;
import com.mxk.org.web.user.domain.SearchUserRssSubjectRequest;
import com.mxk.org.web.user.domain.UserChangePasswordRequest;
import com.mxk.org.web.user.domain.UserCollectSearchRequest;
import com.mxk.org.web.user.domain.UserLoginRequest;
import com.mxk.org.web.user.domain.UserRegisterRequest;
import com.mxk.org.web.user.domain.UserVO;
import com.mxk.org.web.user.service.MetooUserTitleService;
import com.mxk.org.web.user.service.MxkUserFriendService;
import com.mxk.org.web.user.service.MxkUserService;
import com.mxk.org.web.visitor.domain.CollectPartsRequest;

/**
 * 用户注册
 * @author liuyijiang
 *
 */
public class MxkUserAction extends MxkSessionAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6173334505415835062L;

	@Value("${moosefs.file.image.user.default}")
	private String defaultImageUrl;
	
	@Value("${moosefs.file.image.user.default.min}")
	private String defaultMinImageUrl;
	
	@Value("${mxk.userheader.image.size.width}")
	private int saveImageWidth;
	
	@Value("${mxk.userheader.image.size.height}")
	private int saveImageHeight;
	
	@Value("${mxk.userheader.image.min.size.width}")
	private int saveImageMinWidth;
	
	@Value("${mxk.userheader.image.min.size.height}")
	private int saveImageMinHeight;
	
	@Value("${gridfs.file.image.user.max}")
	private double saveImageMax;
	
	@Value("${gridfs.file.image.user.min}")
	private double saveImageMin;
	
	@Autowired
	private MxkUserService userService;
	
	@Autowired
	private MetooUserTitleService userTitleService;
	
	@Autowired
	private MxkGridFSFileUploadService gridFSFileUploadService;
	
	@Autowired
	private MxkRedisCacheService redisCacheService;
	
	@Autowired
	private MxkSubjectService subjectService;
	
	@Autowired
	private MxkPartService partService;
	
	@Autowired
	private MxkUserFriendService userFriendService;
	
	@Autowired
	private MxkMessageService messageService;
	
	@Autowired
	private MxkMailService mailService;
	
	@Autowired
	private MxkMessageQueueService messageQueueService;
	
	@Autowired
	private MxkSubjectJoinPeopleService subjectJoinPeopleService;
	
	private CertificateRespone certificateRespone;
	private UserRegisterRequest userRegisterRequest;
	private UserLoginRequest userLoginRequest;
	private SubjectEntity currentSubjectEntity;
	private UserVO uservo;
	private String message;
	private SubjectsShowResponse subjectsShowResponse;
	private CollectPartsRequest collectPartsRequest;
	private UserCollectSearchRequest userCollectSearchRequest;
	private CreateRelationShipRequest createRelationShipRequest;
	private PartShowResponse partShowResponse;
	private SearchUserResponse searchUserResponse;
	private SearchUserRequest searchUserRequest;
	private LoadUserMessageRequest loadUserMessageRequest;
	private LoadUserMessageRespone loadUserMessageRespone;
	private UserChangePasswordRequest userChangePasswordRequest;
	private SearchUserJoinSubjectRequest searchUserJoinSubjectRequest;
	private SearchUserRssSubjectRequest searchUserRssSubjectRequest;
	private SearchPartRequest searchPartRequest;
	private SearchSubjectRequest searchSubjectRequest;
	private String target;//
	private int type;
	
	//刷新用户积分状态
	public String metooRefreshUserStatusAjax(){
		uservo = super.getCurrentUserVO();
		message = MxkConstant.USER_NO_LOGIN;
		if(uservo != null){
			long messages = messageService.findMessageCount(uservo.getId());//消息
			long joinsubject = subjectJoinPeopleService.findUserJoinSubject(uservo.getId());//加入的专题
			long rsssubject = subjectService.findUserRssSubjectNum(uservo.getId());//订阅的专题
			UserTitleEntity title = userTitleService.findUserTitleEntity(uservo.getId());
			if(title != null){
				uservo.setCommentPoint(title.getCommentPoint());
				uservo.setCommentTileImage(title.getCommentTileImage());
				uservo.setCommentTitle(title.getCommentTitle());
				uservo.setSharePoint(title.getSharePoint());
				uservo.setShareTileImage(title.getShareTileImage());
				uservo.setShareTitle(title.getShareTitle());
				uservo.setSubjectTitle(title.getSubjectTitle());
				uservo.setSubjectPoint(title.getSubjectPoint());
				uservo.setSubjectTileImage(title.getSubjectTileImage());
			}
			uservo.setMessage(messages);
			uservo.setJoinsubject(joinsubject);
			uservo.setRsssubject(rsssubject);
			super.updateCurrentUserVO(uservo);
			message = MxkConstant.AJAX_SUCCESS;
		}
		return SUCCESS;
	}
	
	
	//最新消息
	public String mxkShowNewRssMessageView(){
		uservo = super.getCurrentUserVO();
		if(uservo != null){
			List<String> ids = redisCacheService.findUserRssMessageByPage(uservo.getId(), 1);
			if(ids != null && !ids.isEmpty()){
				partShowResponse = partService.findUserCollectParts(ids);
				partShowResponse.setAllPage(redisCacheService.findUserRssMessageAllPage(uservo.getId()));
			}
		}
		return SUCCESS;
	}
	
	public String mxkLoadMoreNewRssMessageAjax(){
		if(searchPartRequest != null){
			List<String> ids = redisCacheService.findUserRssMessageByPage(searchPartRequest.getUserid(), searchPartRequest.getPage());
			if(ids != null && !ids.isEmpty()){
				partShowResponse = partService.findUserCollectParts(ids);
			}
		}
		return SUCCESS;
	}
	
	public String mxkShowUserOnMessageView(){
		uservo = super.getCurrentUserVO();
		loadUserMessageRequest = new LoadUserMessageRequest();
		loadUserMessageRequest.setPage(1);
		loadUserMessageRequest.setUserid(uservo.getId());
		loadUserMessageRespone = messageService.findMessageEntity(loadUserMessageRequest);
		return SUCCESS;
	}
	
	public String mxkLoadMoreMessageAjax(){
		uservo = super.getCurrentUserVO();
		if(uservo != null && loadUserMessageRequest != null){
			loadUserMessageRespone = messageService.findMessageEntity(loadUserMessageRequest);	
		}
		return SUCCESS;
	}
	
	public String mxkUserSeeMessageDetail(){
		MessageEntity MessageEntity = messageService.findMessageEntityById(target);
		String returnStr = "";
		if(MessageEntity != null){
			if(MxkConstant.PART.equals(MessageEntity.getType())){
				target = MessageEntity.getTargetId();
				messageService.removeMesage(MessageEntity.getId());
				returnStr = "part";
			}else{
				target = MessageEntity.getTargetId();
				messageService.removeMesage(MessageEntity.getId());
				returnStr = "subject";
			}
		}
		return returnStr;
	}
	
	
	public String mxkUpdateUserView(){
		uservo = super.getCurrentUserVO();
		return SUCCESS;
	}
	
	public String mxkShowUserFoucsView(){
		uservo = super.getCurrentUserVO();
		return SUCCESS;
	}
	
	public String mxkShowUserFollowersView(){
		uservo = super.getCurrentUserVO();
		return SUCCESS;
	}
	
	public String mxkSeachUserFriends(){
		if(searchUserRequest != null){
			searchUserResponse = userService.findUserFirends(searchUserRequest.getParm(), searchUserRequest.getPage(), searchUserRequest.isFollower());
		}
		return SUCCESS;
	}
	
	public String mxkSeachUserAjax(){
		if(searchUserRequest != null){
			searchUserResponse = userService.findUserByName(searchUserRequest.getParm(), 
					searchUserRequest.getPage());
			if(searchUserRequest.getAll() == null){
				long all = userService.findfindUserByNameCount(searchUserRequest.getParm());
				searchUserResponse.setAll(all);
			}
		}
		return SUCCESS;
	}
	
	public String mxkFindUsersAjax(){
		return SUCCESS;
	}
	
	public String mxkCreateUserRelationAjax(){
		uservo = super.getCurrentUserVO();
		message = MxkConstant.AJAX_ERROR;
		if(uservo != null && createRelationShipRequest != null){
			if(!uservo.getId().equals(createRelationShipRequest.getUserid())){//����ʹ�Լ�
				if(!userFriendService.checkUserRelationShip(uservo.getId(), createRelationShipRequest.getUserid())){
					UserFriendEntity user = new UserFriendEntity();
					user.setUserid(createRelationShipRequest.getUserid());
					user.setFriendid(uservo.getId());
					if(userFriendService.createUserRelation(user)){
						redisCacheService.cachUserRelation(uservo.getId(), createRelationShipRequest.getUserid());
						message = MxkConstant.AJAX_SUCCESS;
					}
				}
			}
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
	}
	
	public String mxkCreateUserCollectAjax(){
		uservo = super.getCurrentUserVO();
		message = MxkConstant.AJAX_ERROR;
		if(uservo != null && collectPartsRequest != null){
			collectPartsRequest.setUserid(uservo.getId());
			if(userService.createUserCollect(collectPartsRequest)){
				CollectInformationEntity en = new CollectInformationEntity();
				en.setCreateTime(StringUtil.dateToString(new Date(), null));
				en.setCollecterId(uservo.getId());
				en.setCollecterImg(uservo.getImage());
				en.setCollecterName(uservo.getName());
				en.setPin(PointUtil.randomPIN());
				en.setTragetId(collectPartsRequest.getTargetId());
				partService.saveCollectInformationEntity(en);
				partService.changePartsBackShadow(collectPartsRequest.getTargetId());
			}
			message = MxkConstant.AJAX_SUCCESS;
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
	}
	
	public String mxkRemoveUserCollectAjax(){
		uservo = super.getCurrentUserVO();
		message = MxkConstant.AJAX_ERROR;
		if(uservo != null && collectPartsRequest != null){
			collectPartsRequest.setUserid(uservo.getId());
			if(userService.removeUserCollect(collectPartsRequest)){
				partService.removeCollectInformationEntity(uservo.getId(), collectPartsRequest.getTargetId());
				message = MxkConstant.AJAX_SUCCESS;
			}
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
	}
	
	
	public String mxkShowUserRegisterView(){
		super.removeSession();
		return SUCCESS;
	}
	
	public String mxkUserUpdateInfo(){
		uservo = super.getCurrentUserVO();
		if(valiateUserForUpdate(userRegisterRequest) && uservo != null){
			userRegisterRequest.setUserid(uservo.getId());
			if(userRegisterRequest.getImage() != null){
				//
				gridFSFileUploadService.removeFile(uservo.getImage(), MxkFileUploadService.IMAGE_TYPE_PNG);
				gridFSFileUploadService.removeFile(uservo.getMinimage(), MxkFileUploadService.IMAGE_TYPE_PNG);
				String imageurl = gridFSFileUploadService.uploadImageWithSize(userRegisterRequest.getImage(), uservo.getId(), MxkFileUploadService.IMAGE_TYPE_PNG, MxkFileUploadService.IMAGE_SIZE_FULL, saveImageWidth,saveImageHeight);
				String minimageurl = gridFSFileUploadService.uploadImageWithSize(userRegisterRequest.getImage(), uservo.getId(), MxkFileUploadService.IMAGE_TYPE_PNG, MxkFileUploadService.IMAGE_SIZE_FULL, saveImageMinWidth,saveImageMinHeight);
				userRegisterRequest.setImageurl(imageurl);
				userRegisterRequest.setMinimageurl(minimageurl);
				uservo.setImage(imageurl);
				uservo.setMinimage(minimageurl);
			}
			if(StringUtil.stringIsEmpty(userRegisterRequest.getInfo())){
				userRegisterRequest.setInfo(" ");
			}
			if(userService.updateUserEntity(userRegisterRequest)){
				uservo.setInfo(userRegisterRequest.getInfo());
				uservo.setInterest(userRegisterRequest.getInterest());
				uservo.setName(userRegisterRequest.getUsername());
				uservo.setSex(userRegisterRequest.getSex());
				redisCacheService.setUserVO(uservo.getId(), uservo);
			}
		}
		return SUCCESS;
	}
	
	//注册
	public String mxkUserRegister(){
		if(valiateUserForRegister(userRegisterRequest)){
			userRegisterRequest.setImageurl(defaultImageUrl);
			userRegisterRequest.setMinimageurl(defaultMinImageUrl);
			if(StringUtil.stringIsEmpty(userRegisterRequest.getInfo())){
				userRegisterRequest.setInfo(" ");
			}
			UserVO vo = userService.saveUserEntity(userRegisterRequest);
			if(vo != null && vo.getId() != null) {
				if(userRegisterRequest.getImage() != null){
					String imageurl = gridFSFileUploadService.uploadImageWithSize(userRegisterRequest.getImage(), vo.getId(), MxkFileUploadService.IMAGE_TYPE_PNG, MxkFileUploadService.IMAGE_SIZE_FULL, saveImageWidth,saveImageHeight);
					String minimageurl = gridFSFileUploadService.uploadImageWithSize(userRegisterRequest.getImage(), vo.getId(), MxkFileUploadService.IMAGE_TYPE_PNG, MxkFileUploadService.IMAGE_SIZE_MINI, saveImageMinWidth,saveImageMinHeight);
					if(userService.updateUserImage(vo.getId(), imageurl, minimageurl)){
						vo.setImage(imageurl);
						vo.setMinimage(minimageurl);
					}
				}
				//创建用户头衔
				UserTitleEntity title = new UserTitleEntity();
				title.setCommentPoint(0);
				title.setCommentTileCode(MetooTitleConstant.METOO_TITLE_RUMEN.toString());
			    title.setCommentTitle(MetooTitleConstant.METOO_TITLE_RUMEN.getString()+MetooTitleConstant.METOO_TITLE_COMMENT_SUFFIX_NAME.getString());
			    title.setLevel(1);
			    title.setLevelPoint(10);//注册加10分
			    title.setSharePoint(0);
			    title.setShareTileCode(MetooTitleConstant.METOO_TITLE_RUMEN.toString());
			    title.setShareTitle(MetooTitleConstant.METOO_TITLE_RUMEN.getString()+MetooTitleConstant.METOO_TITLE_SHARE_SUFFIX_NAME.getString());
			    title.setSubjectPoint(0);
			    title.setSubjectTileCode(MetooTitleConstant.METOO_TITLE_RUMEN.toString());
			    title.setSubjectTitle(MetooTitleConstant.METOO_TITLE_RUMEN.getString()+MetooTitleConstant.METOO_TITLE_SUBJECT_SUFFIX_NAME.getString());
			    title.setShareTileImage(MetooTitleConstant.METOO_TITLE_RUMEN_IMAGE.getString());
			    title.setSubjectTileImage(MetooTitleConstant.METOO_TITLE_RUMEN_IMAGE.getString());
			    title.setCommentTileImage(MetooTitleConstant.METOO_TITLE_RUMEN_IMAGE.getString());
			    title.setUserid(vo.getId());
			    userTitleService.saveUserTitle(title);
			   //缓存头衔
			    vo.setCommentPoint(title.getCommentPoint());
				vo.setCommentTileImage(title.getCommentTileImage());
				vo.setCommentTitle(title.getCommentTitle());
				vo.setSharePoint(title.getSubjectPoint());
				vo.setShareTileImage(title.getCommentTileImage());
				vo.setShareTitle(title.getShareTitle());
				vo.setSubjectTitle(title.getSubjectTitle());
				vo.setSubjectPoint(title.getSubjectPoint());
				vo.setSubjectTileImage(title.getSubjectTileImage());
			    
			    
				redisCacheService.setUserVO(vo.getId(), vo);
			    super.setSessionKey(vo.getId()); // 
			    MailPushMessage mes = new MailPushMessage();
			    mes.setType(MxkConstant.MAIL_TYPE_REGISTER);
			    mes.setTarget(vo.getId());
			    messageQueueService.startMailTask(mes);//发送邮件
			}
		}
		return SUCCESS;
	}
	
	//登陆
	public String mxkShowUserLoginView(){
		return SUCCESS;
	}
	
	//登陆in
	public String mxkUserLoginIn(){
		UserEntity userEntity = userService.checkUserLogin(userLoginRequest);
		if(userEntity != null && userEntity.getId() != null){
			long messages = messageService.findMessageCount(userEntity.getId());//消息
			long joinsubject = subjectJoinPeopleService.findUserJoinSubject(userEntity.getId());//加入的专题
			long rsssubject = subjectService.findUserRssSubjectNum(userEntity.getId());//订阅的专题
			//获得头衔
			UserTitleEntity title = userTitleService.findUserTitleEntity(userEntity.getId());
			super.setSessionKey(userEntity.getId());  
			UserVO vo = VOFactory.createUserVOFormEnitiy(userEntity);
			if(title != null){
				vo.setCommentPoint(title.getCommentPoint());
				vo.setCommentTileImage(title.getCommentTileImage());
				vo.setCommentTitle(title.getCommentTitle());
				vo.setSharePoint(title.getSharePoint());
				vo.setShareTileImage(title.getShareTileImage());
				vo.setShareTitle(title.getShareTitle());
				vo.setSubjectTitle(title.getSubjectTitle());
				vo.setSubjectPoint(title.getSubjectPoint());
				vo.setSubjectTileImage(title.getSubjectTileImage());
			}
			vo.setMessage(messages);
			vo.setJoinsubject(joinsubject);
			vo.setRsssubject(rsssubject);
			super.updateCurrentUserVO(vo);
			return SUCCESS;
		}else{
			message = MxkConstant.LOGIN_FAIL;
			return ERROR;
		}
	}
	
	//退出
	public String mxkUserLoginOut() {
		super.removeSession();
		return SUCCESS;
	}
	
	//更新账号
	public String mxkUpdateUserPassword(){
		if(userChangePasswordRequest != null && userChangePasswordRequest.getTwopassword() != null && userChangePasswordRequest.getOnepassword() != null){
			if(userChangePasswordRequest.getOnepassword().equals(userChangePasswordRequest.getTwopassword()) && mailService.checkUuid(userChangePasswordRequest.getUsermail(),userChangePasswordRequest.getUuid(),true)){
				UserEntity userEntity = userService.updateUserPassword(userChangePasswordRequest.getUsermail(), userChangePasswordRequest.getTwopassword());
				if(userEntity != null && userEntity.getId() != null){
					long messages = messageService.findMessageCount(userEntity.getId());
					super.setSessionKey(userEntity.getId());  
					UserVO vo = VOFactory.createUserVOFormEnitiy(userEntity);
					vo.setMessage(messages);
					super.updateCurrentUserVO(vo);
					return SUCCESS;
				}else{
					message = MxkConstant.LOGIN_FAIL;
					return ERROR;
				}
			}else{
				return ERROR;
			}
		}else{
			return ERROR;
		}
	}
	
	//用户专题界面
	public String mxkUserIndexView(){
		uservo = super.getCurrentUserVO();
		if(uservo != null){
		  SearchSubjectRequest request = new SearchSubjectRequest(uservo.getId(),null,1);
		  subjectsShowResponse = subjectService.findSubjectEntityBySearchRequest(request);
		  if(subjectsShowResponse != null){
			  long page = subjectService.findUserSubjectAllPage(uservo.getId());
			  subjectsShowResponse.setAllpage(page);
		  } 
		  return SUCCESS;
		}else{
			return ERROR;
		}
	}
	
	//加载更多专题
	public String mxkLoadMoreUserSubjectAjax(){
		if (searchSubjectRequest != null) {
		  subjectsShowResponse = subjectService.findSubjectEntityBySearchRequest(searchSubjectRequest);
		}
		return SUCCESS;
	}
	
	//用户分享单一parts
	public String mxkUserShareSinglePartsIndexView(){
		uservo = super.getCurrentUserVO();
		if(uservo != null){
			SearchPartRequest request = new SearchPartRequest();
			request.setPage(1);
			request.setSubjectid(MxkConstant.MXK_EMPTY_SUBJECT);
			request.setType(null);
			request.setUserid(uservo.getId());
			partShowResponse = partService.findUserShareParts(request);
			if(partShowResponse != null){
				long allPage =partService.findUserShareSinglePartsAllPage(uservo.getId());
				partShowResponse.setAllPage(allPage);
			}
		    return SUCCESS;
		}else{
			return ERROR;
		}
	}
	
	//加载跟多
	public String mxkLoadUserShareSinglePartsIndexAjax(){
		partShowResponse = partService.findUserShareParts(searchPartRequest);
		return SUCCESS;
	}
	
	//加载跟多
	public String mxkLoadMoreUserShareSinglePartsAjax(){
		partShowResponse = partService.findUserSubjectParts(searchPartRequest);
		return SUCCESS;
	}
	
	
	//用户收藏
	public String mxkUserCollectIndexView() {
		uservo = super.getCurrentUserVO();
		if(uservo != null){
			UserCollectSearchRequest userCollectSearchRequest = new UserCollectSearchRequest();
			userCollectSearchRequest.setPage(1);
			userCollectSearchRequest.setUserid(uservo.getId());
			List<String> ids = userService.findUserCollectPartsIds(userCollectSearchRequest);
		    if(ids != null){
		    	partShowResponse = partService.findUserCollectParts(ids);
		    	long allpage = userService.findUserCollectPartsPages(userCollectSearchRequest);
		    	partShowResponse.setAllPage(allpage);
		    }
		    return SUCCESS;
		}else{
			return ERROR;
		}
	}
	
	//过滤收藏 by type
	public String mxkFilterUserCollectAjax(){
		if(userCollectSearchRequest != null){
			List<String> ids = userService.findUserCollectPartsIds(userCollectSearchRequest);
			if(ids != null){
		    	partShowResponse = partService.findUserCollectParts(ids);
		    	long allpage = userService.findUserCollectPartsPages(userCollectSearchRequest);
		    	partShowResponse.setAllPage(allpage);
		    }
		}
		return SUCCESS;
	}
	
	//���ظ���û��ղ���Ϣ
	public String mxkLoadMoreUserCollectAjax(){
		if(userCollectSearchRequest != null){
			if(StringUtil.stringIsEmpty(userCollectSearchRequest.getType())){
				userCollectSearchRequest.setType(null);
			}
			List<String> ids = userService.findUserCollectPartsIds(userCollectSearchRequest);
			if(ids != null){
		    	partShowResponse = partService.findUserCollectParts(ids);
		    }
		}
	    return SUCCESS;
	}
	
	//���ĵ�ר��
	public String mxkShowUserRssSubjectView(){
		uservo = super.getCurrentUserVO();
		if(uservo != null){
			searchUserRssSubjectRequest = new SearchUserRssSubjectRequest();
			searchUserRssSubjectRequest.setPage(1);
			searchUserRssSubjectRequest.setUserid(uservo.getId());
			List<String> ids = userService.findUserRssSubjectIdsList(searchUserRssSubjectRequest);
			if(ids != null && !ids.isEmpty()){
			  List<SubjectEntity> list = subjectService.findSubjectEntityByIdsList(ids);
			  subjectsShowResponse = subjectService.createSubjectsShowResponseByList(list);
			  if(subjectsShowResponse != null){
				  long page = userService.findUserRssSubjectALlPage(uservo.getId());
				  subjectsShowResponse.setAllpage(page);
			  }
		    }
		}
		return SUCCESS;
	}
	
	public String mxkLoadMoreRssSubjectAjax(){
		if(searchUserRssSubjectRequest != null){
			List<String> ids = userService.findUserRssSubjectIdsList(searchUserRssSubjectRequest);
			if(ids != null && !ids.isEmpty()){
			  List<SubjectEntity> list = subjectService.findSubjectEntityByIdsList(ids);
			  subjectsShowResponse = subjectService.createSubjectsShowResponseByList(list);
		    }
		}
		return SUCCESS;
	}
	
	//�����subject
	public String mxkShowUserJoinSubjectView(){
		uservo = super.getCurrentUserVO();
		if(uservo != null){
			searchUserJoinSubjectRequest = new SearchUserJoinSubjectRequest();
			searchUserJoinSubjectRequest.setUserid(uservo.getId());
			searchUserJoinSubjectRequest.setPage(1);
			List<String> ids = subjectJoinPeopleService.findUserJoinSubjectIds(searchUserJoinSubjectRequest);
			if(ids != null && !ids.isEmpty()){
			  List<SubjectEntity> list = subjectService.findSubjectEntityByIdsList(ids);
			  subjectsShowResponse = subjectService.createSubjectsShowResponseByList(list);
			  subjectsShowResponse.setAllpage(subjectJoinPeopleService.findUserJoinSubjectAllPage(uservo.getId()));
			}
			return SUCCESS;
		}else{
			return ERROR;
		}
	}
	
	public String mxkLoadMoreUserJoinSubjectAjax(){
		if (searchUserJoinSubjectRequest != null) {
			List<String> ids = subjectJoinPeopleService.findUserJoinSubjectIds(searchUserJoinSubjectRequest);
			if(ids != null && !ids.isEmpty()){
			   List<SubjectEntity> list = subjectService.findSubjectEntityByIdsList(ids);
			   subjectsShowResponse = subjectService.createSubjectsShowResponseByList(list);
		   }
		}
		return SUCCESS;
	}
	
	private boolean valiateUserForUpdate(UserRegisterRequest userRegisterRequest){
		if (userRegisterRequest == null ){
			return false;
		}
		if (StringUtil.stringIsEmpty(userRegisterRequest.getUsername())) {
			return false;
		}
		return true;
	}
	
	private boolean valiateUserForRegister(UserRegisterRequest userRegisterRequest){
		if (userRegisterRequest == null ){
			return false;
		}
		if (StringUtil.stringIsEmpty(userRegisterRequest.getUsername())) {
			return false;
		}
		if (StringUtil.stringIsEmpty(userRegisterRequest.getPassword())) {
			return false;
		}
		if ( !ValidateUtil.isEmail(userRegisterRequest.getEmail())) {
			return false;
		}
		return true;
	}

//	public String metooShowUserTitleDetail(){
//		
//	}
	
	//查看证书
	public String metooShowUserCertificateView(){
		uservo = super.getCurrentUserVO();
		if(uservo != null){
			certificateRespone = userTitleService.findUserAllCertificate(uservo.getId());
		}
		return SUCCESS;
	}
	
	//升级
	public String metooUpgradeUserTileAjax() {
		uservo = super.getCurrentUserVO();
		message = MxkConstant.AJAX_ERROR;
		if(uservo != null){
			if(userTitleService.upgradeUserTile(uservo.getId(), type)){
				//
				UserTitleEntity title = userTitleService.findUserTitleEntity(uservo.getId());
				if(title != null){
					uservo.setCommentPoint(title.getCommentPoint());
					uservo.setCommentTileImage(title.getCommentTileImage());
					uservo.setCommentTitle(title.getCommentTitle());
					uservo.setSharePoint(title.getSharePoint());
					uservo.setShareTileImage(title.getShareTileImage());
					uservo.setShareTitle(title.getShareTitle());
					uservo.setSubjectTitle(title.getSubjectTitle());
					uservo.setSubjectPoint(title.getSubjectPoint());
					uservo.setSubjectTileImage(title.getSubjectTileImage());
				}
				//生产证书
				ImageUtil util = new ImageUtil();
				File file = util.pressCertificateText(uservo.getId(), type,uservo.getName(), uservo.getShareTitle(),Font.BOLD, 25,
						Color.BLACK, 1);
				String filename = "";
				String titleName = "";
				String titleImage = "";
				if(type==1){
					filename = uservo.getId()+ title.getShareTileCode()+MetooCertificateConstant.METOO_CERTIFICATE_TITLE_SHARE.getString();
					titleName = uservo.getShareTitle();
					titleImage = uservo.getShareTileImage();
					message = MxkConstant.AJAX_SUCCESS+"," + uservo.getShareTitle();
				}else if(type==2){
					filename = uservo.getId()+ title.getCommentTileCode()+MetooCertificateConstant.METOO_CERTIFICATE_TITLE_COMMENT.getString();
					titleName = uservo.getCommentTitle();
					titleImage = uservo.getCommentTileImage();
					message = MxkConstant.AJAX_SUCCESS+","  + uservo.getCommentTitle();
				}else if(type==3){
					filename = uservo.getId()+ title.getSubjectTileCode()+MetooCertificateConstant.METOO_CERTIFICATE_TITLE_SUBJECT.getString();
					titleName = uservo.getSubjectTitle();
					titleImage = uservo.getSubjectTileImage();
					message = MxkConstant.AJAX_SUCCESS+","  + uservo.getSubjectTitle();
				}
				if(file != null){
					gridFSFileUploadService.removeFile(filename, MxkGridFSFileUploadService.FILE_TYPE_JPG);
					gridFSFileUploadService.uploadFile(file, filename, MxkGridFSFileUploadService.FILE_TYPE_JPG);
					
					UserCertificateEntity cer = new UserCertificateEntity();
					cer.setCreateTime(StringUtil.dateToString(new Date(), null));
					cer.setImageurl(filename+MxkGridFSFileUploadService.FILE_TYPE_JPG);
					cer.setTitle(titleName);
					cer.setUserid(uservo.getId());
					cer.setTitleImage(titleImage);
					userTitleService.saveTitleCertificate(cer);
					uservo.seteCret(uservo.geteCret()+1);
					file.delete();
				}
				super.updateCurrentUserVO(uservo);
			}else{
				message = MetooResultMessage.UPGRADE_FAIL.getString();
			}
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
	}
	
	
	public UserRegisterRequest getUserRegisterRequest() {
		return userRegisterRequest;
	}

	public void setUserRegisterRequest(UserRegisterRequest userRegisterRequest) {
		this.userRegisterRequest = userRegisterRequest;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public UserLoginRequest getUserLoginRequest() {
		return userLoginRequest;
	}

	public void setUserLoginRequest(UserLoginRequest userLoginRequest) {
		this.userLoginRequest = userLoginRequest;
	}

	public UserVO getUservo() {
		return uservo;
	}

	public void setUservo(UserVO uservo) {
		this.uservo = uservo;
	}

	public SubjectsShowResponse getSubjectsShowResponse() {
		return subjectsShowResponse;
	}

	public void setSubjectsShowResponse(SubjectsShowResponse subjectsShowResponse) {
		this.subjectsShowResponse = subjectsShowResponse;
	}


	public CollectPartsRequest getCollectPartsRequest() {
		return collectPartsRequest;
	}


	public void setCollectPartsRequest(CollectPartsRequest collectPartsRequest) {
		this.collectPartsRequest = collectPartsRequest;
	}


	public UserCollectSearchRequest getUserCollectSearchRequest() {
		return userCollectSearchRequest;
	}


	public void setUserCollectSearchRequest(
			UserCollectSearchRequest userCollectSearchRequest) {
		this.userCollectSearchRequest = userCollectSearchRequest;
	}


	public PartShowResponse getPartShowResponse() {
		return partShowResponse;
	}


	public void setPartShowResponse(PartShowResponse partShowResponse) {
		this.partShowResponse = partShowResponse;
	}

	public CreateRelationShipRequest getCreateRelationShipRequest() {
		return createRelationShipRequest;
	}

	public void setCreateRelationShipRequest(
			CreateRelationShipRequest createRelationShipRequest) {
		this.createRelationShipRequest = createRelationShipRequest;
	}

	public SearchUserResponse getSearchUserResponse() {
		return searchUserResponse;
	}

	public void setSearchUserResponse(SearchUserResponse searchUserResponse) {
		this.searchUserResponse = searchUserResponse;
	}

	public SearchUserRequest getSearchUserRequest() {
		return searchUserRequest;
	}

	public void setSearchUserRequest(SearchUserRequest searchUserRequest) {
		this.searchUserRequest = searchUserRequest;
	}

	public LoadUserMessageRequest getLoadUserMessageRequest() {
		return loadUserMessageRequest;
	}

	public void setLoadUserMessageRequest(
			LoadUserMessageRequest loadUserMessageRequest) {
		this.loadUserMessageRequest = loadUserMessageRequest;
	}

	public LoadUserMessageRespone getLoadUserMessageRespone() {
		return loadUserMessageRespone;
	}

	public void setLoadUserMessageRespone(
			LoadUserMessageRespone loadUserMessageRespone) {
		this.loadUserMessageRespone = loadUserMessageRespone;
	}

	public SubjectEntity getCurrentSubjectEntity() {
		return currentSubjectEntity;
	}

	public void setCurrentSubjectEntity(SubjectEntity currentSubjectEntity) {
		this.currentSubjectEntity = currentSubjectEntity;
	}

	public UserChangePasswordRequest getUserChangePasswordRequest() {
		return userChangePasswordRequest;
	}

	public void setUserChangePasswordRequest(
			UserChangePasswordRequest userChangePasswordRequest) {
		this.userChangePasswordRequest = userChangePasswordRequest;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public SearchUserJoinSubjectRequest getSearchUserJoinSubjectRequest() {
		return searchUserJoinSubjectRequest;
	}

	public void setSearchUserJoinSubjectRequest(
			SearchUserJoinSubjectRequest searchUserJoinSubjectRequest) {
		this.searchUserJoinSubjectRequest = searchUserJoinSubjectRequest;
	}

	public SearchUserRssSubjectRequest getSearchUserRssSubjectRequest() {
		return searchUserRssSubjectRequest;
	}

	public void setSearchUserRssSubjectRequest(
			SearchUserRssSubjectRequest searchUserRssSubjectRequest) {
		this.searchUserRssSubjectRequest = searchUserRssSubjectRequest;
	}

	public SearchPartRequest getSearchPartRequest() {
		return searchPartRequest;
	}

	public void setSearchPartRequest(SearchPartRequest searchPartRequest) {
		this.searchPartRequest = searchPartRequest;
	}

	public SearchSubjectRequest getSearchSubjectRequest() {
		return searchSubjectRequest;
	}

	public void setSearchSubjectRequest(SearchSubjectRequest searchSubjectRequest) {
		this.searchSubjectRequest = searchSubjectRequest;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}


	public CertificateRespone getCertificateRespone() {
		return certificateRespone;
	}


	public void setCertificateRespone(CertificateRespone certificateRespone) {
		this.certificateRespone = certificateRespone;
	}
	
	
}
