package com.mxk.org.web.visitor.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.mxk.org.common.base.MxkSessionAction;
import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.util.ImageUtil;
import com.mxk.org.common.util.PointUtil;
import com.mxk.org.common.util.StringUtil;
import com.mxk.org.entity.CollectInformationEntity;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.web.comments.domain.LoadCommentsRequest;
import com.mxk.org.web.comments.domain.LoadCommentsRespone;
import com.mxk.org.web.comments.service.MxkCommentsService;
import com.mxk.org.web.part.domain.PartNewCommentsResponse;
import com.mxk.org.web.part.domain.PartShowResponse;
import com.mxk.org.web.part.domain.PartsAllResponse;
import com.mxk.org.web.part.domain.SearchPartRequest;
import com.mxk.org.web.part.service.MxkPartService;
import com.mxk.org.web.subject.domain.SearchSubjectRequest;
import com.mxk.org.web.subject.domain.SubjectMaterailDetailRespone;
import com.mxk.org.web.subject.domain.SubjectNewPartsVO;
import com.mxk.org.web.subject.domain.SubjectTop5NewPartsRespone;
import com.mxk.org.web.subject.domain.SubjectsShowResponse;
import com.mxk.org.web.subject.service.MxkSubjectJoinPeopleService;
import com.mxk.org.web.subject.service.MxkSubjectMaterialService;
import com.mxk.org.web.subject.service.MxkSubjectService;
import com.mxk.org.web.user.domain.UserVO;
import com.mxk.org.web.visitor.domain.CollectPartsDataReponse;
import com.mxk.org.web.visitor.domain.CollectPartsPointReponse;
import com.mxk.org.web.visitor.domain.MandomIntroducePartsReponse;
import com.mxk.org.web.visitor.domain.SearchJoinSubjectPeopleRequest;
import com.mxk.org.web.visitor.domain.SubjectJoinPeopleRespone;
import com.mxk.org.web.visitor.domain.VisitorSearchSubjectRespone;
import com.mxk.org.web.visitor.domain.VisitorSeeSubjectDashBoardRequest;
import com.mxk.org.web.visitor.domain.VisitorSeeTop10Respone;
import com.mxk.org.web.visitor.domain.VistitorSeeSubjectCommentsRespone;
/**
 * 游客action
 * @author liuyijiang
 *
 */
public class MxkVisitorAction extends MxkSessionAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6460592755721116813L;
	
	@Autowired
	private MxkPartService partService;
	
	@Autowired
	private MxkCommentsService commentsService;
	
	@Autowired
	private MxkSubjectService subjectService;
	
	@Autowired
	private MxkSubjectJoinPeopleService subjectJoinPeopleService;
	
	@Autowired
	private MxkSubjectMaterialService subjectMaterialService;
	
	private UserVO uservo;
	private UserVO targetUserVO; // part or subject ��������
	private String message;
	private PartShowResponse partShowResponse;
	private SearchPartRequest searchPartRequest;
	private SubjectsShowResponse subjectsShowResponse;
	private SubjectEntity subjectEntity;
	private PartEntity partEntity;
	private VistitorSeeSubjectCommentsRespone vistitorSeeSubjectCommentsRespone;
	private VisitorSeeSubjectDashBoardRequest visitorSeeSubjectDashBoardRequest;
	private VisitorSearchSubjectRespone visitorSearchSubjectRespone;
	private SubjectJoinPeopleRespone subjectJoinPeopleRespone;
	private SearchJoinSubjectPeopleRequest searchJoinSubjectPeopleRequest;
	private SubjectTop5NewPartsRespone subjectTop5NewPartsRespone;
	private SubjectMaterailDetailRespone subjectMaterailDetailRespone;
	private PartNewCommentsResponse partNewCommentsResponse;
	private LoadCommentsRespone loadCommentsRespone;
	private LoadCommentsRequest loadCommentsRequest;
	private SubjectNewPartsVO subjectNewPartsVO;
	private PartsAllResponse partsAllResponse;
	private String target;//partid或者subject id
	private String type;
	private CollectPartsPointReponse collectPartsPointReponse;
	private VisitorSeeTop10Respone topRespone;
	private MandomIntroducePartsReponse mandomparts;
	
	@Value("${gridfs.pdf.iamge.url}")
	private String imageurl;
	
	//游客查看part额外信息 
	public String metooVisitorSeePartsExtraInfoView(){
		uservo = super.getCurrentUserVO();
		partEntity = partService.findPartEntityById(target);
		if(partEntity != null){
			targetUserVO = super.getCachedUserVO(partEntity.getUserid());
		}
		return SUCCESS;
	}
	
	//top 10
	public String mxkVisitorShowTop10PartsView() throws Exception{
		Date end = new Date();
		Calendar rightNow = Calendar.getInstance();
	    rightNow.setTime(end);
	    if("1".equals(type)){
	    	 rightNow.add(Calendar.DAY_OF_YEAR,-7);
	    }else if("2".equals(type)){
	    	 rightNow.add(Calendar.DAY_OF_YEAR,-30);
	    }else{
	    	type = null;
	    }
	    Date start = rightNow.getTime();
	    String startTime = StringUtil.dateToString(start, null);
	    String endTime = StringUtil.dateToString(end, null);
	    List<PartEntity> list = partService.findCollectHighPartsByTimeAndType(startTime, endTime,10,type);
	    topRespone = new VisitorSeeTop10Respone();
	    topRespone.setList(list);
	    return SUCCESS;
	}
	
	public String mxkVisitorSeeUserShareSinglePartsView(){
		uservo = super.getCurrentUserVO();
		targetUserVO = super.getCachedUserVO(target);
		if(targetUserVO != null){
			SearchPartRequest request = new SearchPartRequest();
			request.setPage(1);
			request.setSubjectid(MxkConstant.MXK_EMPTY_SUBJECT);
			request.setType(null);
			request.setUserid(targetUserVO.getId());
			partShowResponse = partService.findUserShareParts(request);
			if(partShowResponse != null){
				long allPage =partService.findUserShareSinglePartsAllPage(targetUserVO.getId());
				partShowResponse.setAllPage(allPage);
			}
		    return SUCCESS;
		}else{
			return ERROR;
		}
	}
	
	public String mxkLoadMoreUserShareSinglePartsAjax(){
		partShowResponse = partService.findUserSubjectParts(searchPartRequest);
		return SUCCESS;
	}
	
	public String mxkVisitorSeeUserAjax(){
		targetUserVO = super.getCachedUserVO(target);
		return SUCCESS;
	}
	
	public String mxkVisitorShowSinglePartsCommentsView(){
		uservo = super.getCurrentUserVO();
		partEntity = partService.findPartEntityById(target);
		if(partEntity != null){
			targetUserVO = super.getCachedUserVO(partEntity.getUserid());
			LoadCommentsRequest request = new LoadCommentsRequest();
			request.setPage(1);
			request.setTargeid(partEntity.getId());
			request.setType(null);
			loadCommentsRespone = commentsService.findCommentEntityByPage(request);
		}
		return SUCCESS;
	}
	
	//查看收藏
	public String mxkVisitorShowPartsCollecterView(){
		//
		uservo = super.getCurrentUserVO();
		partEntity = partService.findPartEntityById(target);
		if(partEntity != null) {
			if(!partEntity.getSubjectid().equals(MxkConstant.MXK_EMPTY_SUBJECT)){
				subjectEntity =  subjectService.findSubjectEntityById(partEntity.getSubjectid());
				if(subjectEntity != null){
					subjectTop5NewPartsRespone = partService.findNewTop5Parts(partEntity.getSubjectid());
				}
			}
			targetUserVO = super.getCachedUserVO(partEntity.getUserid());
			ImageUtil util = new ImageUtil();
			int[] data = util.getImageWidthAndHeightFromUrl(imageurl+partEntity.getImage());
			List<CollectInformationEntity> list =  partService.findCollectInformationEntity(partEntity.getId());
			List<CollectPartsDataReponse> rlist = new ArrayList<CollectPartsDataReponse>();
			if(data != null && list != null && !list.isEmpty()){
				collectPartsPointReponse = new CollectPartsPointReponse();
				PointUtil p = new PointUtil();
				for(CollectInformationEntity en : list){
					CollectPartsDataReponse partdata = new CollectPartsDataReponse();
					partdata.setEntity(en);
					int[] dat = p.createnPositionList(data[0], data[1]);
					partdata.setTop(dat[0]);
					partdata.setLeft(dat[1]);
					rlist.add(partdata);
				}
				collectPartsPointReponse.setList(rlist);
			}
		}
		return SUCCESS;
	}
	
	//查看
	public String mxkVisitorShowPartSilderView(){
		uservo = super.getCurrentUserVO();
		subjectEntity =  subjectService.findSubjectEntityById(target);
		if(subjectEntity != null){
			targetUserVO = super.getCachedUserVO(subjectEntity.getUserid());
			partsAllResponse = new PartsAllResponse();
			List<PartEntity> list = partService.findPartEntityAll(subjectEntity.getId());
			partsAllResponse.setList(list);
		}
		return SUCCESS;
	}
	
	//加载更多subject
	public String mxkVisitorLoadMoreSubjectAjax(){
		visitorSearchSubjectRespone = new VisitorSearchSubjectRespone();
		List<SubjectEntity> list = null;
		if(visitorSeeSubjectDashBoardRequest != null){
			if(!StringUtil.stringIsEmpty(visitorSeeSubjectDashBoardRequest.getParm())){ //ģ���ԃ
				list = subjectService.findSubjectEntityByName(visitorSeeSubjectDashBoardRequest.getParm(), visitorSeeSubjectDashBoardRequest.getPage());
			}else{
				if(StringUtil.stringIsEmpty(visitorSeeSubjectDashBoardRequest.getType())){
					list = subjectService.findSubjectEntityForALl(visitorSeeSubjectDashBoardRequest.getTags(),null,visitorSeeSubjectDashBoardRequest.getPage());
				}else{
					list = subjectService.findSubjectEntityForALl(visitorSeeSubjectDashBoardRequest.getTags(),visitorSeeSubjectDashBoardRequest.getType(),visitorSeeSubjectDashBoardRequest.getPage());
				}
			}
		}
		visitorSearchSubjectRespone.setSubjectsShowResponse(subjectService.createSubjectsShowResponseByList(list));
		return SUCCESS;
	}
	
	//过滤subject
	public String mxkVisitorFilterSubjectByTypeAjax(){
		visitorSearchSubjectRespone = new VisitorSearchSubjectRespone();
		List<SubjectEntity> list = null;
		int allpage = 0;
		if(visitorSeeSubjectDashBoardRequest != null){
			list = subjectService.findSubjectEntityForALl(visitorSeeSubjectDashBoardRequest.getTags(),null,1);
			allpage = subjectService.findSubjectEntityForALlPages(visitorSeeSubjectDashBoardRequest.getTags(),null);
		}
		visitorSearchSubjectRespone.setAllPage(allpage);
		visitorSearchSubjectRespone.setSubjectsShowResponse(subjectService.createSubjectsShowResponseByList(list));
		return SUCCESS;
	}
	
	//专题面板
	public String mxkVisitiorShowSubjectDashBoradView(){
		uservo = super.getCurrentUserVO();
		visitorSearchSubjectRespone = new VisitorSearchSubjectRespone();
		List<SubjectEntity> list = null;
		int allpage = 0;
		if(visitorSeeSubjectDashBoardRequest != null){
			visitorSearchSubjectRespone.setParm(visitorSeeSubjectDashBoardRequest.getParm());
			list = subjectService.findSubjectEntityByName(visitorSeeSubjectDashBoardRequest.getParm(), 1);
			allpage = subjectService.findSubjectEntityByNamePages(visitorSeeSubjectDashBoardRequest.getParm());
		}else{
			if(StringUtil.stringIsEmpty(type)){
				list = subjectService.findSubjectEntityForALl(null,null,1);
				allpage = subjectService.findSubjectEntityForALlPages(null,null);
			}else{
				list = subjectService.findSubjectEntityForALl(null,type,1);
				allpage = subjectService.findSubjectEntityForALlPages(null,type);
			}
			
		}
		visitorSearchSubjectRespone.setAllPage(allpage);
		visitorSearchSubjectRespone.setSubjectsShowResponse(subjectService.createSubjectsShowResponseByList(list));
		return SUCCESS;
	}
	
	
	//专题评论
	public String mxkVisitiorShowSubjectComementsView(){
		uservo = super.getCurrentUserVO();
		subjectEntity =  subjectService.findSubjectEntityById(target);
		if(subjectEntity != null){
			targetUserVO = super.getCachedUserVO(subjectEntity.getUserid());
			subjectTop5NewPartsRespone = partService.findNewTop5Parts(subjectEntity.getId());
			loadCommentsRequest = new LoadCommentsRequest();
			loadCommentsRequest.setPage(1);
			loadCommentsRequest.setTargeid(subjectEntity.getId());
			loadCommentsRequest.setType(null);
			//loadCommentsRespone = commentsService.findCommentEntity(loadCommentsRequest);
			loadCommentsRespone = commentsService.findCommentEntityByPage(loadCommentsRequest);
			if(loadCommentsRespone != null){
				long allpage = commentsService.findCommentsPage(loadCommentsRequest);
				loadCommentsRespone.setAllpage(allpage);
			}
		}
		return SUCCESS;
	}
	
	public String mxkVistiorShowSubjectDatailView(){
		uservo = super.getCurrentUserVO();
		subjectEntity =  subjectService.findSubjectEntityById(target);
		if(subjectEntity != null){
			targetUserVO = super.getCachedUserVO(subjectEntity.getUserid());
			SearchPartRequest request = new SearchPartRequest();
			request.setPage(1);
			request.setSubjectid(subjectEntity.getId());
			request.setType(null);
			partShowResponse = partService.findUserSubjectParts(request);
			if(partShowResponse != null){
				partShowResponse.setAllPage(partService.findUserSubjectPartsAllPage(subjectEntity.getId()));
			}
			if(MxkConstant.SUBJECT_TYPE_FOR_ALL.equals(subjectEntity.getType())){
				if(partShowResponse != null){
					partShowResponse.setJoiner(subjectJoinPeopleService.findTop5SubjectJoiner(subjectEntity.getId()));	
				}
				return "FOR-ALL";
			}else{
				return "PUBLIC";
			}
		}
		return "PUBLIC";
	}
	
	public String mxkVistiorShowSubjectDatailFromShareView(){
		uservo = super.getCurrentUserVO();
		subjectEntity =  subjectService.findSubjectEntityById(target);
		if(subjectEntity != null){
			targetUserVO = super.getCachedUserVO(subjectEntity.getUserid());
			SearchPartRequest request = new SearchPartRequest();
			request.setPage(1);
			request.setSubjectid(subjectEntity.getId());
			request.setType(null);
			partShowResponse = partService.findUserSubjectParts(request);
			if(partShowResponse != null){
				partShowResponse.setAllPage(partService.findUserSubjectPartsAllPage(subjectEntity.getId()));
			}
			if(MxkConstant.SUBJECT_TYPE_FOR_ALL.equals(subjectEntity.getType())){
				if(partShowResponse != null){
					partShowResponse.setJoiner(subjectJoinPeopleService.findTop5SubjectJoiner(subjectEntity.getId()));	
				}
				return "FOR-ALL";
			}else{
				return "PUBLIC";
			}
		}
		return "PUBLIC";
	}
	
	
	//vistier主界面
	public String mxkVistiorShowUserIndexView(){
		uservo = super.getCurrentUserVO();
		targetUserVO = super.getCachedUserVO(target);
		SearchSubjectRequest request = new SearchSubjectRequest(targetUserVO.getId(),null,1);
		subjectsShowResponse = subjectService.findSubjectEntityBySearchRequest(request);
		return SUCCESS;
	}
	
	//partsDashBoard
	public String mxkVisitorShowPartDashBoardView(){
		uservo = super.getCurrentUserVO();
		SearchPartRequest request = new SearchPartRequest();
		request.setPage(1);
		request.setSubjectid(null);
		request.setType(null);
		partShowResponse = partService.findUserSubjectParts(request);
		long page = partService.findPartEnitiyPageByType(null);
		if(partShowResponse != null){
			partShowResponse.setAllPage(page);
		}
		
		return SUCCESS;
	}
	
	//���˲�ѯ
	public String mxkVisitorFilterPartsTypeAjax(){
		if(searchPartRequest != null){
			partShowResponse = partService.findUserSubjectParts(searchPartRequest);
			long page = partService.findPartEnitiyPageByType(searchPartRequest.getType());
			partShowResponse.setAllPage(page);
		}
		return SUCCESS;
	}
	
	public String mxkVisitorLoadMorePartsAjax(){
		if(StringUtil.stringIsEmpty(searchPartRequest.getType())){
			searchPartRequest.setType(null);
		}
//		cashpage = super.getSessionPage();
//		if(cashpage != null){
//			cashpage.setPartPage(searchPartRequest.getPage());
//			super.setSessionPage(cashpage);
//		}
		partShowResponse = partService.findUserSubjectParts(searchPartRequest);	
		return SUCCESS;
	}

	public String mxkVisitorShowPartDetailViewPop(){
		uservo = super.getCurrentUserVO();
		partEntity = partService.findPartEntityById(target);
		if(partEntity != null){
			targetUserVO = super.getCachedUserVO(partEntity.getUserid());
			subjectEntity = subjectService.findSubjectEntityById(partEntity.getSubjectid());
		    partNewCommentsResponse = commentsService.findNewComments(partEntity.getId());
		}
		return SUCCESS;
	}
	
	
	public String mxkVisitorShowPartDetailView(){
		uservo = super.getCurrentUserVO();
		partEntity = partService.findPartEntityById(target);
		if(partEntity != null){
			targetUserVO = super.getCachedUserVO(partEntity.getUserid());
			subjectEntity = subjectService.findSubjectEntityById(partEntity.getSubjectid());
		    partNewCommentsResponse = commentsService.findNewComments(partEntity.getId());
		    mandomparts = new MandomIntroducePartsReponse();
		    mandomparts.setList(partService.findUserPartsMadom(partEntity.getUserid(),2));
		}
		return SUCCESS;
	}
	
	public String mxkVisitorShowPartDetailFromShareView(){
		uservo = super.getCurrentUserVO();
		partEntity = partService.findPartEntityById(target);
		if(partEntity != null){
			targetUserVO = super.getCachedUserVO(partEntity.getUserid());
			subjectEntity = subjectService.findSubjectEntityById(partEntity.getSubjectid());
		    partNewCommentsResponse = commentsService.findNewComments(partEntity.getId());
		    mandomparts = new MandomIntroducePartsReponse();
		    mandomparts.setList(partService.findUserPartsMadom(partEntity.getUserid(),2));
		}
		return SUCCESS;
	}
	
	public String mxkVisitorShowPartsCommnetsView(){
		uservo = super.getCurrentUserVO();
		partEntity = partService.findPartEntityById(target);
		if(partEntity != null){
			targetUserVO = super.getCachedUserVO(partEntity.getUserid());
			subjectNewPartsVO = partService.findSubjectNewParts(partEntity.getSubjectid());
			subjectEntity =  subjectService.findSubjectEntityById(partEntity.getSubjectid());
			LoadCommentsRequest request = new LoadCommentsRequest();
			request.setPage(1);
			request.setTargeid(partEntity.getId());
			request.setType(null);
			loadCommentsRespone = commentsService.findCommentEntityByPage(request);
			//loadCommentsRespone = commentsService.findCommentEntity(request);
		}
		return SUCCESS;
	}
	
	//加入专题用户
	public String mxkVisitorShowJoinSubjectUsersView(){
		uservo = super.getCurrentUserVO();
		subjectEntity =  subjectService.findSubjectEntityById(target);
		if(subjectEntity != null){
			targetUserVO = super.getCachedUserVO(subjectEntity.getUserid());
			subjectTop5NewPartsRespone = partService.findNewTop5Parts(subjectEntity.getId());
			long page = subjectJoinPeopleService.findSubjectJoinerAllPage(subjectEntity.getId());
			subjectJoinPeopleRespone = subjectJoinPeopleService.findSubjectJoinerByPage(subjectEntity.getId(),1);
			if(subjectJoinPeopleRespone != null){
				subjectJoinPeopleRespone.setAllpage(page);
			}
		}
		return SUCCESS;
	}
	
	public String mxkVisitorLoadMoreJoinSubjectUsersAjax(){
		if(searchJoinSubjectPeopleRequest != null){
			subjectJoinPeopleRespone = subjectJoinPeopleService.findSubjectJoinerByPage(searchJoinSubjectPeopleRequest.getSubjectid(),searchJoinSubjectPeopleRequest.getPage());
		}
		return SUCCESS;
	}
	
	public String mxkVisitorShowForAllSubjectDashBoardView(){
		uservo = super.getCurrentUserVO();
		return SUCCESS;
	}
	
	public String mxkVisitorShowSubjectMaterialView(){
		uservo = super.getCurrentUserVO();
		subjectEntity =  subjectService.findSubjectEntityById(target);
		if(subjectEntity != null){
			targetUserVO = super.getCachedUserVO(subjectEntity.getUserid());
			subjectMaterailDetailRespone = subjectMaterialService.findUserSubjectMaterials(subjectEntity.getId());	
		    if(subjectMaterailDetailRespone.getList() != null && !subjectMaterailDetailRespone.getList().isEmpty()){
		    	String chartData = subjectMaterialService.createMaterialChartData(subjectMaterailDetailRespone.getList());
		    	subjectMaterailDetailRespone.setChartData(chartData);
		    }
		}
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

	public PartShowResponse getPartShowResponse() {
		return partShowResponse;
	}

	public void setPartShowResponse(PartShowResponse partShowResponse) {
		this.partShowResponse = partShowResponse;
	}

	public SearchPartRequest getSearchPartRequest() {
		return searchPartRequest;
	}

	public void setSearchPartRequest(SearchPartRequest searchPartRequest) {
		this.searchPartRequest = searchPartRequest;
	}

	public SubjectEntity getSubjectEntity() {
		return subjectEntity;
	}

	public void setSubjectEntity(SubjectEntity subjectEntity) {
		this.subjectEntity = subjectEntity;
	}

	public PartEntity getPartEntity() {
		return partEntity;
	}

	public void setPartEntity(PartEntity partEntity) {
		this.partEntity = partEntity;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public UserVO getTargetUserVO() {
		return targetUserVO;
	}

	public void setTargetUserVO(UserVO targetUserVO) {
		this.targetUserVO = targetUserVO;
	}


	public SubjectsShowResponse getSubjectsShowResponse() {
		return subjectsShowResponse;
	}


	public void setSubjectsShowResponse(SubjectsShowResponse subjectsShowResponse) {
		this.subjectsShowResponse = subjectsShowResponse;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}


	public VistitorSeeSubjectCommentsRespone getVistitorSeeSubjectCommentsRespone() {
		return vistitorSeeSubjectCommentsRespone;
	}

	public void setVistitorSeeSubjectCommentsRespone(
			VistitorSeeSubjectCommentsRespone vistitorSeeSubjectCommentsRespone) {
		this.vistitorSeeSubjectCommentsRespone = vistitorSeeSubjectCommentsRespone;
	}

	public VisitorSeeSubjectDashBoardRequest getVisitorSeeSubjectDashBoardRequest() {
		return visitorSeeSubjectDashBoardRequest;
	}

	public void setVisitorSeeSubjectDashBoardRequest(
			VisitorSeeSubjectDashBoardRequest visitorSeeSubjectDashBoardRequest) {
		this.visitorSeeSubjectDashBoardRequest = visitorSeeSubjectDashBoardRequest;
	}


	public VisitorSearchSubjectRespone getVisitorSearchSubjectRespone() {
		return visitorSearchSubjectRespone;
	}


	public void setVisitorSearchSubjectRespone(
			VisitorSearchSubjectRespone visitorSearchSubjectRespone) {
		this.visitorSearchSubjectRespone = visitorSearchSubjectRespone;
	}

	public SubjectJoinPeopleRespone getSubjectJoinPeopleRespone() {
		return subjectJoinPeopleRespone;
	}

	public void setSubjectJoinPeopleRespone(
			SubjectJoinPeopleRespone subjectJoinPeopleRespone) {
		this.subjectJoinPeopleRespone = subjectJoinPeopleRespone;
	}

	public SearchJoinSubjectPeopleRequest getSearchJoinSubjectPeopleRequest() {
		return searchJoinSubjectPeopleRequest;
	}

	public void setSearchJoinSubjectPeopleRequest(
			SearchJoinSubjectPeopleRequest searchJoinSubjectPeopleRequest) {
		this.searchJoinSubjectPeopleRequest = searchJoinSubjectPeopleRequest;
	}

	public SubjectTop5NewPartsRespone getSubjectTop5NewPartsRespone() {
		return subjectTop5NewPartsRespone;
	}

	public void setSubjectTop5NewPartsRespone(
			SubjectTop5NewPartsRespone subjectTop5NewPartsRespone) {
		this.subjectTop5NewPartsRespone = subjectTop5NewPartsRespone;
	}

	public SubjectMaterailDetailRespone getSubjectMaterailDetailRespone() {
		return subjectMaterailDetailRespone;
	}

	public void setSubjectMaterailDetailRespone(
			SubjectMaterailDetailRespone subjectMaterailDetailRespone) {
		this.subjectMaterailDetailRespone = subjectMaterailDetailRespone;
	}

	public PartNewCommentsResponse getPartNewCommentsResponse() {
		return partNewCommentsResponse;
	}

	public void setPartNewCommentsResponse(
			PartNewCommentsResponse partNewCommentsResponse) {
		this.partNewCommentsResponse = partNewCommentsResponse;
	}

	public LoadCommentsRespone getLoadCommentsRespone() {
		return loadCommentsRespone;
	}

	public void setLoadCommentsRespone(LoadCommentsRespone loadCommentsRespone) {
		this.loadCommentsRespone = loadCommentsRespone;
	}

	public LoadCommentsRequest getLoadCommentsRequest() {
		return loadCommentsRequest;
	}

	public void setLoadCommentsRequest(LoadCommentsRequest loadCommentsRequest) {
		this.loadCommentsRequest = loadCommentsRequest;
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

	public CollectPartsPointReponse getCollectPartsPointReponse() {
		return collectPartsPointReponse;
	}

	public void setCollectPartsPointReponse(
			CollectPartsPointReponse collectPartsPointReponse) {
		this.collectPartsPointReponse = collectPartsPointReponse;
	}

	public VisitorSeeTop10Respone getTopRespone() {
		return topRespone;
	}

	public void setTopRespone(VisitorSeeTop10Respone topRespone) {
		this.topRespone = topRespone;
	}

	public MandomIntroducePartsReponse getMandomparts() {
		return mandomparts;
	}

	public void setMandomparts(MandomIntroducePartsReponse mandomparts) {
		this.mandomparts = mandomparts;
	}

	
}
