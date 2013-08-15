package com.mxk.org.common.domain.constant;

public enum MetooGiftResultMessage {

	GIFT_SEND_SUCCESS(){
		public String getString() {
			return "礼物已经成功发送";
		}
	},GIFT_SEND_ERROR(){
		public String getString() {
			return "礼物发送失败";
		}
	},GIFT_SEND_REPEAT(){
		public String getString() {
			return "你已经发送过礼物了亲";
		}
	};
	
	public abstract String getString();
	
}
