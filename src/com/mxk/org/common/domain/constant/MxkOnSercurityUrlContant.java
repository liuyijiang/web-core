package com.mxk.org.common.domain.constant;

public enum MxkOnSercurityUrlContant {

	PART_DASH_BOARD(){
		public String getString() {
			return "/partDashBoard";
		}
	},
	SUBJECT_DASH_BOARD(){
		public String getString() {
			return "/visitiorShowSubjectDashBorad";
		}
	},
	INDEX(){
		public String getString() {
			return "/index";
		}
	},
	USER_LOGIN(){
		public String getString() {
			return "/loginView";
		}
	},
	USER_LOGININ(){
		public String getString() {
			return "分享";
		}
	},
	USER_REGISTER(){
		public String getString() {
			return "/registerView";
	 }
   };
	
   public abstract String getString();
}
