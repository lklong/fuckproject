package com.zhigu.model;

import java.math.BigDecimal;
import java.util.Date;

import com.zhigu.common.constant.enumconst.WithdrawStatus;

public class Withdraw {
	private Long id;

	private Integer userId;

	private BigDecimal money;

	private String toAccountMaster;

	private String toAccount;

	private Integer status;

	private Integer handlerAdminId;

	private Date acceptTime;

	private Date endTime;

	private Date createTime;

	private String bankName;

	// --以下为查询展示用属性---
	private String statusLabel;
	private String userName;
	private String userPhone;
	private String adminName;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public String getToAccountMaster() {
		return toAccountMaster;
	}

	public void setToAccountMaster(String toAccountMaster) {
		this.toAccountMaster = toAccountMaster == null ? null : toAccountMaster.trim();
	}

	public String getToAccount() {
		return toAccount;
	}

	public void setToAccount(String toAccount) {
		this.toAccount = toAccount == null ? null : toAccount.trim();
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getHandlerAdminId() {
		return handlerAdminId;
	}

	public void setHandlerAdminId(Integer handlerAdminId) {
		this.handlerAdminId = handlerAdminId;
	}

	public Date getAcceptTime() {
		return acceptTime;
	}

	public void setAcceptTime(Date acceptTime) {
		this.acceptTime = acceptTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName == null ? null : bankName.trim();
	}

	public String getStatusLabel() {
		return WithdrawStatus.getNameByValue(this.status);
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

}