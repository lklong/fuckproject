/**
 * @ClassName: ApproveStatus.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月18日
 * 
 */
package com.zhigu.common.constant.enumconst;

/**
 * @author Administrator
 *
 */
public enum ApproveStatus {

	Onsale("onsale"), schdule("schdule"), Instock("instock");

	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	private ApproveStatus(String type) {

		this.type = type;

	}

}
