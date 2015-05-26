package com.zhigu.model;

import java.math.BigDecimal;

public class LogisticsSpecial {
	private Integer id;

	private Integer logisticsId;

	private String province;

	private String city;

	private BigDecimal fweight;

	private BigDecimal fmoney;

	private BigDecimal cweight;

	private BigDecimal cmoney;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getLogisticsId() {
		return logisticsId;
	}

	public void setLogisticsId(Integer logisticsId) {
		this.logisticsId = logisticsId;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province == null ? null : province.trim();
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city == null ? null : city.trim();
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
}