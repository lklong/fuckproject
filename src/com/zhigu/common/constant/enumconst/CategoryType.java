package com.zhigu.common.constant.enumconst;

import com.zhigu.common.constant.StoreType;

/**
 * 类目类型（和数据库一致id）
 * 
 * @author HeSiMin
 * @date 2014年10月17日
 *
 */
public enum CategoryType {
	STORE_DECORATE("店铺装修", 1), PHOTOGRAPH("摄影服务", 2), WOMEN_SHOES("女鞋", 3), MEN_SHOES("男鞋", 4), WOMAN_DRESS("女装", 19), MAN_DRESS("男装", 20), CHILDREN_SHOES("童鞋", 178), CHILDREN_DRESS("童装", 107), SHOES(
			"鞋子", 101), DRESS("服装", 102), MAN_SHOES("男鞋", 4), WOMAN_SHOES("女鞋", 3), ;
	// BEAUTY("美妆", 74),FOOD("美食", 103), ;
	private String name;
	private int value;// id

	private CategoryType(String name, int value) {
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

	public static CategoryType delgetCategoryTypeByStoreType(int storeType) {
		if (storeType == StoreType.SERVICE_DECORATE) {
			return CategoryType.STORE_DECORATE;
		} else if (storeType == StoreType.SERVICE_PHOTOGRAPH) {
			return CategoryType.PHOTOGRAPH;
		}
		return null;
	}

	public static CategoryType getCategoryTypeByValue(int value) {
		for (CategoryType c : CategoryType.values()) {
			if (c.getValue() == value) {
				return c;
			}
		}
		return null;
	}
}
