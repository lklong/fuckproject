package com.zhigu.common.constant;

/**
 * 商圈
 * 
 * @author HeSiMin
 * @date 2014年8月15日
 *
 */
public enum BusinessArea {
	AREA1("国际商贸城商圈", 1), AREA2("荷花池商圈", 2), AREA3("青龙市场", 3), AREA4("金花镇工业区", 4);
	private String name;
	private int value;

	private BusinessArea(String name, int value) {
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
		BusinessArea[] businessAreas = BusinessArea.values();
		for (BusinessArea businessArea : businessAreas) {
			if (businessArea.getValue() == value) {
				return businessArea.getName();
			}
		}
		return "";
	}
}
