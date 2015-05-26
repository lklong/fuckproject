package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

/***********************************************************************
 * Module: UserAuth.java Author: Administrator Purpose: Defines the Class
 * UserAuth
 ***********************************************************************/

public class UserAuth implements Serializable {
	// ID
	private int userID;
	// 用户名（随机产生，可改一次）
	private String username;
	// 邮箱
	private String email;
	// 手机
	private String phone;
	// 密码
	private String password;
	// 盐值
	private String salt;
	// 状态(0：未激活，1：正常，9：冻结)
	private int status = 0;

	// 注册时间
	private Date registerTime;
	// 上次登录时间
	private Date latestLoginTime;
	// 登录次数
	private int loginCount;
	// 注册ip
	private String registerIP;

	public String getRegisterIP() {
		return registerIP;
	}

	public void setRegisterIP(String registerIP) {
		this.registerIP = registerIP;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}

	public Date getLatestLoginTime() {
		return latestLoginTime;
	}

	public void setLatestLoginTime(Date latestLoginTime) {
		this.latestLoginTime = latestLoginTime;
	}

	public int getLoginCount() {
		return loginCount;
	}

	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}
}