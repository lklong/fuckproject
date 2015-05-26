/**
 * 
 */
package com.zhigu.model.alibaba;

import java.util.List;

/**
 * @author Administrator
 *
 */
public class ProductPropList {

	private List<String> priceranges;// 否 区间价格。每个区间之间用`分割，冒号前面是起订量，后面是价格
	private List<String> numRanges;

	private String skuList;// String 否 SKU信息。message:OfferSkuParam

	private String[] userCategorys;// 否 自定义类目信息。如果有父ID ，则格式为：父id:子ID

	public String[] getUserCategorys() {
		return userCategorys;
	}

	public void setUserCategorys(String[] userCategorys) {
		this.userCategorys = userCategorys;
	}

	private Integer categoryID;// 否 类目ID

	public List<String> getPriceranges() {
		return priceranges;
	}

	public void setPriceranges(List<String> priceranges) {
		this.priceranges = priceranges;
	}

	public String getSkuList() {
		return skuList;
	}

	public void setSkuList(String skuList) {
		this.skuList = skuList;
	}

	public Integer getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(Integer categoryID) {
		this.categoryID = categoryID;
	}

	public List<String> getNumRanges() {
		return numRanges;
	}

	public void setNumRanges(List<String> numRanges) {
		this.numRanges = numRanges;
	}

}
