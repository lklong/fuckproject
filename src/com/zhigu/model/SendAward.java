package com.zhigu.model;

import java.io.Serializable;

/**
 * 发送奖励
 * 
 * @author HeSiMin
 * @date 2014年9月30日
 *
 */
public class SendAward implements Serializable {
	private int ID;
	private int userID;
	private int adminID;
	private float orignalPoint;
	private float usePoint;
	private String comment;

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

	public int getAdminID() {
		return adminID;
	}

	public void setAdminID(int adminID) {
		this.adminID = adminID;
	}

	public float getOrignalPoint() {
		return orignalPoint;
	}

	public void setOrignalPoint(float orignalPoint) {
		this.orignalPoint = orignalPoint;
	}

	public float getUsePoint() {
		return usePoint;
	}

	public void setUsePoint(float usePoint) {
		this.usePoint = usePoint;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

}
