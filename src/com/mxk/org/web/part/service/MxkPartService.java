package com.mxk.org.web.part.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.common.factory.EntityFactory;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.web.part.dao.MxkPartDao;
import com.mxk.org.web.part.domain.CreatePartRequest;
import com.mxk.org.web.part.domain.PartShowResponse;
import com.mxk.org.web.part.domain.SearchPartRequest;
import com.mxk.org.web.part.domain.UpdatePartInfoRequest;
import com.mxk.org.web.subject.domain.SubjectNewPartsVO;

@Service
public class MxkPartService {

	@Autowired
	private MxkPartDao partDao;
	
	public SubjectNewPartsVO findSubjectNewParts(String subjectid){
		SubjectNewPartsVO subjectNewPartsVO = null; 
		List<PartEntity> list = partDao.findSubjectNewParts(subjectid);
		if(list != null && list.size() == 5){
			subjectNewPartsVO = new SubjectNewPartsVO();
			subjectNewPartsVO.setPartId1(list.get(0).getId());
			subjectNewPartsVO.setPartImage1(list.get(0).getMinimage());
			subjectNewPartsVO.setPartId2(list.get(1).getId());
			subjectNewPartsVO.setPartImage2(list.get(1).getMinimage());
			subjectNewPartsVO.setPartId3(list.get(2).getId());
			subjectNewPartsVO.setPartImage3(list.get(2).getMinimage());
			subjectNewPartsVO.setPartId4(list.get(3).getId());
			subjectNewPartsVO.setPartImage4(list.get(3).getMinimage());
			subjectNewPartsVO.setPartId5(list.get(4).getId());
			subjectNewPartsVO.setPartImage5(list.get(4).getMinimage());
		}
		return subjectNewPartsVO;
	}
	
	public boolean updatePartCommentsQuantity(String id,String type,boolean desc) {
		String partType = null;
		if(MxkConstant.COMMENT_TYPE_TEXT.equals(type)){
			partType = "comments";
		}else if(MxkConstant.COMMENT_TYPE_WAV.equals(type)){
			partType = "audios";
		}		
		return partDao.updatePartCommentsQuantity(id, partType, desc);
	}
	
	public long findSubjectPartNotInUserId(String userid,String subjectid){
		return partDao.findSubjectPartNotInUserId(userid, subjectid);
	}
	
	public boolean removePartById(String partid){
		return partDao.removePartById(partid);
	}
	
	public boolean updatePartById(UpdatePartInfoRequest updatePartInfoRequest){
		return partDao.updatePartById(updatePartInfoRequest);
	}
	
	public PartEntity findPartEntityById(String id){
		return partDao.findPartEntityById(id);
	}
	
	public String savePart(CreatePartRequest request){
		PartEntity partEntity = EntityFactory.createPartEntity(request);
		partDao.savePart(partEntity);
		return partEntity.getId();
	}
	
	public boolean updatePartImage(String partid,String image,String minimage){
		return partDao.updatePartImage(partid, image, minimage);
	}
	
	public long findPartEnitiyPageByType(String type){
		return partDao.findPartEnitiyPageByType(type);
	}
	
	public PartShowResponse findUserSubjectParts(SearchPartRequest request){
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
	
	public PartShowResponse findUserCollectParts(List<String> ids){
		List<PartEntity> list = partDao.findPartEntityByIds(ids);
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
