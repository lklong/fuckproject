package com.zhigu.model;

import java.util.List;

/**
 * 属性表
 * 
 * @author zhouqibing 2014年9月28日下午2:18:57
 */
public class Property {

	private int id;
	// 属性名称
	private String name;
	// 是否使用别名
	private boolean isAlias;
	// 是否枚举
	private boolean isNunm;
	// 是否颜色
	private boolean isColor;
	// 是否关键属性
	private boolean isKey;
	// 是否销售属性
	private boolean isSell;
	// 是否搜索
	private boolean isSearch;
	// 是否输入属性
	private boolean isInput;
	// 是否必须属性
	private boolean isRequired;
	// 是否多选属性
	private boolean isMult;
	// 排序
	private int sort;
	// 状态
	private int status;

	private Integer categoryID;

	public Integer getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(Integer categoryID) {
		this.categoryID = categoryID;
	}

	// 属性值
	private List<PropertyValue> values;

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

	public boolean isAlias() {
		return isAlias;
	}

	public void setAlias(boolean isAlias) {
		this.isAlias = isAlias;
	}

	public boolean isNunm() {
		return isNunm;
	}

	public void setNunm(boolean isNunm) {
		this.isNunm = isNunm;
	}

	public boolean isColor() {
		return isColor;
	}

	public void setColor(boolean isColor) {
		this.isColor = isColor;
	}

	public boolean isKey() {
		return isKey;
	}

	public void setKey(boolean isKey) {
		this.isKey = isKey;
	}

	public boolean isSell() {
		return isSell;
	}

	public void setSell(boolean isSell) {
		this.isSell = isSell;
	}

	public boolean isSearch() {
		return isSearch;
	}

	public void setSearch(boolean isSearch) {
		this.isSearch = isSearch;
	}

	public boolean isInput() {
		return isInput;
	}

	public void setInput(boolean isInput) {
		this.isInput = isInput;
	}

	public boolean isRequired() {
		return isRequired;
	}

	public void setRequired(boolean isRequired) {
		this.isRequired = isRequired;
	}

	public boolean isMult() {
		return isMult;
	}

	public void setMult(boolean isMult) {
		this.isMult = isMult;
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

	public List<PropertyValue> getValues() {
		return values;
	}

	public void setValues(List<PropertyValue> values) {
		this.values = values;
	}

}
