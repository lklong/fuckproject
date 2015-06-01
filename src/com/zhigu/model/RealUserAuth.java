package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 实名认证 实体类
 * 
 * @author Y.Z.X
 * @since 2015-05-28
 */
public class RealUserAuth implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** 用户ID */
	private Integer userId;

	/** 真实姓名 */
	private String realName;

	/** 身份证 */
	private String idCard;

	/** 身份证有效期 */
	private Date cardValidity;

	/** 永久有效（0否，1是） */
	private Boolean perpetualFlag;

	/** 身份证正面 */
	private String cardFrontImg;

	/** 身份证背面 */
	private String cardBackImg;

	/** 审核状态 0待审核，1通过，2驳回 */
	private Integer status;

	/** 申请时间 */
	private Date addTime;

	/** 申请人 */
	private Integer addAdminId;

	/** 审核人 */
	private Integer approveAdminId;

	/** 审核时间 */
	private Date approveTime;

	/** 驳回原因 */
	private String rejectReason;

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName == null ? null : realName.trim();
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard == null ? null : idCard.trim();
	}

	public Date getCardValidity() {
		return cardValidity;
	}

	public void setCardValidity(Date cardValidity) {
		this.cardValidity = cardValidity == null ? null : cardValidity;
	}

	public Boolean getPerpetualFlag() {
		return perpetualFlag;
	}

	public void setPerpetualFlag(Boolean perpetualFlag) {
		this.perpetualFlag = perpetualFlag;
	}

	public String getCardFrontImg() {
		return cardFrontImg;
	}

	public void setCardFrontImg(String cardFrontImg) {
		this.cardFrontImg = cardFrontImg == null ? null : cardFrontImg.trim();
	}

	public String getCardBackImg() {
		return cardBackImg;
	}

	public void setCardBackImg(String cardBackImg) {
		this.cardBackImg = cardBackImg == null ? null : cardBackImg.trim();
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Integer getAddAdminId() {
		return addAdminId;
	}

	public void setAddAdminId(Integer addAdminId) {
		this.addAdminId = addAdminId;
	}

	public Integer getApproveAdminId() {
		return approveAdminId;
	}

	public void setApproveAdminId(Integer approveAdminId) {
		this.approveAdminId = approveAdminId;
	}

	public Date getApproveTime() {
		return approveTime;
	}

	public void setApproveTime(Date approveTime) {
		this.approveTime = approveTime;
	}

	public String getRejectReason() {
		return rejectReason;
	}

	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason == null ? null : rejectReason.trim();
	}
}