package com.zhigu.model;

import java.io.Serializable;

/**
 * 提成比例
 * 
 * @author HeSiMin
 * @date 2014年10月8日
 *
 */
public class CommissionPorportion implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -9203816980821369150L;
	private int ID;
	private int innerEmployeePorportion;
	private int basePorportion;
	private int firstPorportion;
	private int secondPorportion;
	private int thirdPorportion;
	private int addDate;
	private int addUserID;

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getInnerEmployeePorportion() {
		return innerEmployeePorportion;
	}

	public void setInnerEmployeePorportion(int innerEmployeePorportion) {
		this.innerEmployeePorportion = innerEmployeePorportion;
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

	public int getAddDate() {
		return addDate;
	}

	public void setAddDate(int addDate) {
		this.addDate = addDate;
	}

	public int getAddUserID() {
		return addUserID;
	}

	public void setAddUserID(int addUserID) {
		this.addUserID = addUserID;
	}

}
