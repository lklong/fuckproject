package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.zhigu.common.constant.BusinessArea;

public class Store implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/** ID */
	private Integer ID;
	/** 用户ID */
	private Integer userID;
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
	private Integer storeNameModify;
	/** 域名可用修改次数 */
	private Integer domainModify;
	/** 等级点数（转换等级） */
	private Integer levelPoint;
	/** 积分（按卖出商品价格计算，非4舍5入，取整数，舍去小数部分 */
	private Integer score;
	/** Logo */
	private String logoPath;
	/** 招牌 */
	private String signagePath;
	/** 诚信认证 */
	private Integer integrityAuth;
	/** 企业认证 1:认证通过 2.认证不通过 3:待认证 */
	private Integer companyAuth;
	/** 实体认证 */
	private Integer realStoreAuth;
	/** 简介 */
	private String introduction;
	/** 开店时间 */
	private Date openStoreDate;
	/** 正式会员Flg */
	private Integer fullMemberFlg;
	/** 申请时间 */
	private Date applyTime;
	/** 状态(创建时) 0:非会员 1:会员 */
	private Integer applyType;
	/** 审核状态 */
	private Integer approveState;
	/** 审核后拒绝的理由 */
	private String rejectReason;
	/** 供应商类型 */
	private Integer supplierType;
	/** 刷新时间 **/
	private Date refreshDate;

	/** 店铺商品 */
	private List<Goods> goods;
	/** 是否被收藏 */
	private Integer isFavourite;
	/** 已发布商品（总数） */
	private Integer commodityTotal;
	/** 在售商品数 */
	private Integer commodityOnSaleTotal;
	/** 上月发布商品总数 */
	private Integer commodityPrecedingMonthTotal;
	/** 本月发布商品总数 */
	private Integer commodityThisMonthTotal;
	/** 累计下载量 */
	private Integer downloadTotal;
	/** 累计销量 */
	private Integer purchaseTotal;
	/** 新上架销售 1个月内 */
	private Integer newPurchaseTotal;

	/** 背景图 */
	private String logoBackPic;

	/** 导航条颜色 */
	private String navColor;

	private String businessAreaLabel;
	/** 作为临时查询使用 非数据库字段 实名认证标示 */
	private Integer realUserAuth;

	public String getBusinessAreaLabel() {
		return BusinessArea.getNameByValue(businessArea);
	}

	public String getLogoBackPic() {
		return logoBackPic;
	}

	public void setLogoBackPic(String logoBackPic) {
		this.logoBackPic = StringUtils.isBlank(logoBackPic) ? null : logoBackPic.trim();
	}

	public String getNavColor() {
		return navColor;
	}

	public void setNavColor(String navColor) {
		this.navColor = navColor = StringUtils.isBlank(navColor) ? null : navColor.trim();
	}

	public Integer getID() {
		return ID;
	}

	public void setID(Integer ID) {
		this.ID = ID;
	}

	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}

	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain = StringUtils.isBlank(domain) ? null : domain.toString();
	}

	public Integer getSupplierType() {
		return supplierType;
	}

	public void setSupplierType(Integer supplierType) {
		this.supplierType = supplierType;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName = StringUtils.isBlank(storeName) ? null : storeName.trim();
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province = StringUtils.isBlank(province) ? null : province.trim();
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city = StringUtils.isBlank(city) ? null : city.trim();
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district = StringUtils.isBlank(district) ? null : district.trim();
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street = StringUtils.isBlank(street) ? null : street.trim();
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
		this.contactName = contactName = StringUtils.isBlank(contactName) ? null : contactName.trim();
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone = StringUtils.isBlank(phone) ? null : phone.trim();
	}

	public String getQQ() {
		return QQ;
	}

	public void setQQ(String QQ) {
		this.QQ = QQ = StringUtils.isBlank(QQ) ? null : QQ.trim();
	}

	public String getAliWangWang() {
		return aliWangWang;
	}

	public void setAliWangWang(String aliWangWang) {
		this.aliWangWang = aliWangWang = StringUtils.isBlank(aliWangWang) ? null : aliWangWang.trim();
	}

	public Integer getStoreNameModify() {
		return storeNameModify;
	}

	public void setStoreNameModify(Integer storeNameModify) {
		this.storeNameModify = storeNameModify;
	}

	public Integer getDomainModify() {
		return domainModify;
	}

	public void setDomainModify(Integer domainModify) {
		this.domainModify = domainModify;
	}

	public Integer getLevelPoint() {
		return levelPoint;
	}

	public void setLevelPoint(Integer levelPoint) {
		this.levelPoint = levelPoint;
	}

	public String getLogoPath() {
		return logoPath;
	}

	public void setLogoPath(String logoPath) {
		this.logoPath = logoPath = StringUtils.isBlank(logoPath) ? null : logoPath.trim();
	}

	public String getSignagePath() {
		return signagePath;
	}

	public void setSignagePath(String signagePath) {
		this.signagePath = signagePath = StringUtils.isBlank(signagePath) ? null : signagePath.trim();
	}

	public Integer getIntegrityAuth() {
		return integrityAuth;
	}

	public void setIntegrityAuth(Integer integrityAuth) {
		this.integrityAuth = integrityAuth;
	}

	public Integer getCompanyAuth() {
		return companyAuth;
	}

	public void setCompanyAuth(Integer companyAuth) {
		this.companyAuth = companyAuth;
	}

	public Integer getRealStoreAuth() {
		return realStoreAuth;
	}

	public void setRealStoreAuth(Integer realStoreAuth) {
		this.realStoreAuth = realStoreAuth;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction = StringUtils.isBlank(introduction) ? null : introduction.trim();
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

	public Integer getApplyType() {
		return applyType;
	}

	public void setApplyType(Integer applyType) {
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
		this.rejectReason = rejectReason = StringUtils.isBlank(rejectReason) ? null : rejectReason.trim();
	}

	public List<Goods> getGoods() {
		return goods;
	}

	public void setGoods(List<Goods> goods) {
		this.goods = goods;
	}

	public Integer getCommodityTotal() {
		return commodityTotal;
	}

	public void setCommodityTotal(Integer commodityTotal) {
		this.commodityTotal = commodityTotal;
	}

	public Integer getCommodityOnSaleTotal() {
		return commodityOnSaleTotal;
	}

	public void setCommodityOnSaleTotal(Integer commodityOnSaleTotal) {
		this.commodityOnSaleTotal = commodityOnSaleTotal;
	}

	public Integer getCommodityPrecedingMonthTotal() {
		return commodityPrecedingMonthTotal;
	}

	public void setCommodityPrecedingMonthTotal(Integer commodityPrecedingMonthTotal) {
		this.commodityPrecedingMonthTotal = commodityPrecedingMonthTotal;
	}

	public Integer getCommodityThisMonthTotal() {
		return commodityThisMonthTotal;
	}

	public void setCommodityThisMonthTotal(Integer commodityThisMonthTotal) {
		this.commodityThisMonthTotal = commodityThisMonthTotal;
	}

	public Integer getDownloadTotal() {
		return downloadTotal;
	}

	public void setDownloadTotal(Integer downloadTotal) {
		this.downloadTotal = downloadTotal;
	}

	public Integer getPurchaseTotal() {
		return purchaseTotal;
	}

	public void setPurchaseTotal(Integer purchaseTotal) {
		this.purchaseTotal = purchaseTotal;
	}

	public Integer getIsFavourite() {
		return isFavourite;
	}

	public void setIsFavourite(Integer isFavourite) {
		this.isFavourite = isFavourite;
	}

	public Integer getFullMemberFlg() {
		return fullMemberFlg;
	}

	public void setFullMemberFlg(Integer fullMemberFlg) {
		this.fullMemberFlg = fullMemberFlg;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Integer getNewPurchaseTotal() {
		return newPurchaseTotal;
	}

	public void setNewPurchaseTotal(Integer newPurchaseTotal) {
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
