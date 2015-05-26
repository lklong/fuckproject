package com.zhigu.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 商品Sku
 * 
 * @author zhouqibing 2014年9月28日下午2:28:35
 */
public class GoodsSku {
	private int id;
	// 商品Id
	private int goodsId;
	// 数量
	private int amount;
	// 价格
	private BigDecimal price;
	// skustr
	private String propertyStr;
	// eg 颜色：红色 尺码：23
	private String propertyStrName;
	// 状态
	private int status;
	// 时间
	private Date time;
	private int version;
	private String skuproStr;
	private List<GoodsProperty> skupros;

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

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getPropertyStr() {
		return propertyStr;
	}

	public void setPropertyStr(String propertyStr) {
		this.propertyStr = propertyStr;
	}

	public String getPropertyStrName() {
		return propertyStrName;
	}

	public void setPropertyStrName(String propertyStrName) {
		this.propertyStrName = propertyStrName;
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

	public String getSkuproStr() {
		return skuproStr;
	}

	public void setSkuproStr(String skuproStr) {
		this.skuproStr = skuproStr;
	}

	public List<GoodsProperty> getSkupros() {
		return skupros;
	}

	public void setSkupros(List<GoodsProperty> skupros) {
		this.skupros = skupros;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

}
