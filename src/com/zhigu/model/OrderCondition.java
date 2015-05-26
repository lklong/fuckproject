package com.zhigu.model;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 订单条件查询
 * 
 * @author zhouqibing 2014年8月6日下午6:57:14
 */
public class OrderCondition {

	private Integer userID;
	private Integer userType;
	private Integer status;// 交易状态
	private String orderNO;// 订单号
	private String goodsName;// 商品名称
	private String storeName;// 店铺名称
	private String username;// 买家名称
	private Date startDate;// 开始日期
	private Date endDate;// 结束日期
	private List<Integer> ids;
	private Integer staffID;

	public OrderCondition() {
	}

	public OrderCondition(int userID, int userType, String orderNO, String goodsName, String storeName, int status, Date startDate, Date endDate) {
		super();
		this.userID = userID;
		this.userType = userType;
		this.orderNO = orderNO;
		this.goodsName = goodsName;
		this.storeName = storeName;
		this.status = status;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getOrderNO() {
		return orderNO;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		if (endDate != null) {
			Calendar c = Calendar.getInstance();
			c.setTimeInMillis(endDate.getTime());
			c.set(Calendar.HOUR, 23);
			c.set(Calendar.MINUTE, 59);
			c.set(Calendar.SECOND, 59);
			return c.getTime();
		}
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public List<Integer> getIds() {
		return ids;
	}

	public void setIds(List<Integer> ids) {
		this.ids = ids;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Integer getStaffID() {
		return staffID;
	}

	public void setStaffID(Integer staffID) {
		this.staffID = staffID;
	}

}
