package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

public class Favourite implements Serializable {
	/** ID */
	private int ID;
	/** 用户ID */
	private int userID;
	/** 收藏的ID */
	private int favouriteID;
	/** 类型：1：店铺、2：商品 */
	private int type;
	/** 添加日期 */
	private Date addDate;

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

	public int getFavouriteID() {
		return favouriteID;
	}

	public void setFavouriteID(int favouriteID) {
		this.favouriteID = favouriteID;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Date getAddDate() {
		return addDate;
	}

	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}

}
