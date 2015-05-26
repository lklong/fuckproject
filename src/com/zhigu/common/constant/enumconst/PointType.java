package com.zhigu.common.constant.enumconst;

/**
 * 积分点类型
 * 
 * @author HeSiMin
 * @date 2014年12月15日
 *
 */
public enum PointType {
	POINT_RECHARGE("充值积分", 1), POINT_SHOPPING_GOODS("商品消费积分", 2), POINT_SHOPPING_SERVICE("服务消费积分", 3), ;
	// POINT_REGISTER("注册推荐积分", 4);// 2015/03/06 he.simin废弃
	private String name;
	private int value;

	private PointType(String name, int value) {
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
		PointType[] depositLevels = PointType.values();
		for (PointType depositLevel : depositLevels) {
			if (depositLevel.getValue() == value) {
				return depositLevel.getName();
			}
		}
		return null;
	}

	public static PointType getPointType(int value) {
		if (value < 1) {
			return null;
		}
		PointType[] depositLevels = PointType.values();
		for (PointType depositLevel : depositLevels) {
			if (depositLevel.getValue() == value) {
				return depositLevel;
			}
		}
		return null;
	}
}
