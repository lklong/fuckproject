package com.zhigu.model;

/**
 * 商品属性
 * 
 * @author zhouqibing 2014年9月28日下午2:24:50
 */
public class GoodsProperty {
	private int id;
	// 商品Id
	private int goodsId;
	// 属性名Id
	private int propertyId;
	// 属性名称
	private String propertyName;
	// 属性值Id
	private int propertyValueId;
	// 属性值名称
	private String propertyValueName;
	// 是否sku
	private boolean isSku;
	// skuid
	private int skuId;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}

	public int getPropertyId() {
		return propertyId;
	}

	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}

	public String getPropertyName() {
		return propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	public int getPropertyValueId() {
		return propertyValueId;
	}

	public void setPropertyValueId(int propertyValueId) {
		this.propertyValueId = propertyValueId;
	}

	public String getPropertyValueName() {
		return propertyValueName;
	}

	public void setPropertyValueName(String propertyValueName) {
		this.propertyValueName = propertyValueName;
	}

	public boolean isSku() {
		return isSku;
	}

	public void setSku(boolean isSku) {
		this.isSku = isSku;
	}

	public int getSkuId() {
		return skuId;
	}

	public void setSkuId(int skuId) {
		this.skuId = skuId;
	}

}
