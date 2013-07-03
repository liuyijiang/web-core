package com.mxk.org.common.chart;

import java.math.BigDecimal;

public class PieChartVO {

	private String type;
	private BigDecimal money;
	
	public PieChartVO(String type){
		this.type = type;
		this.money = new BigDecimal(0.0);
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}
	
	
}
