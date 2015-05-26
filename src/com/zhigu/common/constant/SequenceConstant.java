package com.zhigu.common.constant;

/**
 * 序号类型
 * 
 * @author zhouqibing 2014年8月9日上午11:59:56
 */
public enum SequenceConstant {
	/** 订单 */
	ORDER(1),
	/** 流水号 */
	FLOW(9), ;

	private int value;

	private SequenceConstant(int value) {
		this.value = value;
	}

	public int getValue() {
		return value;
	}
}
