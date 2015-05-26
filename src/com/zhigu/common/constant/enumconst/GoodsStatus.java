package com.zhigu.common.constant.enumconst;

/**
 * 商品状态
 * 
 * @author HeSiMin
 * @date 2014年9月3日
 *
 */
public enum GoodsStatus {
	// WAIT_AUDITING("待审核", 0),
	NORMAL("正常", 1), SOLD_OUT("下架", 2),
	// AUDIT_FAIL("审核失败", 3),
	;
	private String name;
	private int value;

	private GoodsStatus(String name, int value) {
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

	public static String getNameByValue(int value) {
		CompanyType[] companyTypes = CompanyType.values();
		for (CompanyType companyType : companyTypes) {
			if (companyType.getValue() == value) {
				return companyType.getName();
			}
		}
		return "";
	}
}
