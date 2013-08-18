package com.mxk.org.web.system;

import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.base.MxkSessionAction;
import com.mxk.org.entity.GiftEntity;
import com.mxk.org.entity.TitleEntity;
import com.mxk.org.web.system.dao.MetooSystemDao;

public class MetooSystemAction  extends MxkSessionAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1026703345518279136L;

	@Autowired
	private MetooSystemDao dao;
	
	private GiftEntity giftEntity;
	
	public String metooAddGiftView(){
		return SUCCESS;
	}

	//添加礼物
	public String metooAddGift(){ 
		GiftEntity g1 = new GiftEntity();
		g1.setGifImage("alarm.png");
		g1.setGifMessage("送你一个闹钟 定好时间随时开工");
		g1.setGifType("ALARM");
		g1.setPoint(2);
		g1.setGiftName("闹钟");
		dao.createGift(g1);
		GiftEntity g2 = new GiftEntity();
		g2.setGifImage("ruby.png");
		g2.setGifMessage("一颗10卡拉的大红宝石");
		g2.setGifType("RUBY");
		g2.setPoint(4);
		g2.setGiftName("宝石");
		dao.createGift(g2);
		GiftEntity g3 = new GiftEntity();
		g3.setGifImage("calculator.png");
		g3.setGifMessage("一个计算器你可以算下你做模型用了多少钱");
		g3.setGifType("CALCULATOR");
		g3.setPoint(2);
		g3.setGiftName("计算器");
		dao.createGift(g3);
		GiftEntity g4 = new GiftEntity();
		g4.setGifImage("camera.png");
		g4.setGifMessage("送你一个照相机不要当冠希哥");
		g4.setGifType("CAMERA");
		g4.setPoint(2);
		g4.setGiftName("照相机");
		dao.createGift(g4);
		GiftEntity g5 = new GiftEntity();
		g5.setGifImage("cd.png");
		g5.setGifMessage("送你一张CD里面有好看的东东哟");
		g5.setGifType("CD");
		g5.setPoint(3);
		g5.setGiftName("CD");
		dao.createGift(g5);
		return SUCCESS;
	}
	

	//更新所有用户的parts数量1
	public String metooUpdateUserParts(){
		dao.updateUserParts();
		return SUCCESS;
	}
	
	//2
	public String metooCreateUserTitle(){
		dao.systemCreateUserTitle();
		return SUCCESS;
	}
	
	//3
	public String metooUpdateUserTitle(){
		dao.systemUpdateUserTitle();
		return SUCCESS;
	}
	
	//更新title
	public String  metooUpdateTitle(){
		TitleEntity e = new TitleEntity();
		e.setCode("METOO_TITLE_RUMEN");
		e.setName("入门级");
		e.setPoint(10);
		e.setImage("rumen.png");
		dao.createTitle(e);
		return SUCCESS;
	}
	
	
	public GiftEntity getGiftEntity() {
		return giftEntity;
	}

	public void setGiftEntity(GiftEntity giftEntity) {
		this.giftEntity = giftEntity;
	}
	
	
	
}
