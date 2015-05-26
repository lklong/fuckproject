package com.zhigu.model;

public class File {
	private Integer fileid;

	private Integer fileconnectionid;

	private String filename;

	private String fileaddress;

	private String filetype;

	public Integer getFileid() {
		return fileid;
	}

	public void setFileid(Integer fileid) {
		this.fileid = fileid;
	}

	public Integer getFileconnectionid() {
		return fileconnectionid;
	}

	public void setFileconnectionid(Integer fileconnectionid) {
		this.fileconnectionid = fileconnectionid;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFileaddress() {
		return fileaddress;
	}

	public void setFileaddress(String fileaddress) {
		this.fileaddress = fileaddress;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
}