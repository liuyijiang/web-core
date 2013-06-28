package com.mxk.org.entity;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * subject 附加值信息
 * @author liuyijiang
 *
 */
@Document
public class SubjectExtraEntity implements Serializable {
  
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6681463954894038215L;
	
	@Id
	private String id;
	private String userid;
	private String subjectid;
	private String pdfUrl;
	private String gifUrl;
	private int urlDowmloadTimes;//下载次数
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}
	public String getPdfUrl() {
		return pdfUrl;
	}
	public void setPdfUrl(String pdfUrl) {
		this.pdfUrl = pdfUrl;
	}
	public String getGifUrl() {
		return gifUrl;
	}
	public void setGifUrl(String gifUrl) {
		this.gifUrl = gifUrl;
	}
	public int getUrlDowmloadTimes() {
		return urlDowmloadTimes;
	}
	public void setUrlDowmloadTimes(int urlDowmloadTimes) {
		this.urlDowmloadTimes = urlDowmloadTimes;
	}
    	
	
}
