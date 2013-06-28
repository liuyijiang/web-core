package com.mxk.org.common.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MxkMailAuthenticator extends Authenticator {
	
	String userName = null;
	String password = null;

	public MxkMailAuthenticator() {
	}

	public MxkMailAuthenticator(String username, String password) {
		this.userName = username;
		this.password = password;
	}

	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(userName, password);
	}
}
