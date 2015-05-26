package com.zhigu.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 提成记录
 * 
 * @author HeSiMin
 * @date 2014年10月8日
 *
 */
public class CommissionRecord implements Serializable {
	private int ID;
	private int userID;
	/**
	 * 提成级别
	 */
	private int level;
	/**
	 * 提成比例ID
	 */
	private int commissionPorportionID;
	private int orderID;
	/**
	 * 提成金
	 */
	private BigDecimal commissionMoney;
	private Date addDate;

	// DTO用
	private String userName;
	private int commissionPorportion;
	private String orderNO;
	private int innerEmployeePorportion;
	private int basePorportion;
	private int firstPorportion;
	private int secondPorportion;
	private int thirdPorportion;

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getUserID() {
		return userID;
	}

	public int getInnerEmployeePorportion() {
		return innerEmployeePorportion;
	}

	public void setInnerEmployeePorportion(int innerEmployeePorportion) {
		this.innerEmployeePorportion = innerEmployeePorportion;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getCommissionPorportionID() {
		return commissionPorportionID;
	}

	public void setCommissionPorportionID(int commissionPorportionID) {
		this.commissionPorportionID = commissionPorportionID;
	}

	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public BigDecimal getCommissionMoney() {
		return commissionMoney;
	}

	public void setCommissionMoney(BigDecimal commissionMoney) {
		this.commissionMoney = commissionMoney;
	}

	public Date getAddDate() {
		return addDate;
	}

	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getCommissionPorportion() {
		if (this.level == 0) {
			return 100;
		} else if (this.level == 1) {
			return firstPorportion;
		} else if (this.level == 2) {
			return secondPorportion;
		} else if (this.level == 3) {
			return thirdPorportion;
		}
		return commissionPorportion;
	}

	public void setCommissionPorportion(int commissionPorportion) {
		this.commissionPorportion = commissionPorportion;
	}

	public String getOrderNO() {
		return orderNO;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public int getBasePorportion() {
		return basePorportion;
	}

	public void setBasePorportion(int basePorportion) {
		this.basePorportion = basePorportion;
	}

	public int getFirstPorportion() {
		return firstPorportion;
	}

	public void setFirstPorportion(int firstPorportion) {
		this.firstPorportion = firstPorportion;
	}

	public int getSecondPorportion() {
		return secondPorportion;
	}

	public void setSecondPorportion(int secondPorportion) {
		this.secondPorportion = secondPorportion;
	}

	public int getThirdPorportion() {
		return thirdPorportion;
	}

	public void setThirdPorportion(int thirdPorportion) {
		this.thirdPorportion = thirdPorportion;
	}

}
