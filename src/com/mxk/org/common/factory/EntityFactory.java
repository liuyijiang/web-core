package com.mxk.org.common.factory;

import java.util.Date;

import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.util.SecurityUtil;
import com.mxk.org.common.util.StringUtil;
import com.mxk.org.entity.CommentEntity;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.entity.SubjectWorkingEntity;
import com.mxk.org.entity.UserEntity;
import com.mxk.org.entity.UserRssSubjectEntity;
import com.mxk.org.web.comments.domain.CommentsAddRequest;
import com.mxk.org.web.part.domain.CreatePartRequest;
import com.mxk.org.web.subject.domain.CreateSubjectRequest;
import com.mxk.org.web.subject.domain.CreateSubjectWorkingRequest;
import com.mxk.org.web.subject.domain.RssSubjectRequest;
import com.mxk.org.web.user.domain.UserRegisterRequest;

/**
 * Entity ��װ����
 * @author liuyijiang
 *
 */
public class EntityFactory {
  
	private static final String EMPTY = "";
	
	public static SubjectWorkingEntity createSubjectWorkingEntity(CreateSubjectWorkingRequest request){
		SubjectWorkingEntity swe = new SubjectWorkingEntity();
		swe.setCreateTime(request.getCreateTime());
		swe.setPlan(request.getPlan());
		swe.setSubjectid(request.getSubjectid());
		swe.setUserid(request.getUserid());
		swe.setDoc(request.getDoc());
		return swe;
	}
	
	public static UserRssSubjectEntity createUserRssSubjectEntity(RssSubjectRequest rssSubjectRequest){
		UserRssSubjectEntity userRssSubjectEntity = new UserRssSubjectEntity();
		userRssSubjectEntity.setCeateTime(StringUtil.dateToString(new Date(), null));
		userRssSubjectEntity.setSubjectid(rssSubjectRequest.getSubjectid());
		userRssSubjectEntity.setSubjectOwnerId(rssSubjectRequest.getSubjectOwnerId());
		userRssSubjectEntity.setUserdesc(rssSubjectRequest.getUserdesc());
		userRssSubjectEntity.setUserid(rssSubjectRequest.getUserid());
		userRssSubjectEntity.setUserimage(rssSubjectRequest.getUserimage());
		userRssSubjectEntity.setUsername(rssSubjectRequest.getUsername());
		return userRssSubjectEntity;
	}
	
	public static CommentEntity createCommentEntity(CommentsAddRequest commentsAddRequest){
		CommentEntity commentEntity = new CommentEntity();
		commentEntity.setCommentedId(commentsAddRequest.getCommentedId());
		commentEntity.setCommentedUserId(commentsAddRequest.getCommentedUserId());
		commentEntity.setCreateTime(StringUtil.dateToString(new Date(), null));
		commentEntity.setInfo(commentsAddRequest.getInfo());
		commentEntity.setTarget(commentsAddRequest.getTarget());
		commentEntity.setUserid(commentsAddRequest.getUserid());
		commentEntity.setType(commentsAddRequest.getType());
		commentEntity.setUserimage(commentsAddRequest.getUserimage());
		commentEntity.setUsername(commentsAddRequest.getUsername());
		commentEntity.setReply(commentsAddRequest.getReply());
		commentEntity.setReplyUserId(commentsAddRequest.getReplyUserId());
		commentEntity.setReplyUserImage(commentsAddRequest.getReplyUserImage());
		commentEntity.setReplyUserName(commentsAddRequest.getReplyUserName());
		return commentEntity;
	}
	
	
	public static PartEntity createPartEntity(CreatePartRequest request){
		PartEntity partEntity = new PartEntity();
		partEntity.setAudios(0);
		partEntity.setCollect(0);
		partEntity.setComments(0);
		partEntity.setCreateTime(StringUtil.dateToString(new Date(), null));
		partEntity.setDesc(request.getDesc());
		partEntity.setImage(EMPTY);
		partEntity.setMinimage(EMPTY);
		partEntity.setSubjectid(request.getSubjectid());
		partEntity.setSubname(request.getSubname());
		partEntity.setType(request.getType());
		partEntity.setUserid(request.getUserid());
		partEntity.setUserimage(request.getUserimage());
		partEntity.setUsername(request.getUsername());
		partEntity.setStatus(request.getStatus());
		partEntity.setShadow(MxkConstant.MXK_PAET_SHADOW);
		return partEntity;
	}
	
	
	
	public static SubjectEntity createSubjectEntity(CreateSubjectRequest request) {
		SubjectEntity subjectEntity = new SubjectEntity();
		subjectEntity.setCreateTime(StringUtil.dateToString(new Date(), null));
		subjectEntity.setUserid(request.getUserid());
		subjectEntity.setInfo(request.getInfo());
		subjectEntity.setType(request.getType());
		subjectEntity.setName(request.getName());
		subjectEntity.setFaceimage(request.getFaceiamge());
		subjectEntity.setAttention(0);
		subjectEntity.setComments(0);
		subjectEntity.setLevel(1);
		subjectEntity.setParts(0);
		subjectEntity.setTags(request.getTags());
		subjectEntity.setCategory(request.getCategory());
		subjectEntity.setUserimage(request.getUserimage());
		subjectEntity.setUsername(request.getUsername());
		return subjectEntity;
	}
	
	public static UserEntity createUserEntity(UserRegisterRequest userRegisterRequest) {
		UserEntity userEntity = new UserEntity();
		userEntity.setCreateTime(StringUtil.dateToString(new Date(), null));
		userEntity.setEmail(userRegisterRequest.getEmail());
		userEntity.setFocus(0);
		userEntity.setFollowors(0);
		userEntity.setImage(userRegisterRequest.getImageurl());
		userEntity.setInfo(userRegisterRequest.getInfo());
		userEntity.setInterest(userRegisterRequest.getInterest());
		userEntity.setSex(userRegisterRequest.getSex());
		userEntity.setLevel(1);
		userEntity.setMinimage(userRegisterRequest.getMinimageurl());
		userEntity.setName(userRegisterRequest.getUsername());
		userEntity.setPassword(SecurityUtil.digestByMd5(userRegisterRequest.getPassword()));
		userEntity.setSubject(0);
		return userEntity;
	}
	
}
