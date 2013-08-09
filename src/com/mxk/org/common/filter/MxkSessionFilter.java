package com.mxk.org.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.domain.session.MxkSessionContext;

/**
 * �������õ������������jsession �� cookie value ��Ϊkey
 * @author liuyijiang
 *
 */
public class MxkSessionFilter extends HttpServlet implements Filter {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = -2055302630481579581L;
	
	@Autowired
	private MxkSessionContext sessionCntext;
	
	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		Cookie ck[] = request.getCookies();
		if(ck != null){
			for(Cookie cookie : ck){
				if(cookie.getName().equals(MxkSessionContext.MXK_JSEESION)){
					sessionCntext.getKey().put(MxkSessionContext.MXK_SESSION, cookie.getValue());
				}
//				if(cookie.getName().equals(MxkSessionContext.MXK_PAGE_JSEESION)){
//					sessionCntext.getKey().put(MxkSessionContext.MXK_PAGE_SESSION, cookie.getValue());
//				}
			}
		}
		chain.doFilter(req, res);

	}

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

	
	
}