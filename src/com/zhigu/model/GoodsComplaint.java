package com.zhigu.model;

import java.util.Date;

/**
 * 商品投诉
 * 
 * @author zhouqibing 2014年11月6日上午11:54:05
 */
public class GoodsComplaint {
	// ID
	private int id;
	// 投诉用户ID
	private int userId;
	// 投诉类型
	private int type;
	// 商品ID
	private int goodsId;
	// 投诉内容
	private String content;
	// 状态（1：未处理，2..）
	private int status;
	// 投诉时间
	private Date time;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

}
