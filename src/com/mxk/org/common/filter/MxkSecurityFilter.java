package com.mxk.org.common.filter;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.connect.mencache.MemcachSessionLoad;
import com.mxk.org.common.domain.session.MxkSessionContext;
import com.mxk.org.common.util.StringUtil;

public class MxkSecurityFilter extends HttpServlet implements Filter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4525096167186536429L;

	private Set<String> set = new HashSet<String>();
	
	private static final String DEFUALT_ACTION_EPX  = ".action";
	
	@Autowired
	private MxkSessionContext sessionCntext;
	
	@Autowired
	private MemcachSessionLoad msload;
	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
//		if(checkUserLogined()){ //已登录
			chain.doFilter(req, res);
//		}else{
//			HttpServletRequest request = (HttpServletRequest) req;
//			HttpServletResponse response = (HttpServletResponse) res;
//			String path = request.getServletPath();  //得到当前请求的路径
//			if(!checkUrlNeedLogin(path)){
//				chain.doFilter(req, res);
//			}else{
//				response.sendRedirect(request.getContextPath()+"/showRegist");
//			}
//		}
	}

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

	private boolean checkUserLogined(){
		boolean logined = false;
		String key = sessionCntext.getKey().get(MxkSessionContext.MXK_SESSION);
		String userid = null;
		if(!StringUtil.stringIsEmpty(key)){
			userid = msload.getSessionData(key);
		}
		if(userid != null){
			logined = true;
		}
		return logined;
	}
	
	private boolean checkUrlNeedLogin(String url){
		boolean needLogin = true;
		if(url.indexOf(".") != -1){
			String exp = url.substring(url.indexOf("."),url.length());
			if(DEFUALT_ACTION_EPX.equals(exp)){
				return true;
			}else{
				return false;
			}
		}
		if(set.contains(url)){
			needLogin = false;
		}
		return needLogin;
	}

	public Set<String> getSet() {
		return set;
	}

	public void setSet(Set<String> set) {
		this.set = set;
	}
	
	
}
