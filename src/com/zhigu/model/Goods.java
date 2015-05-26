package com.zhigu.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 商品
 * 
 * @author zhouqibing 2014年9月28日下午2:09:04
 */
public class Goods implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	// 店铺Id
	private int storeId;
	// 商品名称
	private String name;
	// 类别Id
	private int categoryId;
	// 最低价
	private BigDecimal minPrice;
	// 最高价
	private BigDecimal maxPrice;
	// 货号
	private String itemNo;
	// 重量
	private float weight;
	// 图片300
	private String image300;
	// 数据包
	private String file;
	// 简介
	private String intro;
	// 详情描述
	private String description;
	// 状态
	private int status;
	// 时间
	private Date time;
	// 刷新时间
	private Date refreshDate;
	/** 删除标示 */
	private boolean deleteFlag;

	// 附属信息
	private GoodsAux aux;
	// 商品图片
	private List<GoodsImage> images;
	// 商品属性
	private List<GoodsProperty> properties;
	// Sku
	private List<GoodsSku> skus;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public BigDecimal getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(BigDecimal minPrice) {
		this.minPrice = minPrice;
	}

	public BigDecimal getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(BigDecimal maxPrice) {
		this.maxPrice = maxPrice;
	}

	public String getItemNo() {
		return itemNo;
	}

	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}

	public float getWeight() {
		return weight;
	}

	public void setWeight(float weight) {
		this.weight = weight;
	}

	public String getImage300() {
		return image300;
	}

	public void setImage300(String image300) {
		this.image300 = image300;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public GoodsAux getAux() {
		return aux;
	}

	public void setAux(GoodsAux aux) {
		this.aux = aux;
	}

	public List<GoodsImage> getImages() {
		return images;
	}

	public void setImages(List<GoodsImage> images) {
		this.images = images;
	}

	public List<GoodsProperty> getProperties() {
		return properties;
	}

	public void setProperties(List<GoodsProperty> properties) {
		this.properties = properties;
	}

	public List<GoodsSku> getSkus() {
		return skus;
	}

	public void setSkus(List<GoodsSku> skus) {
		this.skus = skus;
	}

	public Date getRefreshDate() {
		return refreshDate;
	}

	public void setRefreshDate(Date refreshDate) {
		this.refreshDate = refreshDate;
	}

	public boolean isDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(boolean deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

}
