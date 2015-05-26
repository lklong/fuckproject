package com.zhigu.model;

import java.util.Date;

/**
 * 商品图片
 * 
 * @author zhouqibing 2014年9月28日下午2:32:21
 */
public class GoodsImage {
	private int id;
	// 商品Id
	private int goodsId;
	// 图片
	private String image;
	// 图片300
	private String image300;
	// 是否是主图
	private boolean isMain;
	// 位置
	private int position;
	// 时间
	private Date time;

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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getImage300() {
		return image300;
	}

	public void setImage300(String image300) {
		this.image300 = image300;
	}

	public boolean isMain() {
		return isMain;
	}

	public void setMain(boolean isMain) {
		this.isMain = isMain;
	}

	public int getPosition() {
		return position;
	}

	public void setPosition(int position) {
		this.position = position;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

}
