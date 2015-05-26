package com.zhigu.model;

import java.util.Date;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;

public class CementContent {
	private Integer id;

	private Integer cementId;

	private String cementName;

	private String title;

	private Date addTime;

	private Integer sort;

	private String cementImg;

	private String content;

	/** 非数据库字段 */
	private Integer type;

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getCementId() {
		return cementId;
	}

	public void setCementId(Integer cementId) {
		this.cementId = cementId;
	}

	public String getCementName() {
		return cementName;
	}

	public void setCementName(String cementName) {
		this.cementName = cementName;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title == null ? null : title.trim();
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public void setCementImg(String cementImg) {
		this.cementImg = cementImg;
	}

	public String getCementImg() {
		return cementImg;
	}

	public void setCementimg(String cementImg) {
		this.cementImg = cementImg == null ? null : cementImg.trim();
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content == null ? null : content.trim();
	}

	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}
}