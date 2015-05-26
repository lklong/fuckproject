package com.zhigu.model;

import java.util.Date;

/**
 * 用户淘宝
 * 
 * @author HeSiMin
 * @date 2014年8月20日
 *
 */
public class UserTaobao {
	private int ID;
	private int userID;
	private String access_token;
	private int expires_in;
	private String refresh_token;
	private String taobao_user_nick;
	private String taobao_user_id;
	private Date refreshDate;
	private Date addDate;

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

	public String getAccess_token() {
		return access_token;
	}

	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}

	public int getExpires_in() {
		return expires_in;
	}

	public void setExpires_in(int expires_in) {
		this.expires_in = expires_in;
	}

	public String getRefresh_token() {
		return refresh_token;
	}

	public void setRefresh_token(String refresh_token) {
		this.refresh_token = refresh_token;
	}

	public String getTaobao_user_nick() {
		return taobao_user_nick;
	}

	public void setTaobao_user_nick(String taobao_user_nick) {
		this.taobao_user_nick = taobao_user_nick;
	}

	public String getTaobao_user_id() {
		return taobao_user_id;
	}

	public void setTaobao_user_id(String taobao_user_id) {
		this.taobao_user_id = taobao_user_id;
	}

	public Date getAddDate() {
		return addDate;
	}

	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}

	public Date getRefreshDate() {
		return refreshDate;
	}

	public void setRefreshDate(Date refreshDate) {
		this.refreshDate = refreshDate;
	}

}
