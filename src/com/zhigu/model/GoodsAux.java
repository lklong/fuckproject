package com.zhigu.model;

/**
 * 商品附属
 * 
 * @author zhouqibing 2014年9月28日下午2:35:07
 */
public class GoodsAux {
	private int id;
	// 商品Id
	private int goodsId;
	// 数量
	private int amount;
	// 下载次数
	private int downloadCount;
	// 评价次数
	private int evaluateCount;
	// 销售数量
	private int purchaseCount;
	// 收藏次数
	private int favouriteCount;
	// 浏览次数
	private int browseCount;
	// 评分
	private float score;
	// 综合得分（下载 + 评价 + 销售 + 收藏 + 浏览 + 评分）
	private float overallScore;

	public GoodsAux() {
	}

	public GoodsAux(int goodsId) {
		this.goodsId = goodsId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getDownloadCount() {
		return downloadCount;
	}

	public void setDownloadCount(int downloadCount) {
		this.downloadCount = downloadCount;
	}

	public int getEvaluateCount() {
		return evaluateCount;
	}

	public void setEvaluateCount(int evaluateCount) {
		this.evaluateCount = evaluateCount;
	}

	public int getPurchaseCount() {
		return purchaseCount;
	}

	public void setPurchaseCount(int purchaseCount) {
		this.purchaseCount = purchaseCount;
	}

	public int getFavouriteCount() {
		return favouriteCount;
	}

	public void setFavouriteCount(int favouriteCount) {
		this.favouriteCount = favouriteCount;
	}

	public float getScore() {
		return score;
	}

	public void setScore(float score) {
		this.score = score;
	}

	public int getBrowseCount() {
		return browseCount;
	}

	public void setBrowseCount(int browseCount) {
		this.browseCount = browseCount;
	}

	public float getOverallScore() {
		return overallScore;
	}

	public void setOverallScore(float overallScore) {
		this.overallScore = overallScore;
	}

}
