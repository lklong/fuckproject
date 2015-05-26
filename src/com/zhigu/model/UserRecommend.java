package com.zhigu.model;

import java.util.Date;

/**
 * 用户填写的推荐人
 * 
 * @author HeSiMin
 * @date 2014年11月12日
 *
 */
public class UserRecommend {
	private int id;
	/**
	 * 推荐人id
	 */
	private int userId;
	/**
	 * 被推荐人姓名
	 */
	private String recommendName;
	/**
	 * 被推荐人电话
	 */
	private String recommendPhone;
	/**
	 * 添加时间
	 */
	private Date addTime;
	/**
	 * 是否注册
	 */
	private int isRegister;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getRecommendPhone() {
		return recommendPhone;
	}

	public void setRecommendPhone(String recommendPhone) {
		this.recommendPhone = recommendPhone;
	}

	public String getRecommendName() {
		return recommendName;
	}

	public void setRecommendName(String recommendName) {
		this.recommendName = recommendName;
	}

	public int getIsRegister() {
		return isRegister;
	}

	public void setIsRegister(int isRegister) {
		this.isRegister = isRegister;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

}
