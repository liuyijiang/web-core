package com.mxk.org.common.domain.constant;
/**
 * 
 * @author Administrator
 *
 */
public enum MxkSubjectcCategory {
  
	SUBJECT_CATEGORY_CREATIVE(){
		public String getString() {
			return "原创";
		}
	},SUBJECT_CATEGORY_SHARE(){
		public String getString() {
			return "分享";
		}
	},SUBJECT_CATEGORY_WORKING(){
		public String getString() {
			return "进度";
		}
	};
	
	public abstract String getString();
	
}
