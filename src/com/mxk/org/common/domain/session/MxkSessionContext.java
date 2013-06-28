package com.mxk.org.common.domain.session;

import java.util.HashMap;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;

@Scope(value = WebApplicationContext.SCOPE_REQUEST, proxyMode = ScopedProxyMode.TARGET_CLASS)
@Component
public class MxkSessionContext {

	public static final String MXK_SESSION = "mxk:session";
	public static final String MXK_SUBJECT_CASH = "mxk:subject_cach";
	
	public static final String MXK_JSEESION = "MXKJSESSIONID";
	
	private Map<String,String> key = new HashMap<String,String>();

	public Map<String, String> getKey() {
		return key;
	}

	public void setKey(Map<String, String> key) {
		this.key = key;
	}

	
}
