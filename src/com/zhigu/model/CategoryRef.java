package com.zhigu.model;

import com.zhigu.common.constant.enumconst.PlatType;

public class CategoryRef {
	private Integer id;

	private Long categoryID;

	private String categoryName;

	private Long thirdCatID;

	private String thirdCatName;

	private Integer thirdPlatType = PlatType.Taobao.getType();

	private Boolean deleteFlag = false;

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

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName == null ? null : categoryName.trim();
	}

	public Long getThirdCatID() {
		return thirdCatID;
	}

	public void setThirdCatID(Long thirdCatID) {
		this.thirdCatID = thirdCatID;
	}

	public String getThirdCatName() {
		return thirdCatName;
	}

	public void setThirdCatName(String thirdCatName) {
		this.thirdCatName = thirdCatName == null ? null : thirdCatName.trim();
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
}