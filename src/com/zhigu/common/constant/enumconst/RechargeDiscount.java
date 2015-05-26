package com.zhigu.common.constant.enumconst;

/**
 * 充值折扣（已不用，数据在DB里）
 * 
 * @author HeSiMin
 * @date 2014年11月7日
 *
 */
public enum RechargeDiscount {
	MONEY_1000(1000, 0.95f, "9.5折优惠券（限智谷印象摄影/智谷网络服务/清溪茗香茶店铺有效）"), MONEY_2000(2000, 0.9f, "9折优惠券（限智谷印象摄影/智谷网络服务/清溪茗香茶店铺有效）"), MONEY_5000(5000, 0.85f, "8.5折优惠券（限智谷印象摄影/智谷网络服务/清溪茗香茶店铺有效）"), MONEY_10000(
			10000, 0.8f, "8折优惠券（限智谷印象摄影/智谷网络服务/清溪茗香茶店铺有效）"), MONEY_20000(20000, 0.75f, "7.5折优惠券（限智谷印象摄影/智谷网络服务/清溪茗香茶店铺有效）"), ;

	/**
	 * 折扣需要的充值金额
	 */
	private int money;
	/**
	 * 折扣
	 */
	private float discount;
	private String name;

	private RechargeDiscount(int money, float discount, String name) {
		this.money = money;
		this.discount = discount;
		this.name = name;
	}

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	public float getDiscount() {
		return discount;
	}

	public void setDiscount(float discount) {
		this.discount = discount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public static RechargeDiscount getRechargeDiscountByMoney(int money) {
		if (money >= 20000) {
			return RechargeDiscount.MONEY_20000;
		} else if (money >= 10000) {
			return RechargeDiscount.MONEY_10000;
		} else if (money >= 5000) {
			return RechargeDiscount.MONEY_5000;
		} else if (money >= 2000) {
			return RechargeDiscount.MONEY_2000;
		} else if (money >= 1000) {
			return RechargeDiscount.MONEY_1000;
		}
		return null;
	}

	public static RechargeDiscount getRechargeDiscountByDiscount(float discount) {
		for (RechargeDiscount rd : RechargeDiscount.values()) {
			if (rd.getDiscount() == discount) {
				return rd;
			}
		}
		return null;
	}
}
