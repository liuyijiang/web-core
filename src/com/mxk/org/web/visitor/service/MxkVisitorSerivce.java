package com.mxk.org.web.visitor.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.web.part.dao.MxkPartDao;
import com.mxk.org.web.part.domain.PartShowResponse;
import com.mxk.org.web.part.domain.SearchPartRequest;
import com.mxk.org.web.subject.domain.SearchSubjectRequest;
import com.mxk.org.web.subject.domain.SubjectsShowResponse;

@Service
public class MxkVisitorSerivce {

	@Autowired
	private MxkPartDao partDao;
	
	public PartShowResponse findParts(SearchPartRequest request){
		List<PartEntity> list = partDao.findPartEntityByPage(request);
		PartShowResponse partShowResponse = null;
		if(list != null && !list.isEmpty()){
			partShowResponse = new PartShowResponse();
			int index = 0;
			List<PartEntity> list1 = new ArrayList<PartEntity>();
			List<PartEntity> list2 = new ArrayList<PartEntity>();
			List<PartEntity> list3 = new ArrayList<PartEntity>();
			List<PartEntity> list4 = new ArrayList<PartEntity>();
			partShowResponse.setList1(list1);
			partShowResponse.setList2(list2);
			partShowResponse.setList3(list3);
			partShowResponse.setList4(list4);
			for (PartEntity part : list) {
				if(index == 0){
					list1.add(part);
					index ++ ;
				}
				else if(index == 1){
					list2.add(part);
					index ++ ;
				}
				else if(index == 2){
					list3.add(part);
					index ++ ;
				}
				else if(index == 3){
					list4.add(part);
					index = 0;
				}
			}
		}
		return partShowResponse;
	}
	
	
	
}
