package com.mxk.org.web.subject.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.mxk.org.common.base.MxkSessionAction;
import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.domain.session.MxkSessionContext;
import com.mxk.org.common.factory.EntityFactory;
import com.mxk.org.common.message.domain.DeleteSubjectMessage;
import com.mxk.org.common.message.domain.ExcelCreateMessage;
import com.mxk.org.common.message.serivce.MxkMessageQueueService;
import com.mxk.org.common.service.MxkGifService;
import com.mxk.org.common.service.MxkGridFSFileUploadService;
import com.mxk.org.common.service.MxkPdfService;
import com.mxk.org.common.service.MxkRedisCacheService;
import com.mxk.org.common.util.StringUtil;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.entity.SubjectExtraEntity;
import com.mxk.org.entity.SubjectMaterialSummaryEntity;
import com.mxk.org.entity.SubjectWorkingEntity;
import com.mxk.org.entity.UserRssSubjectEntity;
import com.mxk.org.web.comments.domain.LoadCommentsRequest;
import com.mxk.org.web.comments.domain.LoadCommentsRespone;
import com.mxk.org.web.comments.service.MxkCommentsService;
import com.mxk.org.web.part.domain.PartShowResponse;
import com.mxk.org.web.part.domain.SearchPartRequest;
import com.mxk.org.web.part.service.MxkPartService;
import com.mxk.org.web.subject.domain.CreateSubjectMaiterialRequest;
import com.mxk.org.web.subject.domain.CreateSubjectRequest;
import com.mxk.org.web.subject.domain.CreateSubjectWorkingRequest;
import com.mxk.org.web.subject.domain.RemoveRssSubjectRequest;
import com.mxk.org.web.subject.domain.RssSubjectRequest;
import com.mxk.org.web.subject.domain.SetFaceImageRequest;
import com.mxk.org.web.subject.domain.ShowRssSubjectResponse;
import com.mxk.org.web.subject.domain.ShowRssSubjectUserRequest;
import com.mxk.org.web.subject.domain.SubjectMaterailDetailRespone;
import com.mxk.org.web.subject.domain.SubjectMessageShowRespone;
import com.mxk.org.web.subject.domain.SubjectNewPartsVO;
import com.mxk.org.web.subject.domain.SubjectTop5NewPartsRespone;
import com.mxk.org.web.subject.domain.UpdateSubjectStatusRequest;
import com.mxk.org.web.subject.service.MxkSubjectJoinPeopleService;
import com.mxk.org.web.subject.service.MxkSubjectMaterialService;
import com.mxk.org.web.subject.service.MxkSubjectService;
import com.mxk.org.web.user.domain.UserVO;

/**
 * 
 * @author liuyijiang
 *
 */
public class MxkSubjectAction extends MxkSessionAction {
  
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5214867227320080224L;

	@Value("${moosefs.file.image.subject.default}")
	private String defaultImageUrl;
	
	@Autowired
	private MxkSubjectService subjectService;
	
	@Autowired
	private MxkPartService partService;
	
	@Autowired
	private MxkPdfService pdfService;
	
	@Autowired
	private MxkRedisCacheService redisCacheService;
	
	@Autowired
	private MxkSubjectMaterialService subjectMaterialService;
	
	@Autowired
	private MxkGridFSFileUploadService gridFSFileUploadService;
	
	@Autowired
	private MxkMessageQueueService messageQueueService;
	
	@Autowired
	private MxkGifService gifService;
	
	@Autowired
	private MxkCommentsService commentsService;
	
	@Autowired
	private MxkSubjectJoinPeopleService subjectJoinPeopleService;
	
	private CreateSubjectRequest createSubjectRequest;
	
	private UserVO uservo;
	private String message;
	private String subid;
	private SubjectEntity currentSubjectEntity;
	private PartShowResponse partShowResponse;
	private SetFaceImageRequest setFaceImageRequest;
	private UpdateSubjectStatusRequest updateSubjectStatusRequest;
	private SearchPartRequest searchPartRequest;
	private String partids;
	private RssSubjectRequest rssSubjectRequest;
	private ShowRssSubjectResponse showRssSubjectResponse;
	private ShowRssSubjectUserRequest showRssSubjectUserRequest;
	private String type;
	private SubjectMessageShowRespone subjectMessageShowRespone;
	private RemoveRssSubjectRequest removeRssSubjectRequest;
	private LoadCommentsRequest loadCommentsRequest;
	private LoadCommentsRespone loadCommentsRespone; 
	private CreateSubjectMaiterialRequest createSubjectMaiterialRequest;
	private SubjectMaterailDetailRespone subjectMaterailDetailRespone;
	private SubjectExtraEntity subjectExtraEntity;
	private SubjectTop5NewPartsRespone subjectTop5NewPartsRespone;
	private CreateSubjectWorkingRequest createSubjectWorkingRequest;
	private Map<String,String> subjectWorkingChart;
	private String targetId;
	
	//更新subjsct
	public String mxkUpdateSubjectAjax(){
		uservo = getCurrentUserVO();
		message = MxkConstant.AJAX_SUCCESS;
		if(uservo != null && createSubjectRequest != null){
			createSubjectRequest.setUserid(uservo.getId());
			subjectService.updateSubjectEntity(createSubjectRequest);
		}
		return SUCCESS;
	}
	
	//创建进度
	public String mxkCreateSubjectWorking(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(createSubjectWorkingRequest != null && uservo != null && currentSubjectEntity != null){
			String todayTime = StringUtil.todayStartTime();
			SubjectWorkingEntity swe = subjectService.findSubjectWorkingEntityByDate(uservo.getId(), currentSubjectEntity.getId(), todayTime);
			createSubjectWorkingRequest.setUserid(uservo.getId());
			createSubjectWorkingRequest.setSubjectid(currentSubjectEntity.getId());
			createSubjectWorkingRequest.setCreateTime(todayTime);
			//去除符号
			StringBuffer sb = new StringBuffer();
			sb.append(createSubjectWorkingRequest.getDoc().replace(MxkConstant.ARRY_MARK, MxkConstant.MXK_EMPTY)); 
			sb.append(MxkConstant.MXK_EMPTY+"["+StringUtil.dateToString(new Date(), null) +"]"+MxkConstant.ARRY_MARK);
			if(swe != null){
				createSubjectWorkingRequest.setDoc(createSubjectWorkingRequest.getDoc()+sb.toString());
		    	SubjectWorkingEntity entity = EntityFactory.createSubjectWorkingEntity(createSubjectWorkingRequest);
		    	subjectService.updateSubjectWorkingEntity(entity);
		    }else{
		    	List<String> dous = new ArrayList<String>();
		    	dous.add(createSubjectWorkingRequest.getDoc());
		    	createSubjectWorkingRequest.setDoc(sb.toString());
		    	SubjectWorkingEntity entity = EntityFactory.createSubjectWorkingEntity(createSubjectWorkingRequest);
		    	subjectService.saveSubjectWorkingEntity(entity);
		    }
		}
		return SUCCESS;
	}
	
	public String mxkDeleteSubjectAjax(){
		message = MxkConstant.USER_NO_LOGIN;
		uservo = super.getCurrentUserVO();
		if(targetId != null && uservo != null){
			currentSubjectEntity = subjectService.findSubjectEntityById(targetId);
			if(currentSubjectEntity != null){
				if(currentSubjectEntity.getUserid().equals(uservo.getId())){
					if(subjectService.deleteSubject(currentSubjectEntity.getId())){
						DeleteSubjectMessage mess = new DeleteSubjectMessage();
						mess.setSubjectid(currentSubjectEntity.getId());
						messageQueueService.startDeleteSubjectTask(mess);
						message = MxkConstant.AJAX_SUCCESS;
					}else{
						message = MxkConstant.AJAX_ERROR;
					}
				}
			}
		}
		return SUCCESS;
	}
	
	public String mxkSubjectCommentsView(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(currentSubjectEntity != null){
			//���5�����µ�
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
		return SUCCESS;
	}
	
	public String mxkLoadMoreSubjectCommentsAjax(){
		if(loadCommentsRequest != null){
			loadCommentsRespone = commentsService.findCommentEntity(loadCommentsRequest);
		}
		return SUCCESS;
	}
	
	public String mxkfilerSubjectCommentsAjax(){
		if(loadCommentsRequest != null){
			loadCommentsRespone = commentsService.findCommentEntity(loadCommentsRequest);
			if(loadCommentsRespone != null){
				long allpage = commentsService.findCommentsPage(loadCommentsRequest);
				loadCommentsRespone.setAllpage(allpage);
			}
		}
		return SUCCESS;
	}
	
	
	//������Ϣ
	public String mxkSubjectMessageView(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(currentSubjectEntity != null){
			subjectMessageShowRespone = new SubjectMessageShowRespone();
			subjectMessageShowRespone.setSubjectEntity(currentSubjectEntity);
			SubjectNewPartsVO subjectNewPartsVO = partService.findSubjectNewParts(currentSubjectEntity.getId());
			subjectMessageShowRespone.setSubjectNewPartsVO(subjectNewPartsVO);
			List<UserRssSubjectEntity> list = subjectService.findSubjectRssByPage(currentSubjectEntity.getId(),1);
			subjectMessageShowRespone.setList(list);
		}
		return SUCCESS;
	}
	
	//subject ���� text
	public String mxkSubjectCommentsTextView(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(currentSubjectEntity != null){
			subjectMessageShowRespone = new SubjectMessageShowRespone();
			subjectMessageShowRespone.setSubjectEntity(currentSubjectEntity);
			SubjectNewPartsVO subjectNewPartsVO = partService.findSubjectNewParts(currentSubjectEntity.getId());
			subjectMessageShowRespone.setSubjectNewPartsVO(subjectNewPartsVO);
		}
		return SUCCESS;
	}
	
	//subject ���� wav
	public String mxkSubjectCommentsWavView(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(currentSubjectEntity != null){
			subjectMessageShowRespone = new SubjectMessageShowRespone();
			subjectMessageShowRespone.setSubjectEntity(currentSubjectEntity);
			SubjectNewPartsVO subjectNewPartsVO = partService.findSubjectNewParts(currentSubjectEntity.getId());
			subjectMessageShowRespone.setSubjectNewPartsVO(subjectNewPartsVO);
		}
		return SUCCESS;
	}
	
	
	//��ҳ��ʾ��ඩ����Ϣ
	public String mxkSubjectMessageMoreAjax(){
		if(showRssSubjectUserRequest != null){
			List<UserRssSubjectEntity> list = subjectService.findSubjectRssByPage(showRssSubjectUserRequest.getSubjectid(),showRssSubjectUserRequest.getPage());
			subjectMessageShowRespone = new SubjectMessageShowRespone();
			subjectMessageShowRespone.setList(list);
		}
		return SUCCESS;
	}
	
	//ɾ����
	public String mxkRemoveRssSubjectAjax(){
		message = MxkConstant.AJAX_ERROR;	
		if(removeRssSubjectRequest != null){
			if(subjectService.removeUserRssSubejct(removeRssSubjectRequest.getUserid(),removeRssSubjectRequest.getSubjectid())){
				redisCacheService.removeCachUserRssSubject(removeRssSubjectRequest.getUserid(),removeRssSubjectRequest.getSubjectid());
				message = MxkConstant.AJAX_SUCCESS;
			}
		}
		return SUCCESS;
	}
	
	//����ר��
	public String mxkRssSubjectAjax(){
		message = MxkConstant.AJAX_ERROR;	
		uservo = super.getCurrentUserVO();
		if(uservo != null && rssSubjectRequest != null){
			rssSubjectRequest.setUserdesc(uservo.getInfo());
			rssSubjectRequest.setUserid(uservo.getId());
			rssSubjectRequest.setUserimage(uservo.getImage());
			rssSubjectRequest.setUsername(uservo.getName());
			if(subjectService.createUserRssSubject(rssSubjectRequest)){
				redisCacheService.cachUserRssSubject(uservo.getId(), rssSubjectRequest.getSubjectid());
			}
			message = MxkConstant.AJAX_SUCCESS;
		}else{
			message = MxkConstant.USER_NO_LOGIN;
		}
		return SUCCESS;
	}
	
	
	
	//�޸�״̬
	public String mxkChangeSubjectStatusAjax(){
		message = MxkConstant.AJAX_ERROR;	
		if(updateSubjectStatusRequest != null){
			uservo = super.getCurrentUserVO();
			SubjectEntity subjectEntity = subjectService.findSubjectEntityById(updateSubjectStatusRequest.getId());
			if(subjectEntity != null && uservo != null){
				if(uservo.getId().equals(subjectEntity.getUserid())){//�ǵ�ǰ�û���
					if(!MxkConstant.SUBJECT_TYPE_FOR_ALL.equals(subjectEntity.getType())){
						if(subjectService.updateSubjectStatus(updateSubjectStatusRequest)){
							subjectEntity.setType(updateSubjectStatusRequest.getStauts());
							super.setSessionData(MxkSessionContext.MXK_SUBJECT_CASH,subjectEntity);
							message = MxkConstant.AJAX_SUCCESS;
						}
					}else{
						long num = partService.findSubjectPartNotInUserId(subjectEntity.getId(),subjectEntity.getUserid());
					    if(num != 0){
					    	message = MxkConstant.STATUS_CHANGE_FAIL;
					    }else{
					    	if(subjectService.updateSubjectStatus(updateSubjectStatusRequest)){
					    		subjectEntity.setType(updateSubjectStatusRequest.getStauts());
								super.setSessionData(MxkSessionContext.MXK_SUBJECT_CASH,subjectEntity);
								message = MxkConstant.AJAX_SUCCESS;
							}
					    }
					}
				}
			}
		}
		return SUCCESS;
	}
	
	public String mxkCreateGifAjax(){
		message = MxkConstant.AJAX_ERROR;
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if (currentSubjectEntity != null) {
			if(partids != null){
				List<String> ids = Arrays.asList(partids.split(","));
				File file = gifService.createSubjectGifByParts(ids, currentSubjectEntity.getId());
			    if (file != null) {
			    	String fileName = currentSubjectEntity.getId() + MxkGridFSFileUploadService.FILE_TYPE_GIF;
					gridFSFileUploadService.removeFile(fileName, MxkGridFSFileUploadService.FILE_TYPE_GIF);
					String url = gridFSFileUploadService.uploadFile(file, currentSubjectEntity.getId(), MxkGridFSFileUploadService.FILE_TYPE_GIF);
					subjectService.updateSubjectExtraUrl(currentSubjectEntity.getId(), "gifUrl", url);
				    file.delete();
				    message = MxkConstant.AJAX_SUCCESS;
			    }
			}
		}
		return SUCCESS;
	}
	
	public String mxkCreatePdfAjax(){
		message = MxkConstant.AJAX_ERROR;
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(uservo != null && currentSubjectEntity != null){
			if(partids != null){
				List<String> ids = Arrays.asList(partids.split(","));
				File file = pdfService.createSubjectPdfByParts(ids, currentSubjectEntity, uservo.getName());
				if(file != null){
					String fileName = currentSubjectEntity.getId() + MxkGridFSFileUploadService.FILE_TYPE_PDF;
					gridFSFileUploadService.removeFile(fileName, MxkGridFSFileUploadService.FILE_TYPE_PDF);
					String url = gridFSFileUploadService.uploadFile(file, currentSubjectEntity.getId(), MxkGridFSFileUploadService.FILE_TYPE_PDF);
					subjectService.updateSubjectExtraUrl(currentSubjectEntity.getId(), "pdfUrl", url);
				    file.delete();
				    message = MxkConstant.AJAX_SUCCESS;
				}
			}
		}
		return SUCCESS;
	}
	
	
	//����ר�����
	public String mxkSetSubjectFaceImageAjax(){
		if(setFaceImageRequest != null){
			subjectService.setSubjectFaceImage(setFaceImageRequest);
			SubjectEntity subjectEntity = subjectService.findSubjectEntityById(setFaceImageRequest.getSubjectid());
			super.setSessionData(MxkSessionContext.MXK_SUBJECT_CASH,subjectEntity);
			message = MxkConstant.AJAX_SUCCESS;
		}else{
			message = MxkConstant.AJAX_ERROR;
		}
		return SUCCESS;
	}
	
	//��ת���½�ר��ҳ��
	public String mxkShowCreateSubjectView(){
		uservo = super.getCurrentUserVO();
		return SUCCESS;
	}
	
	//���浱ǰר�� Ȼ����ת��������id
	public String mxkCachSubject(){
		SubjectEntity subjectEntity = subjectService.findSubjectEntityById(subid);
		if(subjectEntity != null){
			super.setSessionData(MxkSessionContext.MXK_SUBJECT_CASH,subjectEntity);
			return SUCCESS;
		}else{
			return ERROR;
		}
	}
	
	//��ʾsubject ר��������
	public String mxkShowSubjectDetailView(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(uservo != null && currentSubjectEntity != null){
			//进度
				SearchPartRequest request = new SearchPartRequest();
				request.setPage(1);
				request.setSubjectid(currentSubjectEntity.getId());
				request.setType(null);
				request.setUserid(uservo.getId());
				partShowResponse = partService.findUserSubjectParts(request);
				if(partShowResponse != null){
					partShowResponse.setAllPage(partService.findUserSubjectPartsAllPage(currentSubjectEntity.getId()));
				}
//				if(MxkSubjectcCategory.SUBJECT_CATEGORY_WORKING.getString().equals(currentSubjectEntity.getCategory())){
//					subjectWorkingChart = subjectService.findSubjectWorkingData(uservo.getId(), currentSubjectEntity.getId());
//					return "WORKING";
//				}
				if(MxkConstant.SUBJECT_TYPE_FOR_ALL.equals(currentSubjectEntity.getType())){
					if(partShowResponse != null){
						partShowResponse.setJoiner(subjectJoinPeopleService.findTop5SubjectJoiner(currentSubjectEntity.getId()));	
					}
					return MxkConstant.SUBJECT_TYPE_FOR_ALL;
				}else{
					SubjectMaterialSummaryEntity ss = subjectMaterialService.findSubjectMaterialSummaryEntityBySubjectId(currentSubjectEntity.getId());
					subjectExtraEntity = subjectService.findSubjectExtraEntity(currentSubjectEntity.getId());
					if(ss != null){
						message = MxkConstant.AJAX_SUCCESS; //�в���
					}else{
						message = MxkConstant.AJAX_ERROR;
					}
					return MxkConstant.SUBJECT_TYPE_PUBLIC;
				}
		}else{
			return ERROR;
		}
	}
	
	//��ҳ���ظ��
	public String mxkLoadMoreSubjectPartsAjax(){
		partShowResponse = partService.findUserSubjectParts(searchPartRequest);	
		return SUCCESS;
	}
	
	//�½�ר��
	public String mxkCreateSubject(){
		uservo = getCurrentUserVO();
		if(valiate(createSubjectRequest) && uservo != null){
			createSubjectRequest.setUserid(uservo.getId());
			createSubjectRequest.setFaceiamge(defaultImageUrl);
			if(subjectService.saveSubject(createSubjectRequest)){
				uservo.setSubject(uservo.getSubject() + 1);
				super.updateCurrentUserVO(uservo);
				return SUCCESS;
			}else{
				return ERROR;
			}
		}else{
			return ERROR;
		}
	}
	
	//�������
	public String mxkUpdateSujectMaterial() {
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(createSubjectMaiterialRequest != null){
			SubjectMaterialSummaryEntity summary = new SubjectMaterialSummaryEntity();
			summary.setSubjectId(currentSubjectEntity.getId());
			summary.setUserid(currentSubjectEntity.getUserid());
			summary.setId(createSubjectMaiterialRequest.getSummaryid());
			if(subjectMaterialService.createSubjectMaterial(summary, createSubjectMaiterialRequest.getList())){
				ExcelCreateMessage mes = new ExcelCreateMessage();
				mes.setSummaryId(summary.getId());
				messageQueueService.startExcelCreateTask(mes);
			}
			message = MxkConstant.AJAX_SUCCESS; //�в���
		}
		return SUCCESS;
	}
	
	public String mxkDeleteSubjectMaterialAjax() {
		message = MxkConstant.AJAX_SUCCESS; //�в���	
		if(targetId != null){
			subjectMaterialService.delateSubjectMaterailDetailById(targetId);
		}
		return SUCCESS;
	}
	
	public String mxkCreateSubjectMaterial(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(createSubjectMaiterialRequest != null){
			SubjectMaterialSummaryEntity summary = new SubjectMaterialSummaryEntity();
			summary.setCreateTime(StringUtil.dateToString(new Date(), null));
			summary.setSubjectId(currentSubjectEntity.getId());
			summary.setUserid(currentSubjectEntity.getUserid());
			if(subjectMaterialService.createSubjectMaterial(summary, createSubjectMaiterialRequest.getList())){
				ExcelCreateMessage mes = new ExcelCreateMessage();
				mes.setSummaryId(summary.getId());
				messageQueueService.startExcelCreateTask(mes);
			}
			message = MxkConstant.AJAX_SUCCESS; //�в���
		}
		return SUCCESS;
	}
	
	//չʾ
	public String mxkShowSubjectMaterialView(){
		uservo = super.getCurrentUserVO();
		currentSubjectEntity =  super.getSessionData(MxkSessionContext.MXK_SUBJECT_CASH, SubjectEntity.class);
		if(currentSubjectEntity != null){
			subjectMaterailDetailRespone = subjectMaterialService.findUserSubjectMaterials(currentSubjectEntity.getId());	
			 if(subjectMaterailDetailRespone.getList() != null && !subjectMaterailDetailRespone.getList().isEmpty()){
			    	String chartData = subjectMaterialService.createMaterialChartData(subjectMaterailDetailRespone.getList());
			    	subjectMaterailDetailRespone.setChartData(chartData);
			 }
		}
		return SUCCESS;
	}

	private boolean valiate(CreateSubjectRequest createSubjectRequest){
		if (createSubjectRequest == null){
			return false;
		}
		if (StringUtil.stringIsEmpty(createSubjectRequest.getName())) {
			return false;
		}
		if (StringUtil.stringIsEmpty(createSubjectRequest.getInfo())) {
			return false;
		}
		if (StringUtil.stringIsEmpty(createSubjectRequest.getType())) {
			return false;
		}
		return true;
	}
	
	public CreateSubjectRequest getCreateSubjectRequest() {
		return createSubjectRequest;
	}

	public void setCreateSubjectRequest(CreateSubjectRequest createSubjectRequest) {
		this.createSubjectRequest = createSubjectRequest;
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

	public String getSubid() {
		return subid;
	}

	public void setSubid(String subid) {
		this.subid = subid;
	}

	public SubjectEntity getCurrentSubjectEntity() {
		return currentSubjectEntity;
	}

	public void setCurrentSubjectEntity(SubjectEntity currentSubjectEntity) {
		this.currentSubjectEntity = currentSubjectEntity;
	}

	public PartShowResponse getPartShowResponse() {
		return partShowResponse;
	}

	public void setPartShowResponse(PartShowResponse partShowResponse) {
		this.partShowResponse = partShowResponse;
	}


	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public SetFaceImageRequest getSetFaceImageRequest() {
		return setFaceImageRequest;
	}


	public void setSetFaceImageRequest(SetFaceImageRequest setFaceImageRequest) {
		this.setFaceImageRequest = setFaceImageRequest;
	}

	public UpdateSubjectStatusRequest getUpdateSubjectStatusRequest() {
		return updateSubjectStatusRequest;
	}

	public void setUpdateSubjectStatusRequest(
			UpdateSubjectStatusRequest updateSubjectStatusRequest) {
		this.updateSubjectStatusRequest = updateSubjectStatusRequest;
	}

	public SearchPartRequest getSearchPartRequest() {
		return searchPartRequest;
	}

	public void setSearchPartRequest(SearchPartRequest searchPartRequest) {
		this.searchPartRequest = searchPartRequest;
	}

	public String getPartids() {
		return partids;
	}

	public void setPartids(String partids) {
		this.partids = partids;
	}

	public RssSubjectRequest getRssSubjectRequest() {
		return rssSubjectRequest;
	}

	public void setRssSubjectRequest(RssSubjectRequest rssSubjectRequest) {
		this.rssSubjectRequest = rssSubjectRequest;
	}

	public ShowRssSubjectResponse getShowRssSubjectResponse() {
		return showRssSubjectResponse;
	}

	public void setShowRssSubjectResponse(
			ShowRssSubjectResponse showRssSubjectResponse) {
		this.showRssSubjectResponse = showRssSubjectResponse;
	}

	public ShowRssSubjectUserRequest getShowRssSubjectUserRequest() {
		return showRssSubjectUserRequest;
	}

	public void setShowRssSubjectUserRequest(
			ShowRssSubjectUserRequest showRssSubjectUserRequest) {
		this.showRssSubjectUserRequest = showRssSubjectUserRequest;
	}

	public SubjectMessageShowRespone getSubjectMessageShowRespone() {
		return subjectMessageShowRespone;
	}

	public void setSubjectMessageShowRespone(
			SubjectMessageShowRespone subjectMessageShowRespone) {
		this.subjectMessageShowRespone = subjectMessageShowRespone;
	}

	public RemoveRssSubjectRequest getRemoveRssSubjectRequest() {
		return removeRssSubjectRequest;
	}

	public void setRemoveRssSubjectRequest(
			RemoveRssSubjectRequest removeRssSubjectRequest) {
		this.removeRssSubjectRequest = removeRssSubjectRequest;
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

	public CreateSubjectMaiterialRequest getCreateSubjectMaiterialRequest() {
		return createSubjectMaiterialRequest;
	}

	public void setCreateSubjectMaiterialRequest(
			CreateSubjectMaiterialRequest createSubjectMaiterialRequest) {
		this.createSubjectMaiterialRequest = createSubjectMaiterialRequest;
	}

	public SubjectMaterailDetailRespone getSubjectMaterailDetailRespone() {
		return subjectMaterailDetailRespone;
	}

	public void setSubjectMaterailDetailRespone(
			SubjectMaterailDetailRespone subjectMaterailDetailRespone) {
		this.subjectMaterailDetailRespone = subjectMaterailDetailRespone;
	}

	public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}

	public SubjectExtraEntity getSubjectExtraEntity() {
		return subjectExtraEntity;
	}

	public void setSubjectExtraEntity(SubjectExtraEntity subjectExtraEntity) {
		this.subjectExtraEntity = subjectExtraEntity;
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

	public Map<String, String> getSubjectWorkingChart() {
		return subjectWorkingChart;
	}

	public void setSubjectWorkingChart(Map<String, String> subjectWorkingChart) {
		this.subjectWorkingChart = subjectWorkingChart;
	}

	
}
