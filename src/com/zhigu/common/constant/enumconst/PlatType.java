/**
 * @ClassName: PlatType.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月14日
 * 
 */
package com.zhigu.common.constant.enumconst;

/**
 * @author Administrator
 *
 */
public enum PlatType {
	
	Taobao(1),Alibaba(2);
	
	private Integer type;
	
	private PlatType(Integer type) {
		
		this.type = type;
		
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	
	

}
