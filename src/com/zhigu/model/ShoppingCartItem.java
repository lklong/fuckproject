package com.zhigu.model;

import java.math.BigDecimal;
import java.util.Date;

public class ShoppingCartItem {
	private Integer id;

	private Integer userId;

	private Integer skuId;

	private Integer quantity;

	private Date putTime;

	private Boolean checked;

	private Integer status;

	private BigDecimal subTotal;// 小计
	private Goods goods;
	private GoodsSku goodsSku;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getSkuId() {
		return skuId;
	}

	public void setSkuId(Integer skuId) {
		this.skuId = skuId;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Date getPutTime() {
		return putTime;
	}

	public void setPutTime(Date putTime) {
		this.putTime = putTime;
	}

	public Boolean getChecked() {
		return checked;
	}

	public void setChecked(Boolean checked) {
		this.checked = checked;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public GoodsSku getGoodsSku() {
		return goodsSku;
	}

	public void setGoodsSku(GoodsSku goodsSku) {
		this.goodsSku = goodsSku;
	}

	public BigDecimal getSubTotal() {
		return goodsSku.getPrice().multiply(new BigDecimal(quantity));
	}

}