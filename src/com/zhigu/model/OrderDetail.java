package com.zhigu.model;

import java.io.Serializable;
import java.math.BigDecimal;

/***********************************************************************
 * Module: OrderDetail.java Author: Administrator Purpose: Defines the Class
 * OrderDetail
 ***********************************************************************/

public class OrderDetail implements Serializable {
	// ID
	private int ID;
	// 订单ID
	private int orderID;
	// 商品ID
	private int goodsID;
	// 商品名称
	private String goodsName;
	// 商品扩展ID
	private int skuID;
	// sku属性字符串
	private String propertystrname;
	// 单价
	private BigDecimal unitPrice;
	private boolean isEvaluate;// 是否评价
	// 数量
	private int quantity;

	private String color;
	private String size;
	private String goodsPic;// 商品图片
	private String introduce;// 商品简介
	private Integer cartID;// 购物车id,只在生成订单时用到一次

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public String getPropertystrname() {
		return propertystrname;
	}

	public void setPropertystrname(String propertystrname) {
		this.propertystrname = propertystrname;
	}

	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public BigDecimal getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public Integer getCartID() {
		return cartID;
	}

	public void setCartID(Integer cartID) {
		this.cartID = cartID;
	}

	public int getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(int goodsID) {
		this.goodsID = goodsID;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public int getSkuID() {
		return skuID;
	}

	public void setSkuID(int skuID) {
		this.skuID = skuID;
	}

	public String getGoodsPic() {
		return goodsPic;
	}

	public void setGoodsPic(String goodsPic) {
		this.goodsPic = goodsPic;
	}

	public boolean isEvaluate() {
		return isEvaluate;
	}

	public void setEvaluate(boolean isEvaluate) {
		this.isEvaluate = isEvaluate;
	}

}