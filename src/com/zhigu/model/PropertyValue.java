package com.zhigu.model;

/**
 * 属性值
 * 
 * @author zhouqibing 2014年9月28日下午2:22:31
 */
public class PropertyValue {
	private int id;
	// 属性Id
	private int propertyId;
	// 属性值名称
	private String name;
	// 排序
	private int sort;
	// 状态
	private int status;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPropertyId() {
		return propertyId;
	}

	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
