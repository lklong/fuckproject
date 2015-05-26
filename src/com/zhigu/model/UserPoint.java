package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户积分
 * 
 * @author HeSiMin
 * @date 2014年9月28日
 *
 */
public class UserPoint implements Serializable {
	private int ID;
	private int userID;
	private String userName;
	private String nickName;
	private String name;
	private String phone;
	private String address;
	private float rechargePoint;
	private String comment;
	private Date addDate;
	private float servicePoint;
	private float goodsPoint;
	private float registerPoint;// 2015/03/06 注册推荐积分已暂停

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getUserID() {
		return userID;
	}

	public float getRechargePoint() {
		return rechargePoint;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setRechargePoint(float rechargePoint) {
		this.rechargePoint = rechargePoint;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getAddDate() {
		return addDate;
	}

	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}

	public float getServicePoint() {
		return servicePoint;
	}

	public void setServicePoint(float servicePoint) {
		this.servicePoint = servicePoint;
	}

	public float getGoodsPoint() {
		return goodsPoint;
	}

	public void setGoodsPoint(float goodsPoint) {
		this.goodsPoint = goodsPoint;
	}

	public float getRegisterPoint() {
		// 注册积分废弃
		registerPoint = 0;
		return registerPoint;
	}

	public void setRegisterPoint(float registerPoint) {
		this.registerPoint = registerPoint;
	}

}
