/**
 * @ClassName: AreaLevel.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年6月9日
 * 
 */
package com.zhigu.common.constant.enumconst;

/**
 * @author Administrator
 *
 */
public enum AreaLevel {

	Country(1, "国家"), Province(2, "省份"), City(3, "城市");

	private Integer level;

	private String state;

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	private AreaLevel(Integer level, String state) {
		this.level = level;
		this.state = state;
	}

}
