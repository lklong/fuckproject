package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

import com.zhigu.common.constant.enumconst.PointType;

/**
 * 积分兑换商品
 * 
 * @author HeSiMin
 * @date 2014年12月9日
 *
 */
public class PointExchangeGoods implements Serializable {
	private int id;
	/**
	 * 名字
	 */
	private String name;
	/**
	 * 图片
	 */
	private String picture;
	/**
	 * 库存
	 */
	private int repertory;
	/**
	 * 积分类型
	 */
	private int pointType;
	/**
	 * 需要积分
	 */

	private int needPoint;
	/**
	 * 商品详情描述
	 */
	private String details;
	/**
	 * 状态 1：可兑换 0：已兑换结束
	 */
	private int status;
	/**
	 * 添加id
	 */
	private int adminId;
	/**
	 * 添加时间
	 */
	private Date addTime;
	/*
	 * 原价
	 */
	private double money;

	private int version = 0;
	/**
	 * 积分类型 label
	 */
	private String pointTypeLabel;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPicture() {
		return picture;
	}

	public int getPointType() {
		return pointType;
	}

	public void setPointType(int pointType) {
		this.pointType = pointType;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public int getRepertory() {
		return repertory;
	}

	public void setRepertory(int repertory) {
		this.repertory = repertory;
	}

	public String getPointTypeLabel() {
		String pointNameString = PointType.getPointType(this.pointType).getName();
		return pointNameString;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public int getNeedPoint() {
		return needPoint;
	}

	public void setNeedPoint(int needPoint) {
		this.needPoint = needPoint;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getAdminId() {
		return adminId;
	}

	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public double getMoney() {
		return money;
	}

	public void setMoney(double money) {
		this.money = money;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

}
