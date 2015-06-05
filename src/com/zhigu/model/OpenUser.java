package com.zhigu.model;

import java.util.Date;

/**
 * 第三方用户
 * 
 * @ClassName: OpenUser
 * @author hesimin
 * @date 2015年6月4日 上午10:31:54
 *
 */
public class OpenUser {
	private Integer id;

	private String openId;

	private String openUser;

	private Integer openType;

	private Integer userId;

	private Date addTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId == null ? null : openId.trim();
	}

	public String getOpenUser() {
		return openUser;
	}

	public void setOpenUser(String openUser) {
		this.openUser = openUser == null ? null : openUser.trim();
	}

	public Integer getOpenType() {
		return openType;
	}

	public void setOpenType(Integer openType) {
		this.openType = openType;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
}