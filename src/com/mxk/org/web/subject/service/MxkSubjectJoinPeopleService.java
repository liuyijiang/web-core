package com.mxk.org.web.subject.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.SubjectJoinPeopleEntity;
import com.mxk.org.web.subject.dao.MxkSubjectJoinPeopleDao;
import com.mxk.org.web.user.domain.SearchUserJoinSubjectRequest;
import com.mxk.org.web.visitor.domain.SubjectJoinPeopleRespone;

@Service
public class MxkSubjectJoinPeopleService {
    
	@Autowired
	private MxkSubjectJoinPeopleDao dao;
	
	public List<SubjectJoinPeopleEntity> findTop5SubjectJoiner(String subjectid){
		return dao.findTop5SubjectJoiner(subjectid);
	}
	
	public long findSubjectJoinerAllPage(String subjectid){
		return dao.findSubjectJoinerAllPage(subjectid);
	}
	
    public SubjectJoinPeopleRespone findSubjectJoinerByPage(String subjectid,int page){
    	SubjectJoinPeopleRespone subjectJoinPeopleRespone = null;
    	List<SubjectJoinPeopleEntity> list = dao.findSubjectJoinerByPage(subjectid,page);
    	if (list != null && !list.isEmpty()) {
    		subjectJoinPeopleRespone = new SubjectJoinPeopleRespone();
    		int index = 0;
			List<SubjectJoinPeopleEntity> list1 = new ArrayList<SubjectJoinPeopleEntity>();
			List<SubjectJoinPeopleEntity> list2 = new ArrayList<SubjectJoinPeopleEntity>();
			List<SubjectJoinPeopleEntity> list3 = new ArrayList<SubjectJoinPeopleEntity>();
			List<SubjectJoinPeopleEntity> list4 = new ArrayList<SubjectJoinPeopleEntity>();
			subjectJoinPeopleRespone.setList1(list1);
			subjectJoinPeopleRespone.setList2(list2);
			subjectJoinPeopleRespone.setList3(list3);
			subjectJoinPeopleRespone.setList4(list4);
			for (SubjectJoinPeopleEntity join : list) {
				if(index == 0){
					list1.add(join);
					index ++ ;
				}
				else if(index == 1){
					list2.add(join);
					index ++ ;
				}
				else if(index == 2){
					list3.add(join);
					index ++ ;
				}
				else if(index == 3){
					list4.add(join);
					index = 0;
				}
			}
    	}
    	return subjectJoinPeopleRespone;
	}
	
	public long findUserJoinSubject(String userid){
		return dao.findUserJoinSubject(userid);
	}
	
	public long findUserJoinSubjectAllPage(String userid){
		return dao.findUserJoinSubjectAllPage(userid);
	}
	
	
	public List<String> findUserJoinSubjectIds(SearchUserJoinSubjectRequest searchUserJoinSubjectRequest){
		return dao.findUserJoinSubjectIds(searchUserJoinSubjectRequest.getUserid(), searchUserJoinSubjectRequest.getPage());
	}
}
