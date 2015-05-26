package com.zhigu.model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Offlinetransferaccounts implements Serializable {

	private int id;
	private int userId;
	private int handlerId;
	private String bankName;
	private String bankNum;
	private String payerBankNun;
	private String filePath;
	private String RealFileName;
	private int status; // 0：未处理，1 处理通过,2不予处理
	private Date createDate;
	private Date handleDate;
	private UserAuth user;

	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankNum() {
		return bankNum;
	}

	public void setBankNum(String bankNum) {
		this.bankNum = bankNum;
	}

	public String getPayerBankNun() {
		return payerBankNun;
	}

	public void setPayerBankNun(String payerBankNun) {
		this.payerBankNun = payerBankNun;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public String getCreateDateFormat() {
		return simpleDateFormat.format(createDate);
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getHandleDate() {
		return handleDate;
	}

	public void setHandleDate(Date handleDate) {
		this.handleDate = handleDate;
	}

	public String getRealFileName() {
		return RealFileName;
	}

	public void setRealFileName(String realFileName) {
		RealFileName = realFileName;
	}

	public int getHandlerId() {
		return handlerId;
	}

	public void setHandlerId(int handlerId) {
		this.handlerId = handlerId;
	}

	public UserAuth getUser() {
		return user;
	}

	public void setUser(UserAuth user) {
		this.user = user;
	}

}
