package com.mxk.org.common.factory;

import com.mxk.org.entity.UserEntity;
import com.mxk.org.web.user.domain.UserVO;

/**
 * value object Factory 
 * @author liuyijiang
 *
 */
public class VOFactory {
   
	public static UserVO createUserVOFormEnitiy(UserEntity userEntity){
		UserVO vo = new UserVO();
		vo.setId(userEntity.getId());
		vo.setCreateTime(userEntity.getCreateTime());
		vo.setEmail(userEntity.getEmail());
		vo.setFocus(userEntity.getFocus());
		vo.setFollowors(userEntity.getFollowors());
		vo.setImage(userEntity.getImage());
		vo.setInfo(userEntity.getInfo());
		vo.setInterest(userEntity.getInterest());
		vo.setSex(userEntity.getSex());
		vo.setLevel(userEntity.getLevel());
		vo.setMinimage(userEntity.getMinimage());
		vo.setName(userEntity.getName());
		vo.setSubject(userEntity.getSubject());
		vo.setParts(userEntity.getParts());
		return vo;
	}
	
}
