package com.zhigu.common.constant.enumconst;

/**
 * 提现申请状态
 * 
 * @author HeSiMin
 * @date 2014年8月13日
 *
 */
public enum WithdrawStatus {
	/** 申请 */
	APPLY_FOR("申请待审核", 1),
	/** 受理中 */
	ACCEPT("受理中", 2),
	/** 提现成功 */
	SUCCESS("提现成功", 3),
	/** 提现失败 */
	FAIL("提现失败", 4);
	private String name;
	private int value;

	private WithdrawStatus(String name, int value) {
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
		WithdrawStatus[] withdrawStatus = WithdrawStatus.values();
		for (WithdrawStatus s : withdrawStatus) {
			if (s.getValue() == value) {
				return s.getName();
			}
		}
		throw new RuntimeException("not exist order status");
	}
}
