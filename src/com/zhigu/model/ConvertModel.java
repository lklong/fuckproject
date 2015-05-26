/**
 * 
 */
package com.zhigu.model;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

/**
 * @author Administrator
 *
 */
public class ConvertModel {

	private Long catId;

	private String catName;

	private Long propId;

	private String propName;

	private Long valueId;

	private String valueName;

	private Boolean isEnumProp;

	private Boolean isKeyProp;

	private Boolean isColorProp;

	private Boolean isSaleProp;

	private Boolean isInputProp;

	private Boolean isItemProp;

	// 发布产品或商品时是否可以多选。可选值:true(是),false(否)
	private Boolean isMulti;

	// 属性值类型。可选值： multiCheck(枚举多选) optional(枚举单选) multiCheckText(枚举可输入多选)
	// optionalText(枚举可输入单选) text(非枚举可输入)
	private String type;

	public Boolean getIsMulti() {
		return isMulti;
	}

	public void setIsMulti(Boolean isMulti) {
		this.isMulti = isMulti;
	}

	public Boolean getIsInputProp() {
		return isInputProp;
	}

	public void setIsInputProp(Boolean isInputProp) {
		this.isInputProp = isInputProp;
	}

	public Boolean getIsItemProp() {
		return isItemProp;
	}

	public void setIsItemProp(Boolean isItemProp) {
		this.isItemProp = isItemProp;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Boolean getIsSaleProp() {
		return isSaleProp;
	}

	public void setIsSaleProp(Boolean isSaleProp) {
		this.isSaleProp = isSaleProp;
	}

	public Boolean getIsEnumProp() {
		return isEnumProp;
	}

	public void setIsEnumProp(Boolean isEnumProp) {
		this.isEnumProp = isEnumProp;
	}

	public Boolean getIsKeyProp() {
		return isKeyProp;
	}

	public void setIsKeyProp(Boolean isKeyProp) {
		this.isKeyProp = isKeyProp;
	}

	public Boolean getIsColorProp() {
		return isColorProp;
	}

	public void setIsColorProp(Boolean isColorProp) {
		this.isColorProp = isColorProp;
	}

	public Long getCatId() {
		return catId;
	}

	public void setCatId(Long catId) {
		this.catId = catId;
	}

	public String getCatName() {
		return catName;
	}

	public void setCatName(String catName) {
		this.catName = catName;
	}

	public Long getPropId() {
		return propId;
	}

	public void setPropId(Long propId) {
		this.propId = propId;
	}

	public String getPropName() {
		return propName;
	}

	public void setPropName(String propName) {
		this.propName = propName;
	}

	public Long getValueId() {
		return valueId;
	}

	public void setValueId(Long valueId) {
		this.valueId = valueId;
	}

	public String getValueName() {
		return valueName;
	}

	public void setValueName(String valueName) {
		this.valueName = valueName;
	}

	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}

}
