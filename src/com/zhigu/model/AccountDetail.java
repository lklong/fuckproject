package com.zhigu.model;

import java.math.BigDecimal;
import java.util.Date;

public class AccountDetail {
	private Integer id;

	private String sno;

	private Integer userId;

	private Boolean incomeFlag;

	private BigDecimal originalMoney;

	private BigDecimal dealMoney;

	private String dealMatter;

	private Date dealTime;

	private Integer dealType;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSno() {
		return sno;
	}

	public void setSno(String sno) {
		this.sno = sno == null ? null : sno.trim();
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Boolean getIncomeFlag() {
		return incomeFlag;
	}

	public void setIncomeFlag(Boolean incomeFlag) {
		this.incomeFlag = incomeFlag;
	}

	public BigDecimal getOriginalMoney() {
		return originalMoney;
	}

	public void setOriginalMoney(BigDecimal originalMoney) {
		this.originalMoney = originalMoney;
	}

	public BigDecimal getDealMoney() {
		return dealMoney;
	}

	public void setDealMoney(BigDecimal dealMoney) {
		this.dealMoney = dealMoney;
	}

	public String getDealMatter() {
		return dealMatter;
	}

	public void setDealMatter(String dealMatter) {
		this.dealMatter = dealMatter == null ? null : dealMatter.trim();
	}

	public Date getDealTime() {
		return dealTime;
	}

	public void setDealTime(Date dealTime) {
		this.dealTime = dealTime;
	}

	public Integer getDealType() {
		return dealType;
	}

	public void setDealType(Integer dealType) {
		this.dealType = dealType;
	}
}