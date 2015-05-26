package com.zhigu.common.constant.enumconst;

/**
 * 公司类型（企业认证处用）
 * 
 * @author HeSiMin
 * @date 2014年8月15日
 *
 */
public enum StoreApproveState {
	/** 待审核 */
	WAIT_APPROVED("待开启", 1),
	// /** 审核不通过 */
	// FAIL("审核未通过", 3),
	/** 店铺开启 */
	OPEN("店铺开启", 4), ;
	private String name;
	private int value;

	private StoreApproveState(String name, int value) {
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
