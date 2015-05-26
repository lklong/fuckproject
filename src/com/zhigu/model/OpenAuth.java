package com.zhigu.model;

import java.io.Serializable;

/***********************************************************************
 * Module: OpenAuth.java Author: Administrator Purpose: Defines the Class
 * OpenAuth
 ***********************************************************************/

public class OpenAuth implements Serializable {
	// ID
	private int ID;
	// 第三方认证ID
	private String openID;
	// 第三方帐号
	private String openUser;
	// 第三方类型
	private int openType;
	// 本地帐号ID
	private int userID;

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public String getOpenID() {
		return openID;
	}

	public void setOpenID(String openID) {
		this.openID = openID;
	}

	public String getOpenUser() {
		return openUser;
	}

	public void setOpenUser(String openUser) {
		this.openUser = openUser;
	}

	public int getOpenType() {
		return openType;
	}

	public void setOpenType(int openType) {
		this.openType = openType;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

}