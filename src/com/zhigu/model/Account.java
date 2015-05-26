package com.zhigu.model;

import java.math.BigDecimal;

public class Account {
	private Integer userId;

	private BigDecimal normalMoney;

	private BigDecimal freezeMoney;

	private Integer version;

	private String payPasswd;

	private String salt;

	private String bankNo;

	private String bankCardMaster;

	private String bankName;

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public BigDecimal getNormalMoney() {
		return normalMoney;
	}

	public void setNormalMoney(BigDecimal normalMoney) {
		this.normalMoney = normalMoney;
	}

	public BigDecimal getFreezeMoney() {
		return freezeMoney;
	}

	public void setFreezeMoney(BigDecimal freezeMoney) {
		this.freezeMoney = freezeMoney;
	}

	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	public String getPayPasswd() {
		return payPasswd;
	}

	public void setPayPasswd(String payPasswd) {
		this.payPasswd = payPasswd == null ? null : payPasswd.trim();
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt == null ? null : salt.trim();
	}

	public String getBankNo() {
		return bankNo;
	}

	public void setBankNo(String bankNo) {
		this.bankNo = bankNo == null ? null : bankNo.trim();
	}

	public String getBankCardMaster() {
		return bankCardMaster;
	}

	public void setBankCardMaster(String bankCardMaster) {
		this.bankCardMaster = bankCardMaster == null ? null : bankCardMaster.trim();
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName == null ? null : bankName.trim();
	}
}