package com.zhigu.common.constant.enumconst;

/**
 * 用户空间文件类型
 * 
 * @author HeSiMin
 * @date 2014年9月24日
 *
 */
public enum UserFileType {
	IMAGE(1), RAR(2), ;
	private int value;

	private UserFileType(int value) {
		this.value = value;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}
}
