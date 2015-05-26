package com.zhigu.model;

import java.util.List;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

/**
 * 类目
 * 
 * @author zhouqibing 2014年9月28日下午2:14:35
 */
public class Category {
	private int id;
	// 名称
	private String name;
	// 父Id
	private int parentId;
	// 是否是父节点
	private Boolean isParent;
	// 排序
	private int sort;
	// code
	private String code;

	// 属性集合
	public List<Property> properties;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public Boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public List<Property> getProperties() {
		return properties;
	}

	public void setProperties(List<Property> properties) {
		this.properties = properties;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}

}
