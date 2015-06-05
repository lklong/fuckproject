package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

import com.zhigu.common.constant.enumconst.CompanyType;

/**
 * 企业认证
 * 
 * @author Y.Z.X
 * @since 2015-06-04
 *
 */
public class CompanyAuth implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/** ID */
	private int id;

	/** 用户ID */
	private int userID;

	/** 店铺ID */
	private int storeID;

	/** 企业名称 */
	private String companyName;

	/** 企业类型 */
	private int companyType;

	/** 工商注册号 */
	private String regNumber;

	/** 企业法人 */
	private String corporation;

	/** 营业期限 */
	private Date businessTerm;

	/** 长期有效 */
	private int perpetual;

	/** 注册资金 */
	private int capital;

	/** 营业范围 */
	private String businessScope;

	/** 注册地址(省) */
	private String regProvince;

	/** 注册地址(市) */
	private String regCity;

	/** 注册地址(区) */
	private String regDistrict;

	/** 注册地址(具体地址) */
	private String regStreet;

	/** 公司地址(省) */
	private String companyProvince;

	/** 公司地址(市) */
	private String companyCity;

	/** 公司地址(区) */
	private String companyDistrict;

	/** 公司地址(具体地址) */
	private String companyStreet;

	/** 营业执照 */
	private String image;

	/** 业务员 **/
	private Integer salesman;

	/** 申请时间 */
	private Date applyTime;

	/** 审核状态（1通过，2驳回， 3待审核） */
	private int status;

	/** 审核者 */
	private int approveUser;

	/** 审核时间 */
	private Date authTime;

	/** 驳回原因 */
	private String rejectReason;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getStoreID() {
		return storeID;
	}

	public void setStoreID(int storeID) {
		this.storeID = storeID;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public int getCompanyType() {
		return companyType;
	}

	public void setCompanyType(int companyType) {
		this.companyType = companyType;
	}

	public String getRegNumber() {
		return regNumber;
	}

	public void setRegNumber(String regNumber) {
		this.regNumber = regNumber;
	}

	public String getCorporation() {
		return corporation;
	}

	public void setCorporation(String corporation) {
		this.corporation = corporation;
	}

	public Date getBusinessTerm() {
		return businessTerm;
	}

	public void setBusinessTerm(Date businessTerm) {
		this.businessTerm = businessTerm;
	}

	public int getCapital() {
		return capital;
	}

	public void setCapital(int capital) {
		this.capital = capital;
	}

	public String getBusinessScope() {
		return businessScope;
	}

	public void setBusinessScope(String businessScope) {
		this.businessScope = businessScope;
	}

	public String getRegProvince() {
		return regProvince;
	}

	public void setRegProvince(String regProvince) {
		this.regProvince = regProvince;
	}

	public String getRegCity() {
		return regCity;
	}

	public void setRegCity(String regCity) {
		this.regCity = regCity;
	}

	public String getRegDistrict() {
		return regDistrict;
	}

	public void setRegDistrict(String regDistrict) {
		this.regDistrict = regDistrict;
	}

	public String getRegStreet() {
		return regStreet;
	}

	public void setRegStreet(String regStreet) {
		this.regStreet = regStreet;
	}

	public String getCompanyProvince() {
		return companyProvince;
	}

	public void setCompanyProvince(String companyProvince) {
		this.companyProvince = companyProvince;
	}

	public String getCompanyCity() {
		return companyCity;
	}

	public void setCompanyCity(String companyCity) {
		this.companyCity = companyCity;
	}

	public String getCompanyDistrict() {
		return companyDistrict;
	}

	public void setCompanyDistrict(String companyDistrict) {
		this.companyDistrict = companyDistrict;
	}

	public String getCompanyStreet() {
		return companyStreet;
	}

	public void setCompanyStreet(String companyStreet) {
		this.companyStreet = companyStreet;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public int getApproveUser() {
		return approveUser;
	}

	public void setApproveUser(int approveUser) {
		this.approveUser = approveUser;
	}

	public String getRejectReason() {
		return rejectReason;
	}

	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}

	public int getPerpetual() {
		return perpetual;
	}

	public void setPerpetual(int perpetual) {
		this.perpetual = perpetual;
	}

	public Date getAuthTime() {
		return authTime;
	}

	public void setAuthTime(Date authTime) {
		this.authTime = authTime;
	}

	public String getCompanyTypeLabel() {
		return CompanyType.getNameByValue(this.companyType);
	}

	public Integer getSalesman() {
		return salesman;
	}

	public void setSalesman(Integer salesman) {
		this.salesman = salesman;
	}

}
