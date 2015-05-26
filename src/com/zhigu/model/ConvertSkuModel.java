/**
 * @ClassName: ConvertSkuModel.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月18日
 * 
 */
package com.zhigu.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

/**
 * @author Administrator
 *
 */
public class ConvertSkuModel {

	private Integer platSkuId;

	private Integer quality;

	private BigDecimal price;

	private String propIdStr;

	private List<ConvertModel> models;

	private List<ConvertSkuModel> skus = new ArrayList<ConvertSkuModel>();

	public List<ConvertSkuModel> getSkus() {
		return skus;
	}

	public void setSkus(List<ConvertSkuModel> skus) {
		this.skus = skus;
	}

	public List<ConvertModel> getModels() {
		return models;
	}

	public void setModels(List<ConvertModel> models) {
		this.models = models;
	}

	public String getPropIdStr() {
		return propIdStr;
	}

	public void setPropIdStr(String propIdStr) {
		this.propIdStr = propIdStr;
	}

	public Integer getPlatSkuId() {
		return platSkuId;
	}

	public void setPlatSkuId(Integer platSkuId) {
		this.platSkuId = platSkuId;
	}

	public Integer getQuality() {
		return quality;
	}

	public void setQuality(Integer quality) {
		this.quality = quality;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}

}
