package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

/***********************************************************************
 * Module: RealUserAuth.java Author: Administrator Purpose: Defines the Class
 * UserInfo
 ***********************************************************************/

public class RealUserAuth implements Serializable {
	// 用户ID
	private int userID;
	// 真实姓名
	private String realName;
	// 身份证号
	private String idCard;
	// 身份证有效期
	private String cardValidity;
	// 永久有效（0否，1是）
	private int perpetual;
	// 身份证正面
	private String cardFrontImg;
	// 身份证背面
	private String cardBackImg;
	// 支付宝
	private String alipay;
	// 申请时间
	private Date applyTime;
	// 审核状态（0待审核，1通过，2驳回）
	private int approveState;
	// 审核者
	private int approveUser;
	// 驳回原因
	private String rejectReason;

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getCardValidity() {
		return cardValidity;
	}

	public void setCardValidity(String cardValidity) {
		this.cardValidity = cardValidity;
	}

	public int getPerpetual() {
		return perpetual;
	}

	public void setPerpetual(int perpetual) {
		this.perpetual = perpetual;
	}

	public String getCardFrontImg() {
		return cardFrontImg;
	}

	public void setCardFrontImg(String cardFrontImg) {
		this.cardFrontImg = cardFrontImg;
	}

	public String getCardBackImg() {
		return cardBackImg;
	}

	public void setCardBackImg(String cardBackImg) {
		this.cardBackImg = cardBackImg;
	}

	public String getAlipay() {
		return alipay;
	}

	public void setAlipay(String alipay) {
		this.alipay = alipay;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public int getApproveState() {
		return approveState;
	}

	public void setApproveState(int approveState) {
		this.approveState = approveState;
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

}