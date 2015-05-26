package com.zhigu.model;

import com.zhigu.common.constant.enumconst.PlatType;

public class PropertyRef {
	private Integer id;

	private Long categoryID;

	private Long categoryPropID;

	private Long thirdCatID;

	private Long thirdCatPropID;

	private Integer thirdPlatType = PlatType.Taobao.getType();

	private Boolean deleteFlag = false;

	private String catPropName;

	private String thirdCatPropName;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Long getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(Long categoryID) {
		this.categoryID = categoryID;
	}

	public Long getCategoryPropID() {
		return categoryPropID;
	}

	public void setCategoryPropID(Long categoryPropID) {
		this.categoryPropID = categoryPropID;
	}

	public Long getThirdCatID() {
		return thirdCatID;
	}

	public void setThirdCatID(Long thirdCatID) {
		this.thirdCatID = thirdCatID;
	}

	public Long getThirdCatPropID() {
		return thirdCatPropID;
	}

	public void setThirdCatPropID(Long thirdCatPropID) {
		this.thirdCatPropID = thirdCatPropID;
	}

	public Integer getThirdPlatType() {
		return thirdPlatType;
	}

	public void setThirdPlatType(Integer thirdPlatType) {
		this.thirdPlatType = thirdPlatType;
	}

	public Boolean getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Boolean deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getCatPropName() {
		return catPropName;
	}

	public void setCatPropName(String catPropName) {
		this.catPropName = catPropName == null ? null : catPropName.trim();
	}

	public String getThirdCatPropName() {
		return thirdCatPropName;
	}

	public void setThirdCatPropName(String thirdCatPropName) {
		this.thirdCatPropName = thirdCatPropName == null ? null : thirdCatPropName.trim();
	}
}