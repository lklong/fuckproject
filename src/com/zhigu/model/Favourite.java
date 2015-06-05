package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

public class Favourite implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/** ID */
	private int ID;
	/** 用户ID */
	private int userID;
	/** 收藏的ID */
	private int storeOrGoodsId;
	/** 类型 1：店铺 2：商品 */
	private int type;
	/** 添加日期 */
	private Date addTime;

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getStoreOrGoodsId() {
		return storeOrGoodsId;
	}

	public void setStoreOrGoodsId(int storeOrGoodsId) {
		this.storeOrGoodsId = storeOrGoodsId;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

}
