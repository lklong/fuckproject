package com.zhigu.common.constant.enumconst;

/**
 * 订单状态
 * 
 * @author zhouqibing 2014年8月7日下午2:16:23
 */
public enum OrderStatus {
	/** 待付款 */
	ORDER_WAIT_PAY("待付款", 1),
	/** 待发货 */
	ORDER_WAIT_SEND("待发货", 2),
	/** 待确认收货 */
	ORDER_WAIT_CONFIRM_RECEIVE_GOODS("待确认收货", 3),
	/** 交易完成 */
	ORDER_SUCCESS("交易完成", 4),
	/** 交易关闭(失效) */
	ORDER_CLOSE("交易关闭", 9);

	private String name;
	private int value;

	private OrderStatus(String name, int value) {
		this.name = name;
		this.value = value;
	}

	public int getValue() {
		return value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public static String getNameByValue(int value) {
		OrderStatus[] orderStatuses = OrderStatus.values();
		for (OrderStatus orderStatus : orderStatuses) {
			if (orderStatus.getValue() == value) {
				return orderStatus.getName();
			}
		}
		throw new RuntimeException("not exist order status");
	}
}
