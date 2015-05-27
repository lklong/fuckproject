package com.zhigu.model;

import java.util.Date;

public class TaobaoUser {
	private String uid;

	private String alipayBind;

	private Long userId;

	private String avatar;

	private Date birthday;

	private String buyerCredit;

	private String consumerProtection;

	private String email;

	private String isGoldenSeller;

	private String location;

	private String nick;

	private String promotedType;

	private String sex;

	private String status;

	private String type;

	private String vipInfo;

	private String autoRepost;

	private String hasShop;

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid == null ? null : uid.trim();
	}

	public String getAlipayBind() {
		return alipayBind;
	}

	public void setAlipayBind(String alipayBind) {
		this.alipayBind = alipayBind;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getBuyerCredit() {
		return buyerCredit;
	}

	public void setBuyerCredit(String buyerCredit) {
		this.buyerCredit = buyerCredit;
	}

	public String getConsumerProtection() {
		return consumerProtection;
	}

	public void setConsumerProtection(String consumerProtection) {
		this.consumerProtection = consumerProtection;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIsGoldenSeller() {
		return isGoldenSeller;
	}

	public void setIsGoldenSeller(String isGoldenSeller) {
		this.isGoldenSeller = isGoldenSeller;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getPromotedType() {
		return promotedType;
	}

	public void setPromotedType(String promotedType) {
		this.promotedType = promotedType;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getVipInfo() {
		return vipInfo;
	}

	public void setVipInfo(String vipInfo) {
		this.vipInfo = vipInfo;
	}

	public String getAutoRepost() {
		return autoRepost;
	}

	public void setAutoRepost(String autoRepost) {
		this.autoRepost = autoRepost;
	}

	public String getHasShop() {
		return hasShop;
	}

	public void setHasShop(String hasShop) {
		this.hasShop = hasShop;
	}

}