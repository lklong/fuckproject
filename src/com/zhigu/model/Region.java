package com.zhigu.model;

import java.io.Serializable;

/***********************************************************************
 * Module: Region.java Author: Administrator Purpose: Defines the Class Region
 ***********************************************************************/

public class Region implements Serializable {
	// ID
	private int ID;
	// 父ID（省为0）
	private int PID;
	// 名称
	private String name;
	// 类型（1：省，2：市，3：区）
	private int type;
	// 排序
	private int sort;

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getPID() {
		return PID;
	}

	public void setPID(int pID) {
		PID = pID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

}