package com.zhigu.model;

import java.io.Serializable;

/***********************************************************************
 * Module: Image.java Author: Administrator Purpose: Defines the Class Image
 ***********************************************************************/

public class Image implements Serializable {
	// ID
	private int ID;
	// 图片类型
	private int type;
	// 关联ID（商品则关联商品ID）
	private int relevanceID;
	// 图片路径
	private String imagePath;

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getRelevanceID() {
		return relevanceID;
	}

	public void setRelevanceID(int relevanceID) {
		this.relevanceID = relevanceID;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

}