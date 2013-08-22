package com.mxk.org.web.comments.action;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.base.MxkSessionAction;
import com.mxk.org.common.domain.constant.MetooGiftResultMessage;
import com.mxk.org.common.domain.constant.MetooPointTypeConstant;
import com.mxk.org.common.domain.constant.MetooResultMessage;
import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.domain.constant.MxkSubjectcCategory;
import com.mxk.org.common.message.serivce.MxkMessageQueueService;
import com.mxk.org.common.service.MxkGridFSFileUploadService;
import com.mxk.org.common.util.HttpUtil;
import com.mxk.org.common.util.StringUtil;
import com.mxk.org.entity.CommentEntity;
import com.mxk.org.entity.GiftEntity;
import com.mxk.org.entity.MessageEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.entity.SubjectPriceEntity;
import com.mxk.org.entity.UserGiftEntity;
import com.mxk.org.entity.UserLikeEntity;
import com.mxk.org.entity.UserPointEntity;
import com.mxk.org.web.comments.domain.BaseRequest;
import com.mxk.org.web.comments.domain.CommentsAddRequest;
import com.mxk.org.web.comments.domain.GiftInfoResponse;
import com.mxk.org.web.comments.domain.LikeInfoResponse;
import com.mxk.org.web.comments.domain.LoadCommentsRequest;
import com.mxk.org.web.comments.domain.LoadCommentsRespone;
import com.mxk.org.web.comments.domain.PageModelRequest;
import com.mxk.org.web.comments.domain.PointInfoResponse;
import com.mxk.org.web.comments.domain.PriceResponse;
import com.mxk.org.web.comments.domain.SendGiftRequest;
import com.mxk.org.web.comments.domain.SetPointRequest;
import com.mxk.org.web.comments.domain.SetPriceRequest;
import com.mxk.org.web.comments.service.MxkCommentsService;
import com.mxk.org.web.comments.service.MxkMessageService;
import com.mxk.org.web.part.service.MxkPartService;
import com.mxk.org.web.subject.service.MxkSubjectService;
import com.mxk.org.web.user.domain.UserVO;
import com.mxk.org.web.user.service.MetooUserTitleService;
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
	
	@Autowired
	private MetooUserTitleService userTitleService;
	
	private CommentsAddRequest commentsAddRequest;
	private LoadCommentsRequest loadCommentsRequest;
	private LoadCommentsRespone loadCommentsRespone;
	private SendGiftRequest sendGiftRequest;
	private GiftInfoResponse giftInfoResponse;
	private LikeInfoResponse likeInfoResponse;
	private PageModelRequest pageModel;
	private BaseRequest baseRequest;
	private SetPriceRequest setPriceRequest;
	private SetPointRequest setPointRequest;
	private PointInfoResponse pointInfoResponse;
	private PriceResponse priceResponse;
	private UserVO uservo;
	private String message;
	private String traget;
	
	//定价
	public String metooSetPriceToSubjectAjax(){
		uservo = super.getCurrentUserVO();
		message = MxkConstant.USER_NO_LOGIN;
		if(uservo != null && setPriceRequest != null){
			SubjectEntity su = subjectService.findSubjectEntityById(setPriceRequest.getSubjectid());
			if(su == null){
				return SUCCESS;
			}
//			if(commentsService.checkHasBeenSetPrice(setPriceRequest.getSubjectid(), uservo.getId())){
				SubjectPriceEntity entity = new SubjectPriceEntity();
				entity.setCreateTime(StringUtil.dateToString(new Date(), null));
				if(setPriceRequest.getMoney() < 1){
					entity.setMoney(1);
				}else{
					entity.setMoney(setPriceRequest.getMoney());
				}
				entity.setSetPriceUserId(uservo.getId());
				entity.setSetPriceUserImage(uservo.getImage());
				entity.setSetPriceUserName(uservo.getName());
				entity.setSubjectid(setPriceRequest.getSubjectid());
				commentsService.saveSubjectPriceEntity(entity);
				
				//增加积分
				if(!MxkSubjectcCategory.SUBJECT_CATEGORY_SHARE.getString().equals(su.getCategory())){
					userTitleService.updatePoint(su.getUserid(), MetooPointTypeConstant.METOO_POINT_TYPE_SUBJECT, true, true);
				}
				userTitleService.updatePoint(uservo.getId(), MetooPointTypeConstant.METOO_POINT_TYPE_COMMENT, true, false);
				message = MxkConstant.AJAX_SUCCESS;
//			}else{
//				message = MetooResultMessage.ACTION_REPEAT.getString();
//			}
		}
		return SUCCESS;
	}
	
	//评价查询
	public String metooFindSetPriceToSubjectByPageAjax(){
		if(pageModel != null){
			priceResponse = new PriceResponse();
			if(pageModel.getAllPage() == 0){
				priceResponse.setAllpage(commentsService.findCountOfSubjectPriceEntity(pageModel.getTragetId()));
			}
			priceResponse.setList(commentsService.findSubjectPriceEntity(pageModel.getTragetId(), pageModel.getCurrentPage()));
		}
		return SUCCESS;	
	}
	
	//送礼
	public String metooSendGiftAjax(){
		uservo = super.getCurrentUserVO();
		message = MxkConstant.USER_NO_LOGIN;
		if(uservo != null && sendGiftRequest != null){
			//if(commentsService.checkGiftHasBeenSend(sendGiftRequest.getTargetId(), uservo.getId())){
				UserGiftEntity entity = new UserGiftEntity();
				UserVO targetUserVO = super.getCachedUserVO(sendGiftRequest.getSendGifttToUserId());
				if(targetUserVO != null){
					GiftEntity ge = commentsService.randomGift();
					entity.setSendGiftTime(StringUtil.dateToString(new Date(), null));
					entity.setSendGifttUserId(uservo.getId());
					entity.setSendGiftUserImage(uservo.getImage());
					entity.setSendGiftUserName(uservo.getName());
					entity.setGiftType(ge.getGifType());
					entity.setGifImage(ge.getGifImage());
					entity.setGifMessage(ge.getGifMessage());
					entity.setGiftName(ge.getGiftName());
					entity.setTragetId(sendGiftRequest.getTargetId());
					entity.setUserid(targetUserVO.getId());
					entity.setUsed(1);//为使用
					if(MxkConstant.SUBJECT.equals(sendGiftRequest.getType())){
						entity.setTragetType(MxkConstant.SUBJECT);
					}else{
						entity.setTragetType(MxkConstant.PART);
					}
					if(commentsService.sendGiftToUser(entity)){
						MessageEntity messageEntity = new MessageEntity();
						messageEntity.setMess("送了一个礼物");
						messageEntity.setTargetId(entity.getTragetId());
						messageEntity.setTargetUserId(entity.getUserid());
						messageEntity.setType(entity.getTragetType());
						messageEntity.setUserId(entity.getSendGifttUserId());
						messageEntity.setUserimage(entity.getSendGiftUserImage());
						messageEntity.setUsername(entity.getSendGiftUserName());
						messageService.createMessage(messageEntity);
						message = ge.getGiftName()+","+ ge.getGifMessage()+","+ge.getGifImage();
					}else{
						message = MetooGiftResultMessage.GIFT_SEND_ERROR.getString();
					}
				}
//			}else{
//				message = MetooGiftResultMessage.GIFT_SEND_REPEAT.getString();
//			}
		}
		return SUCCESS;
	}
	
	public String metooFindUserAllGiftAjax(){
		if(pageModel != null){
			giftInfoResponse = new GiftInfoResponse();
			if(pageModel.getAllPage() == 0){
				giftInfoResponse.setAllpage(commentsService.findCountOfUserAllGift(pageModel.getTragetId()));
			}
			giftInfoResponse.setList(commentsService.findUserGiftEntity(pageModel.getTragetId(), pageModel.getCurrentPage()));
		}
		return SUCCESS;	
	}
	
	//查看礼物
	public String metooFindSendGiftByPageAjax(){
		if(pageModel != null){
			giftInfoResponse = new GiftInfoResponse();
			if(pageModel.getAllPage() == 0){
				giftInfoResponse.setAllpage(commentsService.findCountOfUserGiftEntity(pageModel.getTragetId()));
			}
			giftInfoResponse.setList(commentsService.findUserGiftEntityByPage(pageModel.getTragetId(), pageModel.getCurrentPage()));
		}
		return SUCCESS;	
	}
	
	//喜欢
	public String metooLikeThisAjax(){
		uservo = super.getCurrentUserVO();
		message = MxkConstant.USER_NO_LOGIN;
		if (uservo != null && baseRequest != null){
			//if(commentsService.checkHaslBeenLiked(baseRequest.getTragetid(), uservo.getId())){
				UserLikeEntity entity = new UserLikeEntity();
				entity.setCreateTime(StringUtil.dateToString(new Date(), null));
				entity.setTargetId(baseRequest.getTragetid());
				entity.setUserid(uservo.getId());
				entity.setUserimage(uservo.getImage());
				entity.setUsername(uservo.getName());
				if(MxkConstant.SUBJECT.equals(baseRequest.getTrageType())){
					entity.setTargetType(MxkConstant.SUBJECT);
				}else{
					entity.setTargetType(MxkConstant.PART);
				}
				if(commentsService.saveUserliked(entity)){
					//增加积分
					if(MxkConstant.SUBJECT.equals(baseRequest.getTrageType())){
						SubjectEntity su = subjectService.findSubjectEntityById(baseRequest.getTragetid());
						if(!MxkSubjectcCategory.SUBJECT_CATEGORY_SHARE.getString().equals(su.getCategory())){ //分享不加分
							userTitleService.updatePoint(su.getUserid(), MetooPointTypeConstant.METOO_POINT_TYPE_SUBJECT, true, true);
						}
					}else{
						userTitleService.updatePoint(baseRequest.getTrageUserId(), MetooPointTypeConstant.METOO_POINT_TYPE_PART, true, true);
					}
					userTitleService.updatePoint(uservo.getId(), MetooPointTypeConstant.METOO_POINT_TYPE_COMMENT, true, false);
				}
				message = MxkConstant.AJAX_SUCCESS;
			//}
		}
		return SUCCESS;	
	}
	
	//查看like
	public String metooFindLikeThisByPageAjax(){
		if(pageModel != null){
			likeInfoResponse = new LikeInfoResponse();
			if(pageModel.getAllPage() == 0){
				likeInfoResponse.setAllpage(commentsService.findCountOfUserLikeEntity(pageModel.getTragetId()));
			}
			likeInfoResponse.setList(commentsService.findUserLikeEntityByPage(pageModel.getTragetId(), pageModel.getCurrentPage()));
		}
		return SUCCESS;	
	}
	
	public String metooSetPointAjax () {
		uservo = super.getCurrentUserVO();
		message = MxkConstant.USER_NO_LOGIN;
		if (uservo != null && setPointRequest != null){
			// if (commentsService.checkHasBeanSetPoint(setPointRequest.getTragetid(), uservo.getId())) {
				UserPointEntity entity = new UserPointEntity();
				entity.setCreateTime(StringUtil.dateToString(new Date(), null));
				entity.setPoint(setPointRequest.getPoint());
				entity.setTargetId(setPointRequest.getTragetid());
				entity.setTargetType(setPointRequest.getTrageType());
				entity.setUserid(uservo.getId());
				entity.setUserimage(uservo.getImage());
				entity.setUsername(uservo.getName());
				if(commentsService.saveUserSetPonit(entity)){
					//增加积分
					if(MxkConstant.SUBJECT.equals(setPointRequest.getTrageType())){
						SubjectEntity su = subjectService.findSubjectEntityById(setPointRequest.getTragetid());
						if(!MxkSubjectcCategory.SUBJECT_CATEGORY_SHARE.getString().equals(su.getCategory())){ //分享不加分
						   userTitleService.updatePoint(su.getUserid(), MetooPointTypeConstant.METOO_POINT_TYPE_SUBJECT, true, true);
						}
					}else{
						userTitleService.updatePoint(setPointRequest.getTrageUserId(), MetooPointTypeConstant.METOO_POINT_TYPE_PART, true, true);
					}
					userTitleService.updatePoint(uservo.getId(), MetooPointTypeConstant.METOO_POINT_TYPE_COMMENT, true, false);
				}
				message = MxkConstant.AJAX_SUCCESS;
			// }
		}
		return SUCCESS;
	}
	
	public String metooFindSetPointByPageAjax(){
		if(pageModel != null){
			pointInfoResponse = new PointInfoResponse();
			if(pageModel.getAllPage() == 0){
				pointInfoResponse.setAllpage(commentsService.findCountOfUserSetPoint(pageModel.getTragetId()));
			}
			pointInfoResponse.setList(commentsService.findUserPointEntity(pageModel.getTragetId(), pageModel.getCurrentPage()));
		}
		return SUCCESS;	
	}
	
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
					if(!uservo.getId().equals(commentsAddRequest.getCommentedUserId())){ //自己给自己评论不加分
					   userTitleService.updatePoint(commentsAddRequest.getCommentedUserId(), MetooPointTypeConstant.METOO_POINT_TYPE_PART, true, true);
					}
					partService.updatePartCommentsQuantity(commentsAddRequest.getCommentedId(), "text", true);//����part��������comments audios
					messageService.createMessage(commentsAddRequest);//������Ϣ��ʾ
					partService.changePartsBackShadow(commentsAddRequest.getCommentedId());
					message = MxkConstant.AJAX_SUCCESS;
				}else if(MxkConstant.SUBJECT.equals(commentsAddRequest.getTarget())){
					if(!uservo.getId().equals(commentsAddRequest.getCommentedUserId())){ //自己给自己评论不加分
						SubjectEntity su = subjectService.findSubjectEntityById(commentsAddRequest.getCommentedId());
						if(!MxkSubjectcCategory.SUBJECT_CATEGORY_SHARE.getString().equals(su.getCategory())){ //分享不加分
					       userTitleService.updatePoint(commentsAddRequest.getCommentedUserId(), MetooPointTypeConstant.METOO_POINT_TYPE_SUBJECT, true, true);
						}
					}
					subjectService.updateSubjectCommentsQuantity(commentsAddRequest.getCommentedId(), true);
					messageService.createMessage(commentsAddRequest);//������Ϣ��ʾ
					message = MxkConstant.AJAX_SUCCESS;
				}
				if(!uservo.getId().equals(commentsAddRequest.getCommentedUserId())){ //自己给自己评论不加分
			       userTitleService.updatePoint(uservo.getId(), MetooPointTypeConstant.METOO_POINT_TYPE_COMMENT, true, false);
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
					if(!uservo.getId().equals(commentsAddRequest.getCommentedUserId())){
						userTitleService.updatePoint(commentsAddRequest.getCommentedUserId(), MetooPointTypeConstant.METOO_POINT_TYPE_PART, true, true);
					}
					partService.updatePartCommentsQuantity(
							commentsAddRequest.getCommentedId(), "wav", true);//����part��������comments audios
					messageService.createMessage(commentsAddRequest);//������Ϣ��ʾ
					partService.changePartsBackShadow(commentsAddRequest.getCommentedId());
					message = MxkConstant.AJAX_SUCCESS;
				}else if(MxkConstant.SUBJECT.equals(commentsAddRequest.getTarget())){
					SubjectEntity su = subjectService.findSubjectEntityById(commentsAddRequest.getCommentedId());
					if(!MxkSubjectcCategory.SUBJECT_CATEGORY_SHARE.getString().equals(su.getCategory())){ //分享不加分
				       userTitleService.updatePoint(commentsAddRequest.getCommentedUserId(), MetooPointTypeConstant.METOO_POINT_TYPE_SUBJECT, true, true);
					}
					subjectService.updateSubjectCommentsQuantity(commentsAddRequest.getCommentedId(), true);
					messageService.createMessage(commentsAddRequest);//������Ϣ��ʾ
					message = MxkConstant.AJAX_SUCCESS;
				}
				if(!uservo.getId().equals(commentsAddRequest.getCommentedUserId())){ //自己给自己评论不加分
				 userTitleService.updatePoint(uservo.getId(), MetooPointTypeConstant.METOO_POINT_TYPE_COMMENT, true, false);
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
				if(!uservo.getId().equals(en.getCommentedUserId())){
					//删除积分
					deleteTilePoint(uservo.getId(),en);
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
    
	private void deleteTilePoint(String userid,CommentEntity en){
		if(userid.equals(en.getUserid())){ //我评论的 我可以删
			userTitleService.updatePoint(userid, MetooPointTypeConstant.METOO_POINT_TYPE_COMMENT, false, false);
			if(MxkConstant.SUBJECT.equals(en.getTarget())){
				userTitleService.updatePoint(en.getCommentedUserId(), MetooPointTypeConstant.METOO_POINT_TYPE_SUBJECT, false, true);
			}else if(MxkConstant.PART.equals(en.getTarget())){
				userTitleService.updatePoint(en.getCommentedUserId(), MetooPointTypeConstant.METOO_POINT_TYPE_PART, false, true);
			}
		}
		if(userid.equals(en.getCommentedUserId())){ //评论我的我可以删
			if(MxkConstant.SUBJECT.equals(en.getTarget())){
				userTitleService.updatePoint(userid, MetooPointTypeConstant.METOO_POINT_TYPE_SUBJECT, false, true);
			}else if(MxkConstant.PART.equals(en.getTarget())){
				userTitleService.updatePoint(userid, MetooPointTypeConstant.METOO_POINT_TYPE_PART, false, true);
			}
		}
		
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

	public SendGiftRequest getSendGiftRequest() {
		return sendGiftRequest;
	}

	public void setSendGiftRequest(SendGiftRequest sendGiftRequest) {
		this.sendGiftRequest = sendGiftRequest;
	}

	public GiftInfoResponse getGiftInfoResponse() {
		return giftInfoResponse;
	}

	public void setGiftInfoResponse(GiftInfoResponse giftInfoResponse) {
		this.giftInfoResponse = giftInfoResponse;
	}

	public PageModelRequest getPageModel() {
		return pageModel;
	}

	public void setPageModel(PageModelRequest pageModel) {
		this.pageModel = pageModel;
	}

	public BaseRequest getBaseRequest() {
		return baseRequest;
	}

	public void setBaseRequest(BaseRequest baseRequest) {
		this.baseRequest = baseRequest;
	}

	public LikeInfoResponse getLikeInfoResponse() {
		return likeInfoResponse;
	}

	public void setLikeInfoResponse(LikeInfoResponse likeInfoResponse) {
		this.likeInfoResponse = likeInfoResponse;
	}

	public SetPointRequest getSetPointRequest() {
		return setPointRequest;
	}

	public void setSetPointRequest(SetPointRequest setPointRequest) {
		this.setPointRequest = setPointRequest;
	}

	public SetPriceRequest getSetPriceRequest() {
		return setPriceRequest;
	}

	public void setSetPriceRequest(SetPriceRequest setPriceRequest) {
		this.setPriceRequest = setPriceRequest;
	}

	public PointInfoResponse getPointInfoResponse() {
		return pointInfoResponse;
	}

	public void setPointInfoResponse(PointInfoResponse pointInfoResponse) {
		this.pointInfoResponse = pointInfoResponse;
	}

	public PriceResponse getPriceResponse() {
		return priceResponse;
	}

	public void setPriceResponse(PriceResponse priceResponse) {
		this.priceResponse = priceResponse;
	} 
	
}
