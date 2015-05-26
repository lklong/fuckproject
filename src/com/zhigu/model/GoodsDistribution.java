package com.zhigu.model;

import java.util.Date;

/**
 * 分销商品
 */
public class GoodsDistribution {
	private Integer id;

	private Integer userID;

	private Long goodsID;

	private Long thirdGoodsID;

	private String thirdSellerID;

	private String thirdSellerNick;

	private Boolean thirdPlatType;

	private Date createTime;

	private Date updateTime;

	private String platPrice;

	private String commission;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}

	public Long getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(Long goodsID) {
		this.goodsID = goodsID;
	}

	public Long getThirdGoodsID() {
		return thirdGoodsID;
	}

	public void setThirdGoodsID(Long thirdGoodsID) {
		this.thirdGoodsID = thirdGoodsID;
	}

	public String getThirdSellerID() {
		return thirdSellerID;
	}

	public void setThirdSellerID(String thirdSellerID) {
		this.thirdSellerID = thirdSellerID == null ? null : thirdSellerID.trim();
	}

	public String getThirdSellerNick() {
		return thirdSellerNick;
	}

	public void setThirdSellerNick(String thirdSellerNick) {
		this.thirdSellerNick = thirdSellerNick == null ? null : thirdSellerNick.trim();
	}

	public Boolean getThirdPlatType() {
		return thirdPlatType;
	}

	public void setThirdPlatType(Boolean thirdPlatType) {
		this.thirdPlatType = thirdPlatType;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getPlatPrice() {
		return platPrice;
	}

	public void setPlatPrice(String platPrice) {
		this.platPrice = platPrice == null ? null : platPrice.trim();
	}

	public String getCommission() {
		return commission;
	}

	public void setCommission(String commission) {
		this.commission = commission == null ? null : commission.trim();
	}
}