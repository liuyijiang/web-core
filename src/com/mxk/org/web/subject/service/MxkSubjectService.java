package com.mxk.org.web.subject.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.common.factory.EntityFactory;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.entity.UserRssSubjectEntity;
import com.mxk.org.web.subject.dao.MxkSubjectDao;
import com.mxk.org.web.subject.domain.CreateSubjectRequest;
import com.mxk.org.web.subject.domain.RssSubjectRequest;
import com.mxk.org.web.subject.domain.SearchSubjectRequest;
import com.mxk.org.web.subject.domain.SetFaceImageRequest;
import com.mxk.org.web.subject.domain.SubjectsShowResponse;
import com.mxk.org.web.subject.domain.UpdateSubjectStatusRequest;
import com.mxk.org.web.user.domain.UserVO;
/**
 * 
 * @author liuyijiang
 *
 */
@Service
public class MxkSubjectService {
   
	@Autowired
	private MxkSubjectDao dao;
	
	public boolean addSubjectJoinPeople(UserVO vo,String subjectid){
	  	return dao.addSubjectJoinPeople(vo, subjectid);
	}
	
	public List<SubjectEntity> findSubjectEntityByName(String name,int page){
		return dao.findSubjectEntityByName(name, page);
	}
	
	public List<SubjectEntity> findSubjectEntityForALl(String tags,String type,int page){
		return dao.findSubjectEntityForALl(tags,type,page);
	}
	
	//总页数 当页面请求操作中页数后就不发请求了 
	public int findSubjectEntityForALlPages(String tags,String type){
		return dao.findSubjectEntityForALlPages(tags,type);
	}
	
	//总页数 当页面请求操作中页数后就不发请求了
	public int findSubjectEntityByNamePages(String name){
		return dao.findSubjectEntityByNamePages(name);
	}
	
	public boolean createUserRssSubject(RssSubjectRequest rssSubjectRequest){
		UserRssSubjectEntity userRssSubjectEntity = EntityFactory.createUserRssSubjectEntity(rssSubjectRequest);
		return dao.createUserRssSubject(userRssSubjectEntity);
	}
	
	public boolean removeUserRssSubejct(String userid,String subjectid){
		return dao.removeUserRssSubejct(userid, subjectid);
	}
	
	public List<UserRssSubjectEntity> findSubjectRssByPage(String subjectid,int page){
		return dao.findSubjectRssByPage(subjectid, page);
	}
	
	public boolean updateSubjectExtraUrl(String extraid,String type,String url){
		return dao.updateSubjectExtraUrl(extraid, type, url);
	}
	
	public boolean updateSubjectCommentsQuantity(String id ,boolean desc) {
		return dao.updateSubjectCommentsQuantity(id, desc);
	}
	
	public boolean updateSubjectForCreatePart(String subjectid,String imageurl){
		return dao.updateSubjectForCreatePart(subjectid, imageurl);
	}
	
	public boolean updateSubjectStatus(UpdateSubjectStatusRequest updateSubjectStatusRequest){
		return dao.updateSubjectStatus(updateSubjectStatusRequest);
	}
	
	public boolean setSubjectFaceImage(SetFaceImageRequest setFaceImageRequest){
		return dao.setSubjectFaceImage(setFaceImageRequest);
	}
	
	public boolean saveSubject(CreateSubjectRequest request){
		SubjectEntity subjectEntity = EntityFactory.createSubjectEntity(request);
		return dao.saveSubject(subjectEntity);
	}
	
	public List<SubjectEntity> findSubjectEntityByPage(SearchSubjectRequest request){
		return dao.findSubjectEntityByPage(request);
	}
	
	public SubjectEntity findSubjectEntityById(String id){
		return dao.findSubjectEntityById(id);
	}
	
	public SubjectsShowResponse createSubjectsShowResponseByList(List<SubjectEntity> list){
		SubjectsShowResponse subjectsShowResponse = null;
		if(list != null && !list.isEmpty()){
			subjectsShowResponse = new SubjectsShowResponse();
			int index = 0;
			List<SubjectEntity> list1 = new ArrayList<SubjectEntity>();
			List<SubjectEntity> list2 = new ArrayList<SubjectEntity>();
			List<SubjectEntity> list3 = new ArrayList<SubjectEntity>();
			List<SubjectEntity> list4 = new ArrayList<SubjectEntity>();
			subjectsShowResponse.setList1(list1);
			subjectsShowResponse.setList2(list2);
			subjectsShowResponse.setList3(list3);
			subjectsShowResponse.setList4(list4);
			for (SubjectEntity sub : list) {
				if(index == 0){
					list1.add(sub);
					index ++ ;
				}
				else if(index == 1){
					list2.add(sub);
					index ++ ;
				}
				else if(index == 2){
					list3.add(sub);
					index ++ ;
				}
				else if(index == 3){
					list4.add(sub);
					index = 0;
				}
			}
		}
		return subjectsShowResponse;
	}
	
	
	
	public SubjectsShowResponse findSubjectEntityBySearchRequest(SearchSubjectRequest request){
		List<SubjectEntity> list = dao.findSubjectEntityByPage(request);
		SubjectsShowResponse subjectsShowResponse = null;
		if(list != null && !list.isEmpty()){
			subjectsShowResponse = new SubjectsShowResponse();
			int index = 0;
			List<SubjectEntity> list1 = new ArrayList<SubjectEntity>();
			List<SubjectEntity> list2 = new ArrayList<SubjectEntity>();
			List<SubjectEntity> list3 = new ArrayList<SubjectEntity>();
			List<SubjectEntity> list4 = new ArrayList<SubjectEntity>();
			subjectsShowResponse.setList1(list1);
			subjectsShowResponse.setList2(list2);
			subjectsShowResponse.setList3(list3);
			subjectsShowResponse.setList4(list4);
			for (SubjectEntity sub : list) {
				if(index == 0){
					list1.add(sub);
					index ++ ;
				}
				else if(index == 1){
					list2.add(sub);
					index ++ ;
				}
				else if(index == 2){
					list3.add(sub);
					index ++ ;
				}
				else if(index == 3){
					list4.add(sub);
					index = 0;
				}
			}
		}
		return subjectsShowResponse;
	}
}
