package com.zhigu.common.constant.enumconst;

/**
 * 交易类型
 * 
 * @author HeSiMin
 * @date 2014年12月5日
 *
 */
public enum DealType {

	/** 支付宝充值 */
	ALIPAY_RECHARGE("支付宝充值", 1),
	/** 订单交易支付 */
	ORDER_DEAL_PAY("订单交易支付", 2),
	/** 订单交易退款 */
	ORDER_DEAL_REFUND("订单交易退款", 3),
	/** 订单交易收入 */
	ORDER_DEAL_INCOME("订单交易收入", 4),
	/** 订单交易收入(代发) */
	ORDER_DEAL_INCOME_AGENT("订单代发收入", 5),
	/** 用户提现 */
	USER_WITHDRAW("用户提现", 6), ;
	private String name;
	private int value;

	private DealType(String name, int value) {
		this.name = name;
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

}
