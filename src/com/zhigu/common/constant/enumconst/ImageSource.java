/**
 * @ClassName: ImageSource.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年6月5日
 * 
 */
package com.zhigu.common.constant.enumconst;

import java.util.Arrays;
import java.util.List;

/**
 * @author Administrator
 *
 *         图片来源
 */
public enum ImageSource {

	// 第一个规格默认为验证规格，不用做图片裁剪处理（最大宽度x最大高度x最小宽度x最小高度[0/空字符串：表示不限制],若为正方形：最大宽x最小宽）
	Goods_Main("商品主图", 1, Arrays.asList(new String[] { "1290x430", "1290x1290","430x430","285x285","160x160" }), 1024 * 800),
	Goods_Description("商品描述最大宽度为975px,高度不做限制", 2, Arrays.asList(new String[] { "975x0", "975x0" }), 1572864), 
	Store_Logo("店铺LOGO", 3, Arrays.asList(new String[] { "80x80" }), 1204 * 80), 
	User_Head("用户头像", 4, Arrays.asList(new String[] { "", "" }), 1024 * 80), 
	User_Certificate("认证图片", 5, Arrays.asList(new String[] {"800x0x0x0", "800x0" }), 1024 * 500), 
	User_Card("用户省份证", 6, Arrays.asList(new String[] { "800x0x0x0", "800x0"  }), 1024 * 300), 
	Store_Back("店铺背景图1920x150px(可宽，不可高)", 7, Arrays.asList(new String[] { "0x150x1920x0","1920x150" }),1024 * 300);

	/** 图片来源说明 */
	private String state;

	/** 类型int标示的值 */
	private Integer type;

	/** 规格 */
	private List<String> specs;

	/** 大小 */
	private long size;

	private ImageSource(String state, Integer type, List<String> specs, long size) {

		this.state = state;
		this.type = type;
		this.specs = specs;
		this.size = size;
	}

	public List<String> getSpecs() {
		return specs;
	}

	public void setSpecs(List<String> specs) {
		this.specs = specs;
	}

	public long getSize() {
		return size;
	}

	public void setSize(long size) {
		this.size = size;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

}
