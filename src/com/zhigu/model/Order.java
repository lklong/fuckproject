package com.zhigu.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.zhigu.common.constant.enumconst.OrderStatus;

/***********************************************************************
 * Module: Orders.java Author: Administrator Purpose: Defines the Class Orders
 ***********************************************************************/

public class Order implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/** ID */
	private int ID;
	/** 订单号 */
	private String orderNO;
	/** 商品费用 */
	private BigDecimal money = new BigDecimal(0);
	/** 订单状态 */
	private int status;
	/** 订单类型 */
	private int type;
	/** 是否删除 */
	private boolean deleteFlag;
	/** 用户ID */
	private int userID;
	/** 代发商 */
	private int agentSellerID;
	/** 代发费用 */
	private BigDecimal agentMoney = new BigDecimal(0);
	/** 应付金额 */
	private BigDecimal payableMenoy;
	/** 实付金额 */
	private BigDecimal actuallyPayMenyoy;
	/** 物流(配送方式，EMS、邮政...) */
	private int logistics;
	/** 物流费用 */
	private BigDecimal logisticsMoney = new BigDecimal(0);
	/** 物流号 */
	private String logisticsNO;
	/** 物流进展 */
	private String logisticsProgress;
	/** 店铺（商家） */
	private int storeID;
	/** 留言 */
	private String leavelMessage;
	/** 收货人 */
	private String consignee;
	/** 收货人电话 */
	private String phone;
	/** 邮编 */
	private String postCode;
	/** 收货地址 */
	private String address;
	/** 下单时间 */
	private Date orderTime;
	/** 订单完成时间 */
	private Date finishTime;
	/** 订单备注 */
	private String comment;
	private int version;
	/** 订单详情 */
	private List<OrderDetail> details = new ArrayList<OrderDetail>();

	private BigDecimal orderWeight;
	private String storeName; // 店铺名
	private String aliWangWang;// 旺旺
	private String QQ;// QQ
	private int storeUserID;// 店铺用户ID
	private String statusLabel;// 状态标签
	private int styleNum;// 款式数量，一个商品算一款
	private int quantity;// 商品数量，一个扩展算一个
	private String username;// 购买都帐号（应该是昵称）
	private int supplierType;

	private String LogisticsName;// 物流名称
	private String LogisticsCode;// 物流名称

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public String getOrderNO() {
		return orderNO;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getAgentSellerID() {
		return agentSellerID;
	}

	public void setAgentSellerID(int agentSellerID) {
		this.agentSellerID = agentSellerID;
	}

	public int getLogistics() {
		return logistics;
	}

	public void setLogistics(int logistics) {
		this.logistics = logistics;
	}

	public String getLogisticsNO() {
		return logisticsNO;
	}

	public void setLogisticsNO(String logisticsNO) {
		this.logisticsNO = logisticsNO;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public BigDecimal getAgentMoney() {
		return agentMoney;
	}

	public void setAgentMoney(BigDecimal agentMoney) {
		this.agentMoney = agentMoney;
	}

	public int getStoreID() {
		return storeID;
	}

	public void setStoreID(int storeID) {
		this.storeID = storeID;
	}

	public String getLeavelMessage() {
		return leavelMessage;
	}

	public void setLeavelMessage(String leavelMessage) {
		this.leavelMessage = leavelMessage;
	}

	public String getConsignee() {
		return consignee;
	}

	public void setConsignee(String consignee) {
		this.consignee = consignee;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public List<OrderDetail> getDetails() {
		return details;
	}

	public void setDetails(List<OrderDetail> details) {
		this.details = details;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getAliWangWang() {
		return aliWangWang;
	}

	public void setAliWangWang(String aliWangWang) {
		this.aliWangWang = aliWangWang;
	}

	public String getQQ() {
		return QQ;
	}

	public void setQQ(String qQ) {
		QQ = qQ;
	}

	public String getStatusLabel() {
		return OrderStatus.getNameByValue(status);
	}

	public void setStatusLabel(String statusLabel) {
		this.statusLabel = statusLabel;
	}

	public BigDecimal getLogisticsMoney() {
		return logisticsMoney;
	}

	public void setLogisticsMoney(BigDecimal logisticsMoney) {
		this.logisticsMoney = logisticsMoney;
	}

	public int getStoreUserID() {
		return storeUserID;
	}

	public void setStoreUserID(int storeUserID) {
		this.storeUserID = storeUserID;
	}

	public int getStyleNum() {
		Set<Integer> style = new HashSet<Integer>();
		for (OrderDetail od : details)
			style.add(od.getGoodsID());
		return style.size();
	}

	public int getQuantity() {
		quantity = 0;// 先归0，不然调用多次会有问题
		for (OrderDetail od : details)
			quantity += od.getQuantity();
		return quantity;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getLogisticsProgress() {
		return logisticsProgress;
	}

	public void setLogisticsProgress(String logisticsProgress) {
		this.logisticsProgress = logisticsProgress;
	}

	public Date getFinishTime() {
		return finishTime;
	}

	public void setFinishTime(Date finishTime) {
		this.finishTime = finishTime;
	}

	public String getLogisticsName() {
		return LogisticsName;
	}

	public void setLogisticsName(String logisticsName) {
		LogisticsName = logisticsName;
	}

	public String getLogisticsCode() {
		return LogisticsCode;
	}

	public void setLogisticsCode(String logisticsCode) {
		LogisticsCode = logisticsCode;
	}

	public int getSupplierType() {
		return supplierType;
	}

	public void setSupplierType(int supplierType) {
		this.supplierType = supplierType;
	}

	public void setStyleNum(int styleNum) {
		this.styleNum = styleNum;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getPayableMenoy() {
		return payableMenoy;
	}

	public void setPayableMenoy(BigDecimal payableMenoy) {
		this.payableMenoy = payableMenoy;
	}

	public BigDecimal getActuallyPayMenyoy() {
		return actuallyPayMenyoy;
	}

	public void setActuallyPayMenyoy(BigDecimal actuallyPayMenyoy) {
		this.actuallyPayMenyoy = actuallyPayMenyoy;
	}

	public BigDecimal getOrderWeight() {
		return orderWeight;
	}

	public void setOrderWeight(BigDecimal orderWeight) {
		this.orderWeight = orderWeight;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public boolean isDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(boolean deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

}