package com.zhigu.model;

import com.zhigu.common.constant.enumconst.PlatType;

public class ValueRef {

	private Integer id;

	private Long propRefID;

	private Long propVID;

	private Long thirdPropVID;

	private Integer thirdPlatType = PlatType.Taobao.getType();

	private Boolean deleteFlag = false;

	private String valueName;

	private String thirdValueName;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Long getPropRefID() {
		return propRefID;
	}

	public void setPropRefID(Long propRefID) {
		this.propRefID = propRefID;
	}

	public Long getPropVID() {
		return propVID;
	}

	public void setPropVID(Long propVID) {
		this.propVID = propVID;
	}

	public Long getThirdPropVID() {
		return thirdPropVID;
	}

	public void setThirdPropVID(Long thirdPropVID) {
		this.thirdPropVID = thirdPropVID;
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

	public String getValueName() {
		return valueName;
	}

	public void setValueName(String valueName) {
		this.valueName = valueName == null ? null : valueName.trim();
	}

	public String getThirdValueName() {
		return thirdValueName;
	}

	public void setThirdValueName(String thirdValueName) {
		this.thirdValueName = thirdValueName == null ? null : thirdValueName.trim();
	}

}