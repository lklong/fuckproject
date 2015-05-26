package com.zhigu.model;

import java.util.Date;

/**
 * 用户积分兑换
 * 
 * @author HeSiMin
 * @date 2014年11月11日
 *
 */
public class UserPointExchange {
	private int id;
	private int userId;
	/**
	 * 账户名
	 */
	private String userName;
	/**
	 * 收货人名
	 */
	private String name;
	private String address;
	private String phone;
	/**
	 * 邮政编码
	 */
	private String postCode;
	/**
	 * 原始积分
	 */
	private float orignalPoint;
	/**
	 * 消耗积分点
	 */
	private int usePoint;
	/**
	 * 积分类型
	 */
	private int pointType;
	/**
	 * 兑换物品名
	 */
	private String exchangeName;
	/**
	 * 发货操作人
	 */
	private int adminId;
	private int status;
	private Date addTime;
	private String comment;
	/**
	 * 兑换物品id
	 */
	private int exchangeId;

	public int getExchangeId() {
		return exchangeId;
	}

	public void setExchangeId(int exchangeId) {
		this.exchangeId = exchangeId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public float getOrignalPoint() {
		return orignalPoint;
	}

	public void setOrignalPoint(float orignalPoint) {
		this.orignalPoint = orignalPoint;
	}

	public int getUsePoint() {
		return usePoint;
	}

	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}

	public String getExchangeName() {
		return exchangeName;
	}

	public void setExchangeName(String exchangeName) {
		this.exchangeName = exchangeName;
	}

	public int getAdminId() {
		return adminId;
	}

	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getPointType() {
		return pointType;
	}

	public void setPointType(int pointType) {
		this.pointType = pointType;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

}
