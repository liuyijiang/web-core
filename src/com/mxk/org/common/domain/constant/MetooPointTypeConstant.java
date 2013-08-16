package com.mxk.org.common.domain.constant;

public enum MetooPointTypeConstant {


	METOO_POINT_TYPE_PART(){
		public String getString() {
			return "part";
		}
	},
	METOO_POINT_TYPE_COMMENT(){
		public String getString() {
			return "comment";
		}
	},
	METOO_POINT_TYPE_SUBJECT(){
		public String getString() {
			return "subject";
		}
	};
	
	public abstract String getString();
	
}
