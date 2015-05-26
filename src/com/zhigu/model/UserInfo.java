package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

import com.zhigu.common.constant.Common;
import com.zhigu.common.constant.SystemConstants;
import com.zhigu.common.utils.StringUtil;

/***********************************************************************
 * Module: UserInfo.java Author: Administrator Purpose: Defines the Class
 * UserInfo
 ***********************************************************************/

public class UserInfo implements Serializable {
	// 用户ID
	private int userID;
	// 账户名
	private String userName;
	// 昵称
	private String nickName;
	// 真实姓名
	private String realName;
	// 性别（1：男，2：女）
	private int gender;
	// 生日
	private Date birthDay;
	// 头像
	private String avatar;
	// 手机号
	private String phone;
	// 电话
	private String tel;
	// 邮箱
	private String email;
	// QQ
	private String QQ;
	// 旺旺
	private String aliWangWang;
	// 省
	private String province;
	// 市
	private String city;
	// 区
	private String district;
	// 地址
	private String street;
	// 邮编
	private String postCode;
	// 实名认证Flg
	private int realUserAuthFlg;
	// 用户等级点
	private int levelPoint;
	// 积分
	private int score;
	// 用户名是否修改（0：否，1：是）
	private int usernameModify = 0;
	// 注册时间
	private Date registerTime;
	// 用户空间大小
	private long userSpaceSize;
	// 用户空间已用大小
	private long userSpaceUseSize;
	// 推荐人ID
	private int recommendUserID;
	// 保证金等级
	private int depositLevel;
	private String genderLabel;
	// 用户类型
	private int userType;

	public String getGenderLabel() {
		if (gender == 1)
			return "男";
		if (gender == 2)
			return "女";
		return Common.BLANK;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public Date getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public Date getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}

	public String getAvatar() {
		if (StringUtil.isEmpty(avatar))
			return SystemConstants.DEFAULT_AVATAR;
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
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

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public int getUsernameModify() {
		return usernameModify;
	}

	public void setUsernameModify(int usernameModify) {
		this.usernameModify = usernameModify;
	}

	public int getLevelPoint() {
		return levelPoint;
	}

	public int getRealUserAuthFlg() {
		return realUserAuthFlg;
	}

	public void setRealUserAuthFlg(int realUserAuthFlg) {
		this.realUserAuthFlg = realUserAuthFlg;
	}

	public void setLevelPoint(int levelPoint) {
		this.levelPoint = levelPoint;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public long getUserSpaceSize() {
		return userSpaceSize;
	}

	public void setUserSpaceSize(long userSpaceSize) {
		this.userSpaceSize = userSpaceSize;
	}

	public long getUserSpaceUseSize() {
		return userSpaceUseSize;
	}

	public void setUserSpaceUseSize(long userSpaceUseSize) {
		this.userSpaceUseSize = userSpaceUseSize;
	}

	public int getRecommendUserID() {
		return recommendUserID;
	}

	public void setRecommendUserID(int recommendUserID) {
		this.recommendUserID = recommendUserID;
	}

	public int getDepositLevel() {
		return depositLevel;
	}

	public void setDepositLevel(int depositLevel) {
		this.depositLevel = depositLevel;
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}

}