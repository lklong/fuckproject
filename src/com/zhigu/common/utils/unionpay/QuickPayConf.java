package com.zhigu.common.utils.unionpay;

/**
 * 名称：支付配置类 功能：配置类 类属性：公共类 版本：1.0 日期：2011-03-11 作者：中国银联UPOP团队 版权：中国银联
 * 说明：以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。该代码仅供参考。
 * */

public class QuickPayConf {

	// 版本号
	public final static String version = "1.0.0";

	// 编码方式
	public final static String charset = "UTF-8";

	// 支付网址
	public final static String gateWay = "http://58.246.226.99/UpopWeb/api/Pay.action";

	// 后续交易网址
	public final static String backStagegateWay = "http://58.246.226.99/UpopWeb/api/BSPay.action";

	// 查询网址
	public final static String queryUrl = "http://58.246.226.99/UpopWeb/api/Query.action";

	// 商户代码
	public final static String merCode = "105550149170027";

	// 商户名称
	public final static String merName = "用户商城名称";

	public final static String merFrontEndUrl = "http://tc11cn.oicp.net:50892/open/unionpay/payFrontRes";

	public final static String merBackEndUrl = "http://tc11cn.oicp.net:50892/open/unionpay/payFrontRes";

	// 加密方式
	public final static String signType = "MD5";

	// 商城密匙，需要和银联商户网站上配置的一样
	public final static String securityKey = "88888888";

	// 签名
	public final static String signature = "signature";
	public final static String signMethod = "signMethod";

	// 组装消费请求包
	public final static String[] reqVo = new String[] { "version", "charset", "transType", "origQid", "merId", "merAbbr", "acqCode", "merCode", "commodityUrl", "commodityName", "commodityUnitPrice",
			"commodityQuantity", "commodityDiscount", "transferFee", "orderNumber", "orderAmount", "orderCurrency", "orderTime", "customerIp", "customerName", "defaultPayType", "defaultBankNumber",
			"transTimeout", "frontEndUrl", "backEndUrl", "merReserved" };

	public final static String[] notifyVo = new String[] { "charset", "cupReserved", "exchangeDate", "exchangeRate", "merAbbr", "merId", "orderAmount", "orderCurrency", "orderNumber", "qid",
			"respCode", "respMsg", "respTime", "settleAmount", "settleCurrency",
			// "settleCurrencyIndex",
			"settleDate", "traceNumber", "traceTime", "transType", "version" };

	public final static String[] queryVo = new String[] { "version", "charset", "transType", "merId", "orderNumber", "orderTime", "merReserved" };

}
