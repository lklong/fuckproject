package com.zhigu.model;

import java.util.Date;

/**
 * 员工会员
 * 
 * @author zhouqibing 2014年8月29日上午10:52:30
 */
public class StaffMember {
	private Integer ID;
	private Integer staffID;
	private Integer userID;
	private Integer status;
	private Date allotTime;

	public Integer getID() {
		return ID;
	}

	public void setID(Integer iD) {
		ID = iD;
	}

	public Integer getStaffID() {
		return staffID;
	}

	public void setStaffID(Integer staffID) {
		this.staffID = staffID;
	}

	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getAllotTime() {
		return allotTime;
	}

	public void setAllotTime(Date allotTime) {
		this.allotTime = allotTime;
	}

}
