/**
 * @ClassName: FileType.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月28日
 * 
 */
package com.zhigu.common.constant.enumconst;

/**
 * @author liukailong
 *
 */
public enum FileType {

	File("file"), Image("image");

	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	private FileType(String type) {
		this.type = type;
	}

}
