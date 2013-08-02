package com.mxk.org.common.base;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;
/**
 * 基础action 封装request  response
 * @author liuyijiang
 *
 */
public class MxkBaseAction extends ActionSupport implements ServletRequestAware, ServletResponseAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7851363029140739078L;
	
	public HttpServletRequest request;  
	public HttpServletResponse response; 
	
	public static final String NEED_LOGIN = "needLogin";
	
	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
		
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
		
	}

	
	
}
