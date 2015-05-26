package com.zhigu.model;

import java.math.BigDecimal;
import java.util.Date;

public class SystemAccount {
	private Long id;

	private String sno;

	private Integer userId;

	private Boolean incomeFlag;

	private BigDecimal money;

	private Date createTime;

	private String matter;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
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

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getMatter() {
		return matter;
	}

	public void setMatter(String matter) {
		this.matter = matter == null ? null : matter.trim();
	}
}