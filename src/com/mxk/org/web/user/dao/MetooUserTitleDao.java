package com.mxk.org.web.user.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Order;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import com.mxk.org.common.domain.constant.MetooPointTypeConstant;
import com.mxk.org.common.domain.constant.MetooTitleConstant;
import com.mxk.org.entity.TitleEntity;
import com.mxk.org.entity.UserTitleEntity;

@Component
public class MetooUserTitleDao {
   
	@Value("${metoo.title.share.point}")
	private int sharePoint;
	
	@Value("${metoo.title.comment.point}")
	private int commentPoint;
	
	@Value("${metoo.title.subject.point}")
	private int subjectPoint;
	
	@Value("${metoo.title.base.point}")
	private int basePoint;
	
	private static final Log log = LogFactory.getLog(MetooUserTitleDao.class);
	
	@Autowired
	private MongoOperations mog; 
	
	public UserTitleEntity findUserTitleEntity(String userid){
		Query q = new Query(Criteria.where("userid").is(userid));
		UserTitleEntity tit = mog.findOne(q, UserTitleEntity.class);
		return tit;
	}
	
	public boolean upgradeUserShareTile(String userid,MetooPointTypeConstant type){
		boolean success = false;
		try{
			Query q = new Query(Criteria.where("userid").is(userid));
			UserTitleEntity tit = mog.findOne(q, UserTitleEntity.class);
			Query qt = new Query();
			qt.sort().on("point", Order.ASCENDING);//从小到大
			List<TitleEntity> list = mog.find(qt, TitleEntity.class);
			TitleEntity matchTitle = null;
			for (TitleEntity t : list) {
				if(MetooPointTypeConstant.METOO_POINT_TYPE_PART.equals(type)){
					if (t.getPoint() > tit.getSharePoint() ) { //
					     break;	
					}else{
						matchTitle = t;
					}
				} else if(MetooPointTypeConstant.METOO_POINT_TYPE_COMMENT.equals(type)) {
					if (t.getPoint() > tit.getCommentPoint() ) { //
					     break;	
					}else{
						matchTitle = t;
					}
				} else if(MetooPointTypeConstant.METOO_POINT_TYPE_SUBJECT.equals(type)){
					if (t.getPoint() > tit.getSubjectPoint()) { //
					     break;	
					}else{
						matchTitle = t;
					}
				}
			}
			if(matchTitle != null){
				Update u = new Update();
				switch (type) {
				   case METOO_POINT_TYPE_PART:
					   if(matchTitle.getCode().equals(tit.getShareTileCode())){
							success = false;
					   }else{
						   u.set("shareTitle", matchTitle.getName()+MetooTitleConstant.METOO_TITLE_SHARE_SUFFIX_NAME.getString());
						   u.set("shareTileCode", matchTitle.getCode());
						   u.set("shareTileImage", matchTitle.getImage()); 
						   mog.updateMulti(q, u, UserTitleEntity.class);
						   success = true;
					   }
					   break;
				   case METOO_POINT_TYPE_COMMENT:
					   if(matchTitle.getCode().equals(tit.getCommentTileCode())){
							success = false;
					   }else{
						   u.set("commentTitle", matchTitle.getName()+MetooTitleConstant.METOO_TITLE_COMMENT_SUFFIX_NAME.getString());
						   u.set("commentTileCode", matchTitle.getCode());
						   u.set("commentTileImage", matchTitle.getImage());
						   mog.updateMulti(q, u, UserTitleEntity.class);
						   success = true;
					   }
					   break;
				   case METOO_POINT_TYPE_SUBJECT:
					   if(matchTitle.getCode().equals(tit.getSubjectTileCode())){
							success = false;
					   }else{
						   u.set("subjectTitle", matchTitle.getName()+MetooTitleConstant.METOO_TITLE_SUBJECT_SUFFIX_NAME.getString());
						   u.set("subjectTileCode", matchTitle.getCode());
						   u.set("subjectTileImage", matchTitle.getImage());
						   mog.updateMulti(q, u, UserTitleEntity.class);
						   success = true;
					   }
					   break;
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
	
	
	
	
	
	
	
	
	
	
	public void updatePoint(String userid,MetooPointTypeConstant type,boolean isadd,boolean isbase){
		switch (type) {
		   case METOO_POINT_TYPE_PART:
			   updateSharePoint(userid,isadd,isbase);
			   break;
		   case METOO_POINT_TYPE_COMMENT:
			   updateCommetPoint(userid,isadd,isbase);
			   break;
		   case METOO_POINT_TYPE_SUBJECT:
			   updateSubjectPoint(userid,isadd,isbase);
			   break;
		}
	}
	
	private void updateSharePoint(String userid,boolean isadd,boolean isbase){
		Query q = new Query(Criteria.where("userid").is(userid));
		Update u = new Update();
		int point = basePoint;
		if(!isbase){//不是基础
			point = sharePoint;
		}
		if(isadd){
			u.inc("sharePoint", point);	
		}else{
			u.inc("sharePoint", (0 - point));	
		}
		mog.updateMulti(q, u, UserTitleEntity.class);
	}
	
	private void updateCommetPoint(String userid,boolean isadd,boolean isbase){
		Query q = new Query(Criteria.where("userid").is(userid));
		Update u = new Update();
		int point = basePoint;
		if(!isbase){//不是基础
			point = commentPoint;
		}
		if(isadd){
			u.inc("commentPoint", point);	
		}else{
			u.inc("commentPoint", (0 - point));	
		}
		mog.updateMulti(q, u, UserTitleEntity.class);
	}
	
	private void updateSubjectPoint(String userid,boolean isadd,boolean isbase){
		Query q = new Query(Criteria.where("userid").is(userid));
		Update u = new Update();
		int point = basePoint;
		if(!isbase){//不是基础
			point = subjectPoint;
		}
		if(isadd){
			u.inc("subjectPoint", point);	
		}else{
			u.inc("subjectPoint", (0 - point));	
		}
		mog.updateMulti(q, u, UserTitleEntity.class);
	}
	
	
	public boolean saveUserTitle(UserTitleEntity entity){
		boolean success = true;
		try {
			mog.save(entity);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			success = false;
		}
		return success;
	}
	
}
