package com.zhigu.model;

import java.util.Date;

/**
 * 用户文件
 * 
 * @author HeSiMin
 * @date 2014年9月23日
 *
 */
public class UserFile {
	private int fileID;
	private int userID;
	private int folderID;
	private int type;
	private String filePath;
	private int size;
	private String image100;
	private Date createDate;

	public int getFileID() {
		return fileID;
	}

	public void setFileID(int fileID) {
		this.fileID = fileID;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getFolderID() {
		return folderID;
	}

	public void setFolderID(int folderID) {
		this.folderID = folderID;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public String getImage100() {
		return image100;
	}

	public void setImage100(String image100) {
		this.image100 = image100;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

}
