package com.mxk.org.common.domain.constant;

public enum MetooResultMessage {
	
	ACTION_REPEAT(){
		public String getString() {
			return "你已经做过这个操作了 亲";
		}
	},
	UPGRADE_FAIL(){
		public String getString() {
			return "升级失败 目前的积分无法匹配相应等级";
		}
	};
	
	public abstract String getString();
}
