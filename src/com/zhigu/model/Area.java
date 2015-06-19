package com.zhigu.model;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;

public class Area {

	/** 地区id */
	private String id;

	/** 地区民称 */
	private String name;

	/** 地区父级id */
	private String parentId;

	/** 地区等级 */
	private Integer level;

	/** 地区状态 */
	private Boolean status;

	/** 是否父级 */
	private Boolean isParent;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public Boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}

	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}
}