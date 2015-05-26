package com.zhigu.model;

import java.math.BigDecimal;

public class Logistics {
	private Integer id;

	private String name;

	private String code;

	private BigDecimal fweight;

	private BigDecimal fmoney;

	private BigDecimal cweight;

	private BigDecimal cmoney;

	private Integer status;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code == null ? null : code.trim();
	}

	public BigDecimal getFweight() {
		return fweight;
	}

	public void setFweight(BigDecimal fweight) {
		this.fweight = fweight;
	}

	public BigDecimal getFmoney() {
		return fmoney;
	}

	public void setFmoney(BigDecimal fmoney) {
		this.fmoney = fmoney;
	}

	public BigDecimal getCweight() {
		return cweight;
	}

	public void setCweight(BigDecimal cweight) {
		this.cweight = cweight;
	}

	public BigDecimal getCmoney() {
		return cmoney;
	}

	public void setCmoney(BigDecimal cmoney) {
		this.cmoney = cmoney;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
}