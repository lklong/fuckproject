/**
 * @ClassName: CommentType.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月12日
 * 
 */
package com.zhigu.common.constant.enumconst;

/**
 * @author Administrator
 *
 */
public enum CommentType {

	All("all", 0), Medium("medium", 2), Bad("bad", 3), Good("good", 1);

	private int num;

	private String type;

	private CommentType(String type, int num) {
		this.type = type;
		this.num = num;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
