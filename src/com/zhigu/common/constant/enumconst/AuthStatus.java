package com.zhigu.common.constant.enumconst;

/**
 * 审核状态
 * 
 * @author HeSiMin
 * @date 2014年8月13日
 *
 */
public enum AuthStatus {
	/**
	 * 未认证
	 */
	ON_AUTH("未认证", 0),
	// 待审核
	WAIT("待审核", 1),
	// 通过
	PASS("审核通过", 2),
	// 驳回
	REJECT("审核未通过", 3), ;
	private String name;
	private int value;

	private AuthStatus(String name, int value) {
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
		AuthStatus[] as = AuthStatus.values();
		for (AuthStatus a : as) {
			if (a.getValue() == value) {
				return a.getName();
			}
		}
		return "";
	}
}
