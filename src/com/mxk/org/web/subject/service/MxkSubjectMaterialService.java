package com.mxk.org.web.subject.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.common.chart.PieChartVO;
import com.mxk.org.common.domain.constant.MxkConstant;
import com.mxk.org.entity.SubjectMaterialDetailEntity;
import com.mxk.org.entity.SubjectMaterialSummaryEntity;
import com.mxk.org.web.subject.dao.MxkSubjectMaterialDao;
import com.mxk.org.web.subject.domain.SubjectMaterailDetailRespone;

@Service
public class MxkSubjectMaterialService {

	@Autowired
	private MxkSubjectMaterialDao subjectMaterialDao;
	
	public String createMaterialChartData(List<SubjectMaterialDetailEntity> list){
		PieChartVO c1 = new PieChartVO(MxkConstant.SUBJECT_MATERIAL_TYPE_BJ);
		PieChartVO c2 = new PieChartVO(MxkConstant.SUBJECT_MATERIAL_TYPE_GZ);
		PieChartVO c3 = new PieChartVO(MxkConstant.SUBJECT_MATERIAL_TYPE_YQ);
		PieChartVO c4 = new PieChartVO(MxkConstant.SUBJECT_MATERIAL_TYPE_GJ);
		PieChartVO c5 = new PieChartVO(MxkConstant.SUBJECT_MATERIAL_TYPE_QT);
		for (SubjectMaterialDetailEntity vo : list) {
			BigDecimal money = vo.getMoney().multiply(new BigDecimal(vo.getNum()));
			if(vo.getType().equals(c1.getType())){
				c1.setMoney(c1.getMoney().add(money));
			}else if(vo.getType().equals(c2.getType())){
				c2.setMoney(c2.getMoney().add(money));
			}else if(vo.getType().equals(c3.getType())){
				c3.setMoney(c3.getMoney().add(money));
			}else if(vo.getType().equals(c4.getType())){
				c4.setMoney(c4.getMoney().add(money));
			}else if(vo.getType().equals(c5.getType())){
				c5.setMoney(c5.getMoney().add(money));
			}
		}
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		sb.append("['"+ c1.getType() +"',"+ c1.getMoney() +"],");
		sb.append("['"+ c2.getType() +"',"+ c2.getMoney() +"],");
		sb.append("['"+ c3.getType() +"',"+ c3.getMoney() +"],");
		sb.append("['"+ c4.getType() +"',"+ c4.getMoney() +"],");
		sb.append("['"+ c5.getType() +"',"+ c5.getMoney() +"]");
		sb.append("]");
		return sb.toString();
	}
	
	
	public SubjectMaterailDetailRespone findUserSubjectMaterials(String subjectid){
		SubjectMaterailDetailRespone subjectMaterailDetailRespone = new SubjectMaterailDetailRespone();
		SubjectMaterialSummaryEntity summary = subjectMaterialDao.findSubjecMaterialSummaryEntity(subjectid);
		List<SubjectMaterialDetailEntity> list =  subjectMaterialDao.findSubjectMaterialDetailEntity(subjectid);
		subjectMaterailDetailRespone.setList(list);
		subjectMaterailDetailRespone.setSummary(summary);
		return subjectMaterailDetailRespone;
	}
	
	public boolean delateSubjectMaterailDetailById(String id){
		return subjectMaterialDao.delateSubjectMaterailDetailById(id);
	}
	
	public SubjectMaterialSummaryEntity findSubjectMaterialSummaryEntityBySubjectId(String subjectid){
		return subjectMaterialDao.findSubjectMaterialSummaryEntityBySubjectId(subjectid);
	}
	
	public SubjectMaterialSummaryEntity findSubjectMaterialSummaryEntityById(String id){
		return subjectMaterialDao.findSubjectMaterialSummaryEntityById(id);
	}
	
	public boolean createSubjectMaterial(SubjectMaterialSummaryEntity summary,List<SubjectMaterialDetailEntity> list){
		return subjectMaterialDao.createSubjectMaterial(summary, list);
	}
	
	public boolean updateSubejcyMaterialExcelUrl(String id,String excel){
		return subjectMaterialDao.updateSubejcyMaterialExcelUrl(id, excel);
	}
}
