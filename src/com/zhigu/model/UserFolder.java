package com.zhigu.model;

/**
 * 用户文件夹
 * 
 * @author HeSiMin
 * @date 2014年9月23日
 *
 */
public class UserFolder {
	private int folderID;
	private int userID;
	private String folderName;
	private int isDefault;

	public int getFolderID() {
		return folderID;
	}

	public void setFolderID(int folderID) {
		this.folderID = folderID;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getFolderName() {
		return folderName;
	}

	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}

	public int getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(int isDefault) {
		this.isDefault = isDefault;
	}

}
