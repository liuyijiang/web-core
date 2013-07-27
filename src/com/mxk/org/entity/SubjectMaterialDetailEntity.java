package com.mxk.org.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class SubjectMaterialDetailEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1087110898488189628L;
  
	private String id;
	private String subjectid;
	private String userid;
	private String summaryid;//
	private String name;
	private String brand;
	private String type;
	private int num;//����
	private BigDecimal money;
	private BigDecimal allMoney;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSummaryid() {
		return summaryid;
	}
	public void setSummaryid(String summaryid) {
		this.summaryid = summaryid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public BigDecimal getMoney() {
		return money;
	}
	public void setMoney(BigDecimal money) {
		this.money = money;
	}
	public BigDecimal getAllMoney() {
		return allMoney;
	}
	public void setAllMoney(BigDecimal allMoney) {
		this.allMoney = allMoney;
	}
	
	
	
}
