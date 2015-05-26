package com.zhigu.model;

import java.util.Date;

/**
 * 会员过滤条件
 * 
 * @author zhouqibing 2014年8月28日下午3:53:54
 */
public class MemberCondition {
	private Integer status;
	private Integer staffID;// 员工ID
	private String username;// 会员名
	private Date startDate;// 开始注册时间
	private Date endDate;

	private Integer isSeller;
	private Integer isPhoneBound;
	private Integer isEmailBound;
	private Integer isAllot;

	private Integer order;

	private String storeName;
	private String phone;
	private String email;
	private Integer realUserStatus;
	private Integer companyStatus;
	private Integer realStoreStatus;
	private Integer isInnerEmployee;

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Integer getIsSeller() {
		return isSeller;
	}

	public void setIsSeller(Integer isSeller) {
		this.isSeller = isSeller;
	}

	public Integer getIsPhoneBound() {
		return isPhoneBound;
	}

	public void setIsPhoneBound(Integer isPhoneBound) {
		this.isPhoneBound = isPhoneBound;
	}

	public Integer getIsEmailBound() {
		return isEmailBound;
	}

	public void setIsEmailBound(Integer isEmailBound) {
		this.isEmailBound = isEmailBound;
	}

	public Integer getOrder() {
		return order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	public Integer getStaffID() {
		return staffID;
	}

	public void setStaffID(Integer staffID) {
		this.staffID = staffID;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public Integer getIsAllot() {
		return isAllot;
	}

	public void setIsAllot(Integer isAllot) {
		this.isAllot = isAllot;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getRealUserStatus() {
		return realUserStatus;
	}

	public void setRealUserStatus(Integer realUserStatus) {
		this.realUserStatus = realUserStatus;
	}

	public Integer getCompanyStatus() {
		return companyStatus;
	}

	public void setCompanyStatus(Integer companyStatus) {
		this.companyStatus = companyStatus;
	}

	public Integer getRealStoreStatus() {
		return realStoreStatus;
	}

	public void setRealStoreStatus(Integer realStoreStatus) {
		this.realStoreStatus = realStoreStatus;
	}

	public Integer getIsInnerEmployee() {
		return isInnerEmployee;
	}

	public void setIsInnerEmployee(Integer isInnerEmployee) {
		this.isInnerEmployee = isInnerEmployee;
	}

}
