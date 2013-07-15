package com.mxk.org.web.visitor.domain;

import com.mxk.org.entity.CollectInformationEntity;

public class CollectPartsDataReponse {
   
	private CollectInformationEntity entity;
	private int top;
	private int left;
	
	public CollectInformationEntity getEntity() {
		return entity;
	}
	public void setEntity(CollectInformationEntity entity) {
		this.entity = entity;
	}
	public int getTop() {
		return top;
	}
	public void setTop(int top) {
		this.top = top;
	}
	public int getLeft() {
		return left;
	}
	public void setLeft(int left) {
		this.left = left;
	}
	 
	
	
}
