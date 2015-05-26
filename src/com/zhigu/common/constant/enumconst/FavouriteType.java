package com.zhigu.common.constant.enumconst;

/**
 * 收藏类型
 * 
 * @author HeSiMin
 * @date 2014年8月16日
 *
 */
public enum FavouriteType {
	STORE(1), GOODS(2), BOUGHT_STORE(3), ;
	private int value;

	private FavouriteType(int value) {
		this.value = value;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

}
