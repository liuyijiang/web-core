package com.mxk.org.common.domain.constant;

public enum MetooCertificateConstant {
	
	METOO_CERTIFICATE_TITLE_SHARE(){
		public String getString() {
			return "_sharer";
		}
	},
	METOO_CERTIFICATE_TITLE_COMMENT(){
		public String getString() {
			return "_commenter";
		}
	},
	METOO_CERTIFICATE_TITLE_SUBJECT(){
		public String getString() {
			return "_creater";
		}
	},
	METOO_CERTIFICATE_CAOGEN(){
		public String getString() {
			return "_caogen";
		}
	},
	METOO_CERTIFICATE_DIAOSI(){
		public String getString() {
			return "_diaosi";
		}
	};
	
	public abstract String getString();
	
}
