package com.mxk.org.web.subject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.entity.SubjectJoinPeopleEntity;
import com.mxk.org.web.subject.dao.MxkSubjectJoinPeopleDao;

@Service
public class MxkSubjectJoinPeopleService {
    
	@Autowired
	private MxkSubjectJoinPeopleDao dao;
	
	public List<SubjectJoinPeopleEntity> findTop5SubjectJoiner(String subjectid){
		return dao.findTop5SubjectJoiner(subjectid);
	}
	
}
