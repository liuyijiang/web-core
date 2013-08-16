package com.mxk.org.common.domain.constant;

public enum MetooTitleConstant {
    
	METOO_TITLE_SHARE_SUFFIX_NAME(){
		public String getString() {
			return "分享家";
		}
	},
	METOO_TITLE_COMMENT_SUFFIX_NAME(){
		public String getString() {
			return "评论家";
		}
	},
	METOO_TITLE_SUBJECT_SUFFIX_NAME(){
		public String getString() {
			return "制作家";
		}
	},
	METOO_TITLE_RUMEN_IMAGE(){
		public String getString() {
			return "rumen.png";
		}
	},
	METOO_TITLE_RUMEN(){
		public String getString() {
			return "入门级";
		}
	};
	
	public abstract String getString();
}
