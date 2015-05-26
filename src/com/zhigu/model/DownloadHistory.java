package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 下载历史
 * 
 * @author HeSiMin
 * @date 2014年8月7日
 *
 */
public class DownloadHistory implements Serializable {
	/** ID */
	private int ID;
	/** 用户ID */
	private int userID;
	/** 商品ID */
	private int goodsID;
	/** 图片路径 */
	private String imagePath;
	/** 商品名 */
	private String goodsName;
	/** 店铺ID */
	private int storeID;
	/** 店铺名 */
	private String storeName;
	/** 下载时间 */
	private Date downloadTime;
	/** 最低价 */
	private double minPrice;
	/** 最高价 */
	private double maxPrice;
	/** 联系QQ */
	private String QQ;
	/** 联系旺旺 */
	private String aliWangWang;

	private String userName;
	private int status;

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(int goodsID) {
		this.goodsID = goodsID;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
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

	public Date getDownloadTime() {
		return downloadTime;
	}

	public void setDownloadTime(Date downloadTime) {
		this.downloadTime = downloadTime;
	}

	public double getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(double minPrice) {
		this.minPrice = minPrice;
	}

	public double getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(double maxPrice) {
		this.maxPrice = maxPrice;
	}

	public String getQQ() {
		return QQ;
	}

	public void setQQ(String qQ) {
		QQ = qQ;
	}

	public String getAliWangWang() {
		return aliWangWang;
	}

	public void setAliWangWang(String aliWangWang) {
		this.aliWangWang = aliWangWang;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
