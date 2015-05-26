package com.zhigu.model;

import java.util.Date;

/**
 * 商品评价
 * 
 * @ClassName: GoodsEvaluate
 * @author hesimin
 * @date 2015年5月8日 上午9:37:27
 *
 */
public class GoodsEvaluate {
	private Long id;

	private Integer userId;

	private Integer goodsId;

	private Integer skuId;

	private Integer score;

	private String buySpec;

	private String content;

	private Date addTime;

	private String userName;

	private String avatar;

	private String merchantReply;

	private Date replyTime;

	/** 非数据库字段，只用作评论查询统计 */
	private Integer type;

	public Date getReplyTime() {
		return replyTime;
	}

	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}

	public String getMerchantReply() {
		return merchantReply;
	}

	public void setMerchantReply(String merchantReply) {
		this.merchantReply = merchantReply;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public Integer getSkuId() {
		return skuId;
	}

	public void setSkuId(Integer skuId) {
		this.skuId = skuId;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public String getBuySpec() {
		return buySpec;
	}

	public void setBuySpec(String buySpec) {
		this.buySpec = buySpec == null ? null : buySpec.trim();
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content == null ? null : content.trim();
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

}