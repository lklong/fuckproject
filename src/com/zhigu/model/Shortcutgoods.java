package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;

/*
 *@author
 */
public class Shortcutgoods implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2498656683990086127L;

	// id
	private int id;
	// 发布用户id
	private int userId;
	// 商品处理状态 0 ,未处理，1 已处理
	private int status;
	// 创建时间
	private Date createDate;
	// 处理时间
	private Date handleDate;
	// 处理者id
	private int handlerId;
	// 文件原名
	private String realFileName;

	private UserAuth user;

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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getCreateDate() {
		return createDate;
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

	public int getHandlerId() {
		return handlerId;
	}

	public void setHandlerId(int handlerId) {
		this.handlerId = handlerId;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getRealFileName() {
		return realFileName;
	}

	public void setRealFileName(String realFileName) {
		this.realFileName = realFileName;
	}

	public UserAuth getUser() {
		return user;
	}

	public void setUser(UserAuth user) {
		this.user = user;
	}

	private String filePath;

}
