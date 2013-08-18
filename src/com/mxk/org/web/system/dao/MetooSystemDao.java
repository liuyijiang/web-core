package com.mxk.org.web.system.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Order;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import com.mxk.org.common.domain.constant.MetooPointTypeConstant;
import com.mxk.org.common.domain.constant.MetooTitleConstant;
import com.mxk.org.common.domain.constant.MxkSubjectcCategory;
import com.mxk.org.entity.CommentEntity;
import com.mxk.org.entity.GiftEntity;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.entity.TitleEntity;
import com.mxk.org.entity.UserEntity;
import com.mxk.org.entity.UserTitleEntity;

@Component
public class MetooSystemDao {
  
	@Autowired
	private MongoOperations mog; 
	
	public void createTitle(TitleEntity title){
		mog.save(title);
	}
	
	public void createGift(GiftEntity entity){
		mog.save(entity);
	}
	
	//创建头衔
	public void systemCreateUserTitle(){
		Query q = new Query();
		List<UserEntity> list = mog.find(q, UserEntity.class);
		for (UserEntity en : list){
			Query qt = new Query(Criteria.where("userid").is(en.getId()));
			UserTitleEntity tit = mog.findOne(qt, UserTitleEntity.class);
			if(tit == null){
				int share = findSharePoint(en.getId());
				int commot = findCommentsPoint(en.getId());
				int sub = findSubjectPoint(en.getId());
				UserTitleEntity title = new UserTitleEntity();
				title.setCommentPoint(commot);
				title.setCommentTileCode(MetooTitleConstant.METOO_TITLE_RUMEN.toString());
			    title.setCommentTitle(MetooTitleConstant.METOO_TITLE_RUMEN.getString());
			    title.setLevel(1);
			    title.setLevelPoint(share+sub+commot+10);//注册加10分
			    title.setSharePoint(share);
			    title.setShareTileCode(MetooTitleConstant.METOO_TITLE_RUMEN.toString());
			    title.setShareTitle(MetooTitleConstant.METOO_TITLE_RUMEN.getString());
			    title.setSubjectPoint(sub);
			    title.setSubjectTileCode(MetooTitleConstant.METOO_TITLE_RUMEN.toString());
			    title.setSubjectTitle(MetooTitleConstant.METOO_TITLE_RUMEN.getString());
			    title.setUserid(en.getId());
			    title.setShareTileImage(MetooTitleConstant.METOO_TITLE_RUMEN_IMAGE.getString());
			    title.setSubjectTileImage(MetooTitleConstant.METOO_TITLE_RUMEN_IMAGE.getString());
			    title.setCommentTileImage(MetooTitleConstant.METOO_TITLE_RUMEN_IMAGE.getString());
			    mog.save(title);
			}
		}
	}

	//更新头衔
	public void systemUpdateUserTitle(){
		Query q = new Query();
		List<UserEntity> list = mog.find(q, UserEntity.class);
		for (UserEntity en : list) {
			upgradeUserShareTile(en.getId(),MetooPointTypeConstant.METOO_POINT_TYPE_COMMENT);
			upgradeUserShareTile(en.getId(),MetooPointTypeConstant.METOO_POINT_TYPE_PART);
			upgradeUserShareTile(en.getId(),MetooPointTypeConstant.METOO_POINT_TYPE_SUBJECT);
		}
	}
	
	
	
	private boolean upgradeUserShareTile(String userid,MetooPointTypeConstant type){
		boolean success = true;
		try{
			Query q = new Query(Criteria.where("userid").is(userid));
			UserTitleEntity tit = mog.findOne(q, UserTitleEntity.class);
			Query qt = new Query();
			qt.sort().on("point", Order.ASCENDING);//从小到大
			List<TitleEntity> list = mog.find(qt, TitleEntity.class);
			TitleEntity matchTitle = null;
			for (TitleEntity t : list) {
				if (t.getPoint() > tit.getSharePoint() ) { //
				     break;	
				}else{
					matchTitle = t;
				}
			}
			if(matchTitle != null){
				Update u = new Update();
				switch (type) {
				   case METOO_POINT_TYPE_PART:
					   if(matchTitle.getCode().equals(tit.getShareTileCode())){
							success = false;
					   }else{
						   u.set("shareTitle", matchTitle.getName());
						   u.set("shareTileCode", matchTitle.getCode());
						   u.set("shareTileImage", matchTitle.getImage()); 
					   }
					   break;
				   case METOO_POINT_TYPE_COMMENT:
					   if(matchTitle.getCode().equals(tit.getCommentTileCode())){
							success = false;
					   }else{
						   u.set("commentTitle", matchTitle.getName());
						   u.set("commentTileCode", matchTitle.getCode());
						   u.set("commentTileImage", matchTitle.getImage());
					   }
					   break;
				   case METOO_POINT_TYPE_SUBJECT:
					   if(matchTitle.getCode().equals(tit.getSubjectTileCode())){
							success = false;
					   }else{
						   u.set("subjectTitle", matchTitle.getName());
						   u.set("subjectTileCode", matchTitle.getCode());
						   u.set("subjectTileImage", matchTitle.getImage());
					   }
					   break;
				}
				mog.updateMulti(q, u, UserTitleEntity.class);
			}
		} catch (Exception e) {
			success = false;
		}
		return success;
	}
	
	
	
	private int findSharePoint(String userid){
		Query q = new Query(Criteria.where("userid").is(userid));
		Long  num = mog.count(q, PartEntity.class);
		return (num.intValue()*2);
	}
	
	private int findCommentsPoint(String userid){
		Query q = new Query(Criteria.where("userid").is(userid));
		Long  num = mog.count(q, CommentEntity.class);
		return (num.intValue()*2);
	}
	
	private int findSubjectPoint(String userid){
		Query q = new Query(Criteria.where("userid").is(userid).and("category").is(MxkSubjectcCategory.SUBJECT_CATEGORY_CREATIVE));
		Long  num = mog.count(q, SubjectEntity.class);
		return (num.intValue()*10);
	}
	
	
	public void updateUserParts(){
		Query q = new Query();
		List<UserEntity> list = mog.find(q, UserEntity.class);
		for (UserEntity en : list) {
			int parts = userparts(en.getId());
			Query qu = new Query(Criteria.where("id").is(en.getId()));
			Update up = new Update();
			up.set("parts", parts);
			mog.updateMulti(qu, up, UserEntity.class);
		}
	}
	
	private int userparts(String userid){
		Query q = new Query(Criteria.where("userid").is(userid));
		Long  num = mog.count(q, PartEntity.class);
		return num.intValue();
	}
}
