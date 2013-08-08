package com.mxk.org.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.connect.mencache.MemcachSessionLoad;
import com.mxk.org.common.domain.session.MxkSessionContext;
/**
 * page
 * @author Administrator
 *
 */
public class MxkPageLocationFilter extends HttpServlet implements Filter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4525096167186536429L;

	
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
//		    String key = sessionCntext.getKey().get(MxkSessionContext.MXK_SESSION);
//			chain.doFilter(req, res);
	}

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
