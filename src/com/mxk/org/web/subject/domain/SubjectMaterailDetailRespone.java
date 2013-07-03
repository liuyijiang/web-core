package com.mxk.org.web.subject.domain;

import java.util.List;

import com.mxk.org.entity.SubjectMaterialDetailEntity;
import com.mxk.org.entity.SubjectMaterialSummaryEntity;

public class SubjectMaterailDetailRespone {
   
	private String chartData;
	private SubjectMaterialSummaryEntity summary;
	private List<SubjectMaterialDetailEntity> list;
	
	public SubjectMaterialSummaryEntity getSummary() {
		return summary;
	}
	public void setSummary(SubjectMaterialSummaryEntity summary) {
		this.summary = summary;
	}
	public List<SubjectMaterialDetailEntity> getList() {
		return list;
	}
	public void setList(List<SubjectMaterialDetailEntity> list) {
		this.list = list;
	}
	public String getChartData() {
		return chartData;
	}
	public void setChartData(String chartData) {
		this.chartData = chartData;
	}
	
	
	
}
