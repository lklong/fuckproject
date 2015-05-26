package com.zhigu.model;

import java.math.BigDecimal;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;

public class ShoppingCart {
	// 商家信息
	private int storeId;// 店铺ID
	private String storeName;// 商铺名称
	private String QQ;
	private String aliWangWang;// 旺旺

	private List<ShoppingCartItem> item;

	// 订单确认处便于统计而用，其他地方禁用
	// private BigDecimal storeTotal;// 店铺合计
	private BigDecimal weight;// 重量

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getQQ() {
		return QQ;
	}

	public void setQQ(String qQ) {
		QQ = qQ;
	}

	public String getAliWangWang() {
		return aliWangWang;
	}

	public void setAliWangWang(String aliWangWang) {
		this.aliWangWang = aliWangWang;
	}

	public List<ShoppingCartItem> getItem() {
		return item;
	}

	public void setItem(List<ShoppingCartItem> item) {
		this.item = item;
	}

	// 计算当前店铺总计
	public BigDecimal getStoreTotal() {
		BigDecimal temp = new BigDecimal(0);
		if (CollectionUtils.isNotEmpty(item)) {
			for (int j = 0; j < item.size(); j++) {
				ShoppingCartItem _item = item.get(j);
				temp = temp.add(_item.getGoodsSku().getPrice().multiply(new BigDecimal(_item.getQuantity())));
			}
		}
		return temp;
	}

	public BigDecimal getWeight() {
		weight = new BigDecimal(0);
		if (CollectionUtils.isNotEmpty(item)) {
			for (int j = 0; j < item.size(); j++) {
				ShoppingCartItem i = item.get(j);
				weight = weight.add(new BigDecimal(String.valueOf(i.getGoods().getWeight())).multiply(new BigDecimal(String.valueOf(i.getQuantity()))));
			}
		}
		return weight;
	}

}
