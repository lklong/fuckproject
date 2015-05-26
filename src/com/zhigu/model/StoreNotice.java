package com.zhigu.model;

import java.util.Date;

/**
 * 店铺公告
 * 
 * @author zhouqibing 2014年10月31日下午1:55:22
 */
public class StoreNotice {
	/**
	 * ID
	 */
	private int ID;
	/**
	 * 店铺ID
	 */
	private int storeID;
	/**
	 * 店铺名称
	 */
	private String storeName;

	/**
	 * 类型
	 */
	private int type;
	/**
	 * 内容
	 */
	private String content;
	/**
	 * 公告时间
	 */
	private Date createTime;

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getStoreID() {
		return storeID;
	}

	public void setStoreID(int storeID) {
		this.storeID = storeID;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

}
