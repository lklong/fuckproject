package com.zhigu.common.constant.enumconst;

/**
 * 公司类型（企业认证处用）
 * 
 * @author HeSiMin
 * @date 2014年8月15日
 *
 */
public enum CompanyType {
	ONE("个人独资企业", 1), TWO("合伙企业", 2), THREE("个体工商户", 3), FOUR("公司企业", 4);
	private String name;
	private int value;

	private CompanyType(String name, int value) {
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
