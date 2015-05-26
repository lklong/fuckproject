package com.zhigu.model;

import java.math.BigDecimal;
import java.util.Date;

import org.apache.ibatis.type.Alias;

/**
 * 会员信息
 * 
 * @author zhouqibing 2014年8月28日下午3:54:55
 */
@Alias("member")
public class MemberInfo {

	private int userID;
	private String username;
	private int status;
	private String realName;
	private Date registerTime;
	private Date latestLoginTime;
	private int loginCount;
	private int buyCount;
	private int downLoadCount;
	private int isSeller;
	private int uploadCount;
	/**
	 * 发布商品数
	 */
	private int pubCount;
	/**
	 * 已卖商品数
	 */
	private int purchaseCount;
	private BigDecimal rechargeMoney;
	/**
	 * 账户金额
	 */
	private BigDecimal accountMoney;
	private int isAllot;
	private Integer staffID;
	private String staffName;
	private String storeName;
	private String phone;
	private String email;
	private int realUserStatus;
	private int companyStatus;
	private int realStoreStatus;
	private int isInnerEmployee;

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public BigDecimal getAccountMoney() {
		return accountMoney;
	}

	public void setAccountMoney(BigDecimal accountMoney) {
		this.accountMoney = accountMoney;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Date getRegisterTime() {
		return registerTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}

	public Date getLatestLoginTime() {
		return latestLoginTime;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
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

	public int getBuyCount() {
		return buyCount;
	}

	public void setBuyCount(int buyCount) {
		this.buyCount = buyCount;
	}

	public int getDownLoadCount() {
		return downLoadCount;
	}

	public void setDownLoadCount(int downLoadCount) {
		this.downLoadCount = downLoadCount;
	}

	public int getIsSeller() {
		return isSeller;
	}

	public void setIsSeller(int isSeller) {
		this.isSeller = isSeller;
	}

	public int getUploadCount() {
		return uploadCount;
	}

	public void setUploadCount(int uploadCount) {
		this.uploadCount = uploadCount;
	}

	public int getPubCount() {
		return pubCount;
	}

	public void setPubCount(int pubCount) {
		this.pubCount = pubCount;
	}

	public int getPurchaseCount() {
		return purchaseCount;
	}

	public void setPurchaseCount(int purchaseCount) {
		this.purchaseCount = purchaseCount;
	}

	public BigDecimal getRechargeMoney() {
		return rechargeMoney;
	}

	public void setRechargeMoney(BigDecimal rechargeMoney) {
		this.rechargeMoney = rechargeMoney;
	}

	public int getIsAllot() {
		return isAllot;
	}

	public void setIsAllot(int isAllot) {
		this.isAllot = isAllot;
	}

	public Integer getStaffID() {
		return staffID;
	}

	public void setStaffID(Integer staffID) {
		this.staffID = staffID;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getStaffName() {
		return staffName;
	}

	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getRealUserStatus() {
		return realUserStatus;
	}

	public void setRealUserStatus(int realUserStatus) {
		this.realUserStatus = realUserStatus;
	}

	public int getCompanyStatus() {
		return companyStatus;
	}

	public void setCompanyStatus(int companyStatus) {
		this.companyStatus = companyStatus;
	}

	public int getRealStoreStatus() {
		return realStoreStatus;
	}

	public void setRealStoreStatus(int realStoreStatus) {
		this.realStoreStatus = realStoreStatus;
	}

	public int getIsInnerEmployee() {
		return isInnerEmployee;
	}

	public void setIsInnerEmployee(int isInnerEmployee) {
		this.isInnerEmployee = isInnerEmployee;
	}

}
