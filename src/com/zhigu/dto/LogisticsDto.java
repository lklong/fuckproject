package com.zhigu.dto;

import java.math.BigDecimal;

import com.zhigu.model.Logistics;

public class LogisticsDto extends Logistics {
	private BigDecimal logisticsMoney;

	public BigDecimal getLogisticsMoney() {
		return logisticsMoney;
	}

	public void setLogisticsMoney(BigDecimal logisticsMoney) {
		this.logisticsMoney = logisticsMoney;
	}

}
