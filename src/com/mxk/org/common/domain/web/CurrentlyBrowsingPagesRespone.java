package com.mxk.org.common.domain.web;

import java.io.Serializable;

/**
 * 
 * @author Administrator
 *
 */
public class CurrentlyBrowsingPagesRespone implements Serializable{
  
	/**
	 * 
	 */
	private static final long serialVersionUID = 4428780100846509652L;
	
	private String key;
	private int partPage;
	private int subjectPage;
	
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public int getPartPage() {
		return partPage;
	}
	public void setPartPage(int partPage) {
		this.partPage = partPage;
	}
	public int getSubjectPage() {
		return subjectPage;
	}
	public void setSubjectPage(int subjectPage) {
		this.subjectPage = subjectPage;
	}
	
	
	
}
