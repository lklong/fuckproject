package com.zhigu.model;

import java.io.Serializable;

/***********************************************************************
 * Module: ShippingAddress.java Author: Administrator Purpose: Defines the Class
 * ShippingAddress
 ***********************************************************************/

public class Address implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6627778418796643267L;
	// ID
	private int ID;
	// 用户ID
	private int userID;
	// 收货人姓名
	private String name;
	// 联系手机
	private String phone;
	// 电话
	private String tel;
	// 省
	private String province;
	// 市
	private String city;
	// 区
	private String district;
	// 街道（详细地址）
	private String street;
	// 邮编
	private String postcode;
	// 是否默认地址(1：是，0：否)
	private int isDefault;
	// 是否删除(0:删除,1非删除)
	private int Status;

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public int getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(int isDefault) {
		this.isDefault = isDefault;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public int getStatus() {
		return Status;
	}

	public void setStatus(int status) {
		Status = status;
	}

}