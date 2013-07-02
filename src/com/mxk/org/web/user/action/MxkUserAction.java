package com.mxk.org.web.user.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.mxk.org.common.base.MxkSessionAction;
import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.factory.VOFactory;
import com.mxk.org.common.service.MxkFileUploadService;
import com.mxk.org.common.service.MxkGridFSFileUploadService;
import com.mxk.org.common.service.MxkMailService;
import com.mxk.org.common.service.MxkRedisCacheService;
import com.mxk.org.common.util.StringUtil;
import com.mxk.org.common.util.ValidateUtil;
import com.mxk.org.entity.MessageEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.entity.UserEntity;
import com.mxk.org.entity.UserFriendEntity;
import com.mxk.org.web.comments.service.MxkMessageService;
import com.mxk.org.web.part.domain.PartShowResponse;
import com.mxk.org.web.part.domain.SearchPartRequest;
import com.mxk.org.web.part.service.MxkPartService;
import com.mxk.org.web.subject.domain.SearchSubjectRequest;
import com.mxk.org.web.subject.domain.SubjectsShowResponse;
import com.mxk.org.web.subject.service.MxkSubjectJoinPeopleService;
import com.mxk.org.web.subject.service.MxkSubjectService;
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
import com.mxk.org.web.user.service.MxkUserFriendService;
import com.mxk.org.web.user.service.MxkUserService;
import com.mxk.org.web.visitor.domain.CollectPartsRequest;

/**
 * 用户业务逻辑action  页面跳转的method 以view结尾
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
	private MxkSubjectJoinPeopleService subjectJoinPeopleService;
	
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
	
	//关注的信息
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
	
	//用户消息
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
	
	//查看评论的位置
	public String mxkUserSeeMessageDetail(){
		MessageEntity MessageEntity = messageService.findMessageEntityById(target);
		if(MessageEntity != null){
			if(MxkConstant.PART.equals(MessageEntity.getType())){
				target = MessageEntity.getTargetId();
				messageService.removeMesage(MessageEntity.getId());
				return MxkConstant.PART;
			}else{
				target = MessageEntity.getTargetId();
				messageService.removeMesage(MessageEntity.getId());
				return MxkConstant.SUBJECT;
			}
		}
		return ERROR;
	}
	
	
	public String mxkUpdateUserView(){
		uservo = super.getCurrentUserVO();
		return SUCCESS;
	}
	
	//用户的关注界面
	public String mxkShowUserFoucsView(){
		uservo = super.getCurrentUserVO();
		return SUCCESS;
	}
	
	//用户粉丝界面
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
	
	//模糊查询user
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
	
	
	//模糊查询用户
	public String mxkFindUsersAjax(){
		return SUCCESS;
	}
	
	//创建用户关系
	public String mxkCreateUserRelationAjax(){
		uservo = super.getCurrentUserVO();
		message = MxkConstant.AJAX_ERROR;
		if(uservo != null && createRelationShipRequest != null){
			if(!uservo.getId().equals(createRelationShipRequest.getUserid())){//不能使自己
				//判断是否已经添加
				if(!userFriendService.checkUserRelationShip(uservo.getId(), createRelationShipRequest.getUserid())){
					//关注一个人 那么 那么被关注的那个人就是user 关注者就是那个人的fried
					UserFriendEntity user = new UserFriendEntity();
					user.setUserid(createRelationShipRequest.getUserid());
					user.setFriendid(uservo.getId());
					//在redis中加入cach
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
	
	//用户收藏part
	public String mxkCreateUserCollectAjax(){
		uservo = super.getCurrentUserVO();
		message = MxkConstant.AJAX_ERROR;
		if(uservo != null && collectPartsRequest != null){
			collectPartsRequest.setUserid(uservo.getId());
			if(userService.createUserCollect(collectPartsRequest)){
				message = MxkConstant.AJAX_SUCCESS;
			}
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
	}
	
	//用户删除part
	public String mxkRemoveUserCollectAjax(){
		uservo = super.getCurrentUserVO();
		message = MxkConstant.AJAX_ERROR;
		if(uservo != null && collectPartsRequest != null){
			collectPartsRequest.setUserid(uservo.getId());
			if(userService.removeUserCollect(collectPartsRequest)){
				message = MxkConstant.AJAX_SUCCESS;
			}
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
	}
	
	
	//展示用户注册页面
	public String mxkShowUserRegisterView(){
		return SUCCESS;
	}
	
	//用户更新信息
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
	
	
	//用户注册
	public String mxkUserRegister(){
		if(valiateUserForRegister(userRegisterRequest)){
			userRegisterRequest.setImageurl(defaultImageUrl);
			userRegisterRequest.setMinimageurl(defaultMinImageUrl);
			UserVO vo = userService.saveUserEntity(userRegisterRequest);
			if(vo != null && vo.getId() != null) {
				if(userRegisterRequest.getImage() != null){
					String imageurl = gridFSFileUploadService.uploadImageWithSize(userRegisterRequest.getImage(), vo.getId(), MxkFileUploadService.IMAGE_TYPE_PNG, MxkFileUploadService.IMAGE_SIZE_FULL, saveImageWidth,saveImageHeight);
					String minimageurl = gridFSFileUploadService.uploadImageWithSize(userRegisterRequest.getImage(), vo.getId(), MxkFileUploadService.IMAGE_TYPE_PNG, MxkFileUploadService.IMAGE_SIZE_FULL, saveImageMinWidth,saveImageMinHeight);
					if(userService.updateUserImage(vo.getId(), imageurl, minimageurl)){
						vo.setImage(imageurl);
						vo.setMinimage(minimageurl);
					}
				}
				//cach
				redisCacheService.setUserVO(vo.getId(), vo);
			    super.setSessionKey(vo.getId()); // 
			}
		}
		return SUCCESS;
	}
	
	//展示用户登陆
	public String mxkShowUserLoginView(){
		return SUCCESS;
	}
	
	//用户登陆
	public String mxkUserLoginIn(){
		UserEntity userEntity = userService.checkUserLogin(userLoginRequest);
		if(userEntity != null && userEntity.getId() != null){
			long messages = messageService.findMessageCount(userEntity.getId());//获得消息数量
			long joinsubject = subjectJoinPeopleService.findUserJoinSubject(userEntity.getId());//获得参与subject
			long rsssubject = subjectService.findUserRssSubjectNum(userEntity.getId());//订阅的专辑
			super.setSessionKey(userEntity.getId());  
			UserVO vo = VOFactory.createUserVOFormEnitiy(userEntity);
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
	
	//修改密码
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
	
	//用户登录后界面
	public String mxkUserIndexView(){
		uservo = super.getCurrentUserVO();
		if(uservo != null){
		  SearchSubjectRequest request = new SearchSubjectRequest(uservo.getId(),null,1);
		  subjectsShowResponse = subjectService.findSubjectEntityBySearchRequest(request);
		  long page = subjectService.findUserSubjectAllPage(uservo.getId());
		  subjectsShowResponse.setAllpage(page);
		  return SUCCESS;
		}else{
			return ERROR;
		}
	}
	
	//异步加载更多
	public String mxkLoadMoreUserSubjectAjax(){
		if (searchSubjectRequest != null) {
		  subjectsShowResponse = subjectService.findSubjectEntityBySearchRequest(searchSubjectRequest);
		}
		return SUCCESS;
	}
	
	
	//收藏页面
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
	
	//过滤用户收藏 by type
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
	
	//加载更多用户收藏信息
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
	
	//订阅的专辑
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
		    }
		}
		return SUCCESS;
	}
	
	//参与的subject
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
			}
			return SUCCESS;
		}else{
			return ERROR;
		}
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
	
	
}
