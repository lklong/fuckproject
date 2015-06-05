package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 实体认证认证
 * 
 * @author HeSiMin
 * @date 2014年8月12日
 *
 */
public class RealStoreAuth implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/** ID */
	private int ID;
	/** 用户ID */
	private int userID;
	/** 店铺ID */
	private int storeID;
	/** 实体名称 */
	private String realStoreName;
	/** 经营人 */
	private String master;
	/** 联系电话 */
	private String phone;
	/** 实体地址 */
	private String realStoreAddress;
	/** 图片1 */
	private String image1;
	/** 图片2 */
	private String image2;
	/** 图片3 */
	private String image3;
	/** 业务员 **/
	private Integer salesman;
	/** 申请时间 */
	private Date applyTime;
	/** 审核状态（0待审核，1通过，2驳回） */
	private int status;
	/** 审核者 */
	private int approveUser;
	/** 审核时间 */
	private Date authTime;
	/** 驳回原因 */
	private String rejectReason;

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
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

	public String getRealStoreName() {
		return realStoreName;
	}

	public void setRealStoreName(String realStoreName) {
		this.realStoreName = realStoreName;
	}

	public String getMaster() {
		return master;
	}

	public void setMaster(String master) {
		this.master = master;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRealStoreAddress() {
		return realStoreAddress;
	}

	public void setRealStoreAddress(String realStoreAddress) {
		this.realStoreAddress = realStoreAddress;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
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

	public Integer getSalesman() {
		return salesman;
	}

	public void setSalesman(Integer salesman) {
		this.salesman = salesman;
	}

	public Date getAuthTime() {
		return authTime;
	}

	public void setAuthTime(Date authTime) {
		this.authTime = authTime;
	}

}
