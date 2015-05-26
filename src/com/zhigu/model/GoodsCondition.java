package com.zhigu.model;

import java.util.List;

import com.zhigu.common.constant.enumconst.GoodsStatus;

/**
 * 商品查询条件
 * 
 * @author zhouqibing 2014年10月11日下午3:48:43
 */
public class GoodsCondition {
	/**
	 * 商品名
	 */
	private String goodsName;
	/**
	 * 店铺id
	 */
	private Integer storeId;
	/**
	 * 状态
	 */
	private Integer status = GoodsStatus.NORMAL.getValue();
	/**
	 * 商品查询属性集合
	 */
	private List<GoodsProperty> gps = null;
	/**
	 * 类别（用户选择类别）
	 */
	private Integer categoryId;

	/**
	 * 进入店铺的是店主还是用户，如果是店主，在店铺信息头部会显示"刷新店铺"字样，进行操作
	 */
	private Integer flag;

	/**
	 * 排序方式<br>
	 * 销量（1:ASC,2:DESC)<br>
	 * 浏览（3:ASC,4:DESC)<br>
	 * 下载（5:ASC,6:DESC)<br>
	 * 价格（7:ASC,8:DESC)<br>
	 * 时间（9:ASC,10:DESC)<br>
	 * 收藏（11:ASC,12:DESC)<br>
	 * 综合（13:ASC,14:DESC)<br>
	 */
	private Integer sort;
	/**
	 * 叶子类别（最终查询用）
	 */
	private List<Category> lastCategorys;

	/**
	 * 进入店铺的是店主还是用户，如果是店主，在店铺信息头部会显示"刷新店铺"字样，进行操作
	 */
	public Integer getFlag() {
		return flag;
	}

	/**
	 * 进入店铺的是店主还是用户，如果是店主，在店铺信息头部会显示"刷新店铺"字样，进行操作
	 */
	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public List<GoodsProperty> getGps() {
		return gps;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public List<Category> getLastCategorys() {
		return lastCategorys;
	}

	public void setLastCategorys(List<Category> lastCategorys) {
		this.lastCategorys = lastCategorys;
	}

	public void setGps(List<GoodsProperty> gps) {
		this.gps = gps;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public Integer getSort() {
		return sort;
	}

	/**
	 * 销量（1:ASC,2:DESC)<br>
	 * 浏览（3:ASC,4:DESC)<br>
	 * 下载（5:ASC,6:DESC)<br>
	 * 价格（7:ASC,8:DESC)<br>
	 * 时间（9:ASC,10:DESC)<br>
	 * 收藏（11:ASC,12:DESC)<br>
	 * 综合（13:ASC,14:DESC)<br>
	 * 
	 * @param sort
	 */
	public void setSort(Integer sort) {
		this.sort = sort;
	}

}
