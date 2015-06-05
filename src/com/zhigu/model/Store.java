package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.zhigu.common.constant.BusinessArea;

public class Store implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/** ID */
	private int ID;
	/** 用户ID */
	private int userID;
	/** 网站域名 */
	private String domain;
	/** 商店名称 */
	private String storeName;
	/** 省 */
	private String province;
	/** 市 */
	private String city;
	/** 区 */
	private String district;
	/** 街道（详细地址） */
	private String street;
	/** 所在商圈 */
	private Integer businessArea;
	/** 联系人姓名 */
	private String contactName;
	/** 手机号码 */
	private String phone;
	/** 联系QQ */
	private String QQ;
	/** 联系旺旺 */
	private String aliWangWang;
	/** 店铺名可用修改次数 */
	private int storeNameModify;
	/** 域名可用修改次数 */
	private int domainModify;
	/** 等级点数（转换等级） */
	private int levelPoint;
	/** 积分（按卖出商品价格计算，非4舍5入，取整数，舍去小数部分 */
	private int score;
	/** Logo */
	private String logoPath;
	/** 招牌 */
	private String signagePath;
	/** 诚信认证 */
	private int integrityAuth;
	/** 企业认证 1:认证通过 2.认证不通过 3:待认证 */
	private int companyAuth;
	/** 实体认证 */
	private int realStoreAuth;
	/** 简介 */
	private String introduction;
	/** 开店时间 */
	private Date openStoreDate;
	/** 正式会员Flg */
	private int fullMemberFlg;
	/** 申请时间 */
	private Date applyTime;
	/** 状态(创建时) 0:非会员 1:会员 */
	private int applyType;
	/** 审核状态 */
	private Integer approveState;
	/** 审核后拒绝的理由 */
	private String rejectReason;
	/** 供应商类型 */
	private int supplierType;
	/** 刷新时间 **/
	private Date refreshDate;

	/** 店铺商品 */
	private List<Goods> goods;
	/** 是否被收藏 */
	private int isFavourite;
	/** 已发布商品（总数） */
	private int commodityTotal;
	/** 在售商品数 */
	private int commodityOnSaleTotal;
	/** 上月发布商品总数 */
	private int commodityPrecedingMonthTotal;
	/** 本月发布商品总数 */
	private int commodityThisMonthTotal;
	/** 累计下载量 */
	private int downloadTotal;
	/** 累计销量 */
	private int purchaseTotal;
	/** 新上架销售 1个月内 */
	private int newPurchaseTotal;

	private String businessAreaLabel;
	/** 作为临时查询使用 非数据库字段 实名认证标示 */
	private Integer realUserAuth;

	public String getBusinessAreaLabel() {
		return BusinessArea.getNameByValue(businessArea);
	}

	public int getID() {
		return ID;
	}

	public void setID(int ID) {
		this.ID = ID;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	public int getSupplierType() {
		return supplierType;
	}

	public void setSupplierType(int supplierType) {
		this.supplierType = supplierType;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
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

	public Integer getBusinessArea() {
		return businessArea;
	}

	public void setBusinessArea(Integer businessArea) {
		this.businessArea = businessArea;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
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

	public int getStoreNameModify() {
		return storeNameModify;
	}

	public void setStoreNameModify(int storeNameModify) {
		this.storeNameModify = storeNameModify;
	}

	public int getDomainModify() {
		return domainModify;
	}

	public void setDomainModify(int domainModify) {
		this.domainModify = domainModify;
	}

	public int getLevelPoint() {
		return levelPoint;
	}

	public void setLevelPoint(int levelPoint) {
		this.levelPoint = levelPoint;
	}

	public String getLogoPath() {
		return logoPath;
	}

	public void setLogoPath(String logoPath) {
		this.logoPath = logoPath;
	}

	public String getSignagePath() {
		return signagePath;
	}

	public void setSignagePath(String signagePath) {
		this.signagePath = signagePath;
	}

	public int getIntegrityAuth() {
		return integrityAuth;
	}

	public void setIntegrityAuth(int integrityAuth) {
		this.integrityAuth = integrityAuth;
	}

	public int getCompanyAuth() {
		return companyAuth;
	}

	public void setCompanyAuth(int companyAuth) {
		this.companyAuth = companyAuth;
	}

	public int getRealStoreAuth() {
		return realStoreAuth;
	}

	public void setRealStoreAuth(int realStoreAuth) {
		this.realStoreAuth = realStoreAuth;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public Date getOpenStoreDate() {
		return openStoreDate;
	}

	public void setOpenStoreDate(Date openStoreDate) {
		this.openStoreDate = openStoreDate;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public int getApplyType() {
		return applyType;
	}

	public void setApplyType(int applyType) {
		this.applyType = applyType;
	}

	public Integer getApproveState() {
		return approveState;
	}

	public void setApproveState(Integer approveState) {
		this.approveState = approveState;
	}

	public String getRejectReason() {
		return rejectReason;
	}

	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}

	public List<Goods> getGoods() {
		return goods;
	}

	public void setGoods(List<Goods> goods) {
		this.goods = goods;
	}

	public int getCommodityTotal() {
		return commodityTotal;
	}

	public void setCommodityTotal(int commodityTotal) {
		this.commodityTotal = commodityTotal;
	}

	public int getCommodityOnSaleTotal() {
		return commodityOnSaleTotal;
	}

	public void setCommodityOnSaleTotal(int commodityOnSaleTotal) {
		this.commodityOnSaleTotal = commodityOnSaleTotal;
	}

	public int getCommodityPrecedingMonthTotal() {
		return commodityPrecedingMonthTotal;
	}

	public void setCommodityPrecedingMonthTotal(int commodityPrecedingMonthTotal) {
		this.commodityPrecedingMonthTotal = commodityPrecedingMonthTotal;
	}

	public int getCommodityThisMonthTotal() {
		return commodityThisMonthTotal;
	}

	public void setCommodityThisMonthTotal(int commodityThisMonthTotal) {
		this.commodityThisMonthTotal = commodityThisMonthTotal;
	}

	public int getDownloadTotal() {
		return downloadTotal;
	}

	public void setDownloadTotal(int downloadTotal) {
		this.downloadTotal = downloadTotal;
	}

	public int getPurchaseTotal() {
		return purchaseTotal;
	}

	public void setPurchaseTotal(int purchaseTotal) {
		this.purchaseTotal = purchaseTotal;
	}

	public int getIsFavourite() {
		return isFavourite;
	}

	public void setIsFavourite(int isFavourite) {
		this.isFavourite = isFavourite;
	}

	public int getFullMemberFlg() {
		return fullMemberFlg;
	}

	public void setFullMemberFlg(int fullMemberFlg) {
		this.fullMemberFlg = fullMemberFlg;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public int getNewPurchaseTotal() {
		return newPurchaseTotal;
	}

	public void setNewPurchaseTotal(int newPurchaseTotal) {
		this.newPurchaseTotal = newPurchaseTotal;
	}

	public Date getRefreshDate() {
		return refreshDate;
	}

	public void setRefreshDate(Date refreshDate) {
		this.refreshDate = refreshDate;
	}

	public Integer getRealUserAuth() {
		return realUserAuth;
	}

	public void setRealUserAuth(Integer realUserAuth) {
		this.realUserAuth = realUserAuth;
	}

}
