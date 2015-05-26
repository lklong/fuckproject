package com.zhigu.common.constant.enumconst;

/**
 * 保证金等级
 * 
 * @author HeSiMin
 * @date 2014年10月15日
 *
 */
public enum DepositLevel {
	NORMAL("初级", 1, 2000), MIDDLE("中级", 2, 5000), HIGH("高级", 3, 10000), ;
	private String name;
	private int value;
	private int money;

	private DepositLevel(String name, int value, int money) {
		this.name = name;
		this.value = value;
		this.money = money;
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

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	public static String getNameByValue(int value) {
		DepositLevel[] depositLevels = DepositLevel.values();
		for (DepositLevel depositLevel : depositLevels) {
			if (depositLevel.getValue() == value) {
				return depositLevel.getName();
			}
		}
		return "";
	}

	public static int getMoneyByValue(int value) {
		DepositLevel[] depositLevels = DepositLevel.values();
		for (DepositLevel depositLevel : depositLevels) {
			if (depositLevel.getValue() == value) {
				return depositLevel.getMoney();
			}
		}
		return 0;
	}

	public static DepositLevel getDepositLevelByValue(int value) {
		if (value < 1) {
			return null;
		}
		DepositLevel[] depositLevels = DepositLevel.values();
		for (DepositLevel depositLevel : depositLevels) {
			if (depositLevel.getValue() == value) {
				return depositLevel;
			}
		}
		return null;
	}
}
