package com.zhigu.model;

import java.math.BigDecimal;
import java.util.Date;

import com.zhigu.common.constant.Common;
import com.zhigu.common.constant.CouponStatus;

/**
 * 优惠卷
 * 
 * @author HeSiMin
 * @date 2014年12月22日
 *
 */
public class Coupon {
	private int id;
	/**
	 * 名字
	 */
	private String name;
	/**
	 * 用户id
	 */
	private int userID;
	/**
	 * 类型
	 */
	private int type;
	/**
	 * 折扣
	 */
	private BigDecimal discount;
	/**
	 * 抵扣金额
	 */
	private BigDecimal offsetMoney;
	/**
	 * 状态
	 */
	private int status;
	private String statusLabel;
	/**
	 * 来源
	 */
	private String source;
	/**
	 * 开始日期
	 */
	private Date addTime;
	/**
	 * 结束日期
	 */
	private Date endTime;
	/**
	 * 版本
	 */
	private int version;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatusLabel() {
		if (this.status == CouponStatus.USEABLE) {
			return "可用";
		} else if (this.status == CouponStatus.USED) {
			return "已用";
		} else if (this.status == CouponStatus.LOSE_EFFICACY) {
			return "失效";
		}
		return Common.BLANK;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public BigDecimal getDiscount() {
		return discount == null ? new BigDecimal(1) : discount;
	}

	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public BigDecimal getOffsetMoney() {
		return offsetMoney == null ? new BigDecimal(0) : offsetMoney;
	}

	public void setOffsetMoney(BigDecimal offsetMoney) {
		this.offsetMoney = offsetMoney;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

}
