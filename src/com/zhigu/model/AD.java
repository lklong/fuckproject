package com.zhigu.model;

import java.io.Serializable;
import java.util.Date;
import org.apache.ibatis.type.Alias;

/**
 * 广告
 * 
 * @author HeSiMin
 * @date 2014年9月11日
 *
 */
@Alias("AD")
public class AD implements Serializable {
	private int ID;
	/**
	 * 
	 */
	private int group;
	/**
	 * 名字
	 */
	private String name;
	/**
	 * 图片
	 */
	private String image;
	/**
	 * 点击跳转链接
	 */
	private String targetLink;
	/**
	 * title属性值
	 */
	private String title;
	/**
	 * 备注
	 */
	private String comment;
	/**
	 * 排序
	 */
	private int sort;
	/**
	 * 开始日期
	 */
	private Date startDate;
	/**
	 * 结束日期
	 */
	private Date endDate;
	/**
	 * 所属用户id
	 */
	private int userID;
	/**
	 * 状态
	 */
	private int status;
	/**
	 * 版本号
	 */
	private int version;

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getTargetLink() {
		return targetLink;
	}

	public void setTargetLink(String targetLink) {
		this.targetLink = targetLink;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getGroup() {
		return group;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public void setGroup(int group) {
		this.group = group;
	}

	public int getSort() {
		return sort;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

}
