package com.mxk.org.web.part.action;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.mxk.org.common.base.MxkSessionAction;
import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.domain.session.MxkSessionContext;
import com.mxk.org.common.message.domain.NewMessagePushMessage;
import com.mxk.org.common.message.serivce.MxkMessageQueueService;
import com.mxk.org.common.service.MxkFileUploadService;
import com.mxk.org.common.service.MxkGridFSFileUploadService;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.web.comments.domain.LoadCommentsRequest;
import com.mxk.org.web.comments.domain.LoadCommentsRespone;
import com.mxk.org.web.comments.service.MxkCommentsService;
import com.mxk.org.web.part.domain.CreatePartRequest;
import com.mxk.org.web.part.domain.PartNewCommentsResponse;
import com.mxk.org.web.part.domain.PartShowResponse;
import com.mxk.org.web.part.domain.PartsAllResponse;
import com.mxk.org.web.part.domain.SearchPartRequest;
import com.mxk.org.web.part.domain.UpdatePartInfoRequest;
import com.mxk.org.web.part.service.MxkPartService;
import com.mxk.org.web.subject.domain.SubjectNewPartsVO;
import com.mxk.org.web.subject.service.MxkSubjectService;
import com.mxk.org.web.user.domain.UserVO;
/**
 * partaction ҳ����ת��method mxkShow��ͷ ��view��β ajax����Ҫ��ajax��β
 * @author liuyijiang
 *
 */
public class MxkPartAction extends MxkSessionAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8860900392296157183L;
   
	@Value("${moosefs.file.image.part.max}")
	private double max;
	
	@Value("${moosefs.file.image.part.min}")
	private double min;
	
	@Autowired
	private MxkPartService partService;
	
	@Autowired
	private MxkSubjectService subjectService;
	
	@Autowired
	private MxkGridFSFileUploadService gridFSFileUploadService;
	
	@Autowired
	private MxkMessageQueueService messageQueueService;
	
	@Autowired
	private MxkCommentsService commentsService;
	
	private CreatePartRequest createPartRequest;
	private File image;
	private String message;
	private UserVO uservo;
	private SubjectEntity currentSubjectEntity;
	private PartShowResponse partShowResponse;
	private UpdatePartInfoRequest updatePartInfoRequest;
	private SearchPartRequest request;
	private String target;//partid or subjectid
	private PartEntity partEntity;
	private LoadCommentsRespone loadCommentsRespone;
	private PartNewCommentsResponse partNewCommentsResponse;
	private SubjectNewPartsVO subjectNewPartsVO;
	private PartsAllResponse partsAllResponse;
	
	//查看
	public String mxkShowPartSilderView(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(currentSubjectEntity != null){
			partsAllResponse = new PartsAllResponse();
			List<PartEntity> list = partService.findPartEntityAll(currentSubjectEntity.getId());
			partsAllResponse.setList(list);
		}
		return SUCCESS;
	}
	
	//parts comments
	public String mxkShowPartsCommentsView(){
		uservo = super.getCurrentUserVO();
		partEntity = partService.findPartEntityById(target);
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(partEntity != null){
			subjectNewPartsVO = partService.findSubjectNewParts(partEntity.getSubjectid());
			LoadCommentsRequest request = new LoadCommentsRequest();
			request.setPage(1);
			request.setTargeid(partEntity.getId());
			request.setType(null);
			loadCommentsRespone = commentsService.findCommentEntityByPage(request);
			//loadCommentsRespone = commentsService.findCommentEntity(request);
		}
		return SUCCESS;
		
	}
	
	
	public String mxkUpdatePartInfoAjax(){
		if(updatePartInfoRequest != null){
			partService.updatePartById(updatePartInfoRequest);
			message = MxkConstant.AJAX_SUCCESS;
		}else{
			message = MxkConstant.AJAX_ERROR;
		}
		return SUCCESS;
	}
	
	//删除
	public String mxkDeletePartAjax(){
		if(target != null){
			partEntity = partService.findPartEntityById(target);
			if(partEntity != null){
				partService.removePartById(partEntity.getId());
				gridFSFileUploadService.removeFile(partEntity.getImage(),MxkGridFSFileUploadService.FILE_TYPE_IMAGE);
				gridFSFileUploadService.removeFile(partEntity.getMinimage(), MxkGridFSFileUploadService.FILE_TYPE_IMAGE);
			}
			message = MxkConstant.AJAX_SUCCESS;
		}else{
			message = MxkConstant.AJAX_ERROR;
		}
		return SUCCESS;
	}
	
	
	public String mxkShowPartDetailView(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		partEntity = partService.findPartEntityById(target);
		if(partEntity != null){
			partNewCommentsResponse = commentsService.findNewComments(partEntity.getId());
		}
		return SUCCESS;
	}

	public String mxkShowPartDetailFromMessageView(){
		uservo = super.getCurrentUserVO();
		partEntity = partService.findPartEntityById(target);
		if(partEntity != null){
			currentSubjectEntity =  subjectService.findSubjectEntityById(partEntity.getSubjectid());
		}
		return SUCCESS;
	}
	
	public String mxkfindUserSubjectPartByPageAjax(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(uservo != null && currentSubjectEntity != null){
		    partShowResponse = partService.findUserSubjectParts(request);
		}
		return SUCCESS;
	}
	
	//创建part
	public String mxkCreatePartAjax(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(uservo != null && currentSubjectEntity != null && valate()){
			createPartRequest.setSubname(currentSubjectEntity.getName());
			createPartRequest.setUserid(uservo.getId());
			createPartRequest.setUserimage(uservo.getMinimage());
			createPartRequest.setUsername(uservo.getName());
			createPartRequest.setStatus(currentSubjectEntity.getType());
			String partid = partService.savePart(createPartRequest);
			if(partid != null && image != null){
				String imageurl = gridFSFileUploadService.uploadImage(image, partid,MxkFileUploadService.IMAGE_TYPE_PNG, MxkFileUploadService.IMAGE_SIZE_FULL, max);
				String minimageurl = gridFSFileUploadService.uploadImage(image, partid,MxkFileUploadService.IMAGE_TYPE_PNG, MxkFileUploadService.IMAGE_SIZE_MINI,min);
			    if(imageurl != null && minimageurl != null){
			    	partService.updatePartImage(partid,imageurl,minimageurl);
			    	if(createPartRequest.getForfaceimage() == 1){
			    		subjectService.updateSubjectForCreatePart(createPartRequest.getSubjectid(), minimageurl);
			    		currentSubjectEntity.setFaceimage(minimageurl);
			    	}else{
			    		subjectService.updateSubjectForCreatePart(createPartRequest.getSubjectid(), null);
			    	}
		    		currentSubjectEntity.setFaceimage(minimageurl);
		    		if(MxkConstant.SUBJECT_TYPE_FOR_ALL.equals(currentSubjectEntity.getType())){
		    			subjectService.addSubjectJoinPeople(uservo, currentSubjectEntity.getId());
		    		}
			    	currentSubjectEntity.setParts(currentSubjectEntity.getParts()+1);
			    	super.setSessionData(MxkSessionContext.MXK_SUBJECT_CASH,currentSubjectEntity);
			    	NewMessagePushMessage mes = new NewMessagePushMessage();
			    	mes.setTragetId(partid);
			    	mes.setUserid(uservo.getId());
			    	mes.setSubjectId(currentSubjectEntity.getId());
			    	messageQueueService.startNewRssPushTask(mes);
			    }
			}
			message = MxkConstant.AJAX_SUCCESS;
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
	}
	
	//�οʹ���part
	public String mxkCreatePartBySubjectIdAjax(){
		//�Ժ��Ϊ�첽�ı��� activemq
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  subjectService.findSubjectEntityById(createPartRequest.getSubjectid());
		if(uservo != null && currentSubjectEntity != null && valate()){
			createPartRequest.setSubname(currentSubjectEntity.getName());
			createPartRequest.setUserid(uservo.getId());
			createPartRequest.setUserimage(uservo.getMinimage());
			createPartRequest.setUsername(uservo.getName());
			createPartRequest.setStatus(currentSubjectEntity.getType());
			String partid = partService.savePart(createPartRequest);
			if(partid != null && image != null){
				String imageurl = gridFSFileUploadService.uploadImage(image, partid,MxkFileUploadService.IMAGE_TYPE_PNG, MxkFileUploadService.IMAGE_SIZE_FULL, max);
				String minimageurl = gridFSFileUploadService.uploadImage(image, partid,MxkFileUploadService.IMAGE_TYPE_PNG, MxkFileUploadService.IMAGE_SIZE_MINI,min);
			    if(imageurl != null && minimageurl != null){
			    	partService.updatePartImage(partid,imageurl,minimageurl);
			    	subjectService.updateSubjectForCreatePart(createPartRequest.getSubjectid(), null);
			    	if(MxkConstant.SUBJECT_TYPE_FOR_ALL.equals(currentSubjectEntity.getType())){
			    		subjectService.addSubjectJoinPeople(uservo, currentSubjectEntity.getId());
			    	}
			    	currentSubjectEntity.setParts(currentSubjectEntity.getParts()+1);
			    	NewMessagePushMessage mes = new NewMessagePushMessage();
			    	mes.setTragetId(partid);
			    	mes.setUserid(uservo.getId());
			    	mes.setSubjectId(currentSubjectEntity.getId());
			    	messageQueueService.startNewRssPushTask(mes);
			    }
			}
			message = MxkConstant.AJAX_SUCCESS;
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
	}
	
	private boolean valate(){
		if(image == null){
			return false;
		}
		return true;
	}
	
	public CreatePartRequest getCreatePartRequest() {
		return createPartRequest;
	}

	public void setCreatePartRequest(CreatePartRequest createPartRequest) {
		this.createPartRequest = createPartRequest;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	public MxkPartService getPartService() {
		return partService;
	}

	public void setPartService(MxkPartService partService) {
		this.partService = partService;
	}

	public PartShowResponse getPartShowResponse() {
		return partShowResponse;
	}

	public void setPartShowResponse(PartShowResponse partShowResponse) {
		this.partShowResponse = partShowResponse;
	}

	public SearchPartRequest getRequest() {
		return request;
	}

	public void setRequest(SearchPartRequest request) {
		this.request = request;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public UserVO getUservo() {
		return uservo;
	}

	public void setUservo(UserVO uservo) {
		this.uservo = uservo;
	}

	public PartEntity getPartEntity() {
		return partEntity;
	}

	public void setPartEntity(PartEntity partEntity) {
		this.partEntity = partEntity;
	}

	public SubjectEntity getCurrentSubjectEntity() {
		return currentSubjectEntity;
	}

	public void setCurrentSubjectEntity(SubjectEntity currentSubjectEntity) {
		this.currentSubjectEntity = currentSubjectEntity;
	}

	public UpdatePartInfoRequest getUpdatePartInfoRequest() {
		return updatePartInfoRequest;
	}

	public void setUpdatePartInfoRequest(UpdatePartInfoRequest updatePartInfoRequest) {
		this.updatePartInfoRequest = updatePartInfoRequest;
	}


	public LoadCommentsRespone getLoadCommentsRespone() {
		return loadCommentsRespone;
	}


	public void setLoadCommentsRespone(LoadCommentsRespone loadCommentsRespone) {
		this.loadCommentsRespone = loadCommentsRespone;
	}


	public PartNewCommentsResponse getPartNewCommentsResponse() {
		return partNewCommentsResponse;
	}

	public void setPartNewCommentsResponse(
			PartNewCommentsResponse partNewCommentsResponse) {
		this.partNewCommentsResponse = partNewCommentsResponse;
	}


	public SubjectNewPartsVO getSubjectNewPartsVO() {
		return subjectNewPartsVO;
	}


	public void setSubjectNewPartsVO(SubjectNewPartsVO subjectNewPartsVO) {
		this.subjectNewPartsVO = subjectNewPartsVO;
	}

	public PartsAllResponse getPartsAllResponse() {
		return partsAllResponse;
	}

	public void setPartsAllResponse(PartsAllResponse partsAllResponse) {
		this.partsAllResponse = partsAllResponse;
	}

	
}
