/**
 * 
 */
package com.zhigu.model.alibaba;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

/**
 * @author lkl
 *
 */
public class Product {

	private Integer categoryID;// 否 类目ID

	private Map<String, List<Map<String, String>>> skuPics;// 否 sku图片
	// "skuPics":{"3216":[{"\u767d\u8272":"http://img.china.alibaba.com/img/ibank/2013/242/222/926222242_648103749.jpg"},{"\u9ec4\u8272":"http://img.china.alibaba.com/img/ibank/2013/642/128/907821246_648103749.jpg"},{"\u9ed1\u8272":"http://img.china.alibaba.com/img/ibank/2013/988/206/888602889_648103749.jpg"}]}
	private String bizType = "1";// 否 贸易类型。1：产品，2：加工，3：代理，4：合作，5：商务服务
									// 不传入默认按照产品发布
									// 1
	private Boolean supportOnlineTrade = true;// Boolean 否 是否支持网上交易。true：支持
												// false：不支持
	// true
	private Boolean pictureAuthOffer = false;// Boolean 否 是否图片私密信息 true
	private Boolean priceAuthOffer = false;// Boolean 否 是否价格私密信息 true
	private Boolean skuTradeSupport = false;// Boolean 否 是否SKU信息 true
	private Boolean mixWholeSale = false;// Boolean 否 是否支持混批 true
	private Integer offerId;// 否 信息ID。修改的时候需要传入，新发情况下不要填入
	private String priceRanges;

	// 20:10`30:9`40:8
	private Integer amountOnSale = 10000;// 否 可售数量
	private JSONObject productFeatures;// String 否 产品属性列表。key是属性id，
	// value是值。所有的属性值都需要传入，包括产品属性和除价格之外的交易属性
	// {\"1459\":\"吨\"}

	// userCategorys:[\"19347\",\"19349:21410\"]

	private Integer periodOfValidity;// Integer 否 信息有效期
	private String offerDetail;// 否 商品详情信息
	private String subject;// 否 标题
	private List<String> imageUriList;// 否 图片地址
	// ["http://img.china.alibaba.com/img/ibank/2011/736/195/418591637_1146240514.jpg","http://img.china.alibaba.com/img/ibank/2011/736/195/418591637_1146240514.jpg","http://img.china.alibaba.com/img/ibank/2011/736/195/418591637_1146240514.jpg"]
	private String freightType;// 否 运费类型。T（运费模板） D（运费说明） F（卖家承担运费） T
	private Integer sendGoodsAddressId;// Integer 否 发货地址ID 8202
	private Integer freightTemplateId;// Integer 否 物流模板。卖家承担时模板ID为6161
	private Integer offerWeight;// 否 单位重量

	// "skuList":[{"amountOnSale":11,"specAttributes":{"1234":"value1","287":"value2","price":123}},{"amountOnSale":11,"specAttributes":{"1234":"value1","287":"value2","price":123}
	// }]
	// String 1459 ;//String 否 计量单位，unit

	public Integer getCategoryID() {
		return categoryID;
	}

	public String getBizType() {
		return bizType;
	}

	public void setBizType(String bizType) {
		this.bizType = bizType;
	}

	public void setCategoryID(Integer categoryID) {
		this.categoryID = categoryID;
	}

	public Map<String, List<Map<String, String>>> getSkuPics() {
		return skuPics;
	}

	public void setSkuPics(Map<String, List<Map<String, String>>> skuPics) {
		this.skuPics = skuPics;
	}

	public Boolean getSupportOnlineTrade() {
		return supportOnlineTrade;
	}

	public void setSupportOnlineTrade(Boolean supportOnlineTrade) {
		this.supportOnlineTrade = supportOnlineTrade;
	}

	public Boolean getPictureAuthOffer() {
		return pictureAuthOffer;
	}

	public void setPictureAuthOffer(Boolean pictureAuthOffer) {
		this.pictureAuthOffer = pictureAuthOffer;
	}

	public Boolean getPriceAuthOffer() {
		return priceAuthOffer;
	}

	public void setPriceAuthOffer(Boolean priceAuthOffer) {
		this.priceAuthOffer = priceAuthOffer;
	}

	public Boolean getSkuTradeSupport() {
		return skuTradeSupport;
	}

	public void setSkuTradeSupport(Boolean skuTradeSupport) {
		this.skuTradeSupport = skuTradeSupport;
	}

	public Boolean getMixWholeSale() {
		return mixWholeSale;
	}

	public void setMixWholeSale(Boolean mixWholeSale) {
		this.mixWholeSale = mixWholeSale;
	}

	public Integer getOfferId() {
		return offerId;
	}

	public void setOfferId(Integer offerId) {
		this.offerId = offerId;
	}

	public String getPriceRanges() {
		return priceRanges;
	}

	public void setPriceRanges(String priceRanges) {
		this.priceRanges = priceRanges;
	}

	public Integer getAmountOnSale() {
		return amountOnSale;
	}

	public void setAmountOnSale(Integer amountOnSale) {
		this.amountOnSale = amountOnSale;
	}

	public Integer getPeriodOfValidity() {
		return periodOfValidity;
	}

	public void setPeriodOfValidity(Integer periodOfValidity) {
		this.periodOfValidity = periodOfValidity;
	}

	public String getOfferDetail() {
		return offerDetail;
	}

	public void setOfferDetail(String offerDetail) {
		this.offerDetail = offerDetail;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public List<String> getImageUriList() {
		return imageUriList;
	}

	public void setImageUriList(List<String> imageUriList) {
		this.imageUriList = imageUriList;
	}

	public String getFreightType() {
		return freightType;
	}

	public void setFreightType(String freightType) {
		this.freightType = freightType;
	}

	public Integer getSendGoodsAddressId() {
		return sendGoodsAddressId;
	}

	public void setSendGoodsAddressId(Integer sendGoodsAddressId) {
		this.sendGoodsAddressId = sendGoodsAddressId;
	}

	public Integer getFreightTemplateId() {
		return freightTemplateId;
	}

	public void setFreightTemplateId(Integer freightTemplateId) {
		this.freightTemplateId = freightTemplateId;
	}

	public Integer getOfferWeight() {
		return offerWeight;
	}

	public void setOfferWeight(Integer offerWeight) {
		this.offerWeight = offerWeight;
	}

	public JSONObject getProductFeatures() {
		return productFeatures;
	}

	public void setProductFeatures(JSONObject productFeatures) {
		this.productFeatures = productFeatures;
	}

	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}

}
