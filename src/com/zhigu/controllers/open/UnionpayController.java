package com.zhigu.controllers.open;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zhigu.common.utils.unionpay.QuickPayConf;
import com.zhigu.common.utils.unionpay.QuickPayUtils;

/**
 * 银联支付回调
 * 
 * @ClassName: UnionpayController
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @author hesimin
 * @date 2015年4月27日 上午11:51:37
 *
 */
@RequestMapping("/open/unionpay")
@Controller
public class UnionpayController {
	@RequestMapping("payFrontRes")
	public void payFrontRes(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding(QuickPayConf.charset);
		} catch (UnsupportedEncodingException e) {
		}

		String[] resArr = new String[QuickPayConf.notifyVo.length];
		for (int i = 0; i < QuickPayConf.notifyVo.length; i++) {
			resArr[i] = request.getParameter(QuickPayConf.notifyVo[i]);
		}
		String signature = request.getParameter(QuickPayConf.signature);
		String signMethod = request.getParameter(QuickPayConf.signMethod);

		response.setContentType("text/html;charset=" + QuickPayConf.charset);
		response.setCharacterEncoding(QuickPayConf.charset);

		try {
			Boolean signatureCheck = new QuickPayUtils().checkSign(resArr, signMethod, signature);
			response.getWriter().append("建议前台通知和后台通知用两个类实现，后台通知进行商户的数据库等处理,前台通知实现客户浏览器跳转<br>").append("签名是否正确：" + signatureCheck).append("<br>交易是否成功：" + "00".equals(resArr[10]));
			if (!"00".equals(resArr[10])) {
				response.getWriter().append("<br>失败原因:" + resArr[11]);
			}
		} catch (IOException e) {

		}

		response.setStatus(HttpServletResponse.SC_OK);
	}

	@RequestMapping("payBackRes")
	public void payBackRes(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding(QuickPayConf.charset);
		} catch (UnsupportedEncodingException e) {
		}

		String[] resArr = new String[QuickPayConf.notifyVo.length];
		for (int i = 0; i < QuickPayConf.notifyVo.length; i++) {
			resArr[i] = request.getParameter(QuickPayConf.notifyVo[i]);
		}
		String signature = request.getParameter(QuickPayConf.signature);
		String signMethod = request.getParameter(QuickPayConf.signMethod);

		response.setContentType("text/html;charset=" + QuickPayConf.charset);
		response.setCharacterEncoding(QuickPayConf.charset);

		try {
			Boolean signatureCheck = new QuickPayUtils().checkSign(resArr, signMethod, signature);
			response.getWriter().append("建议前台通知和后台通知用两个类实现，后台通知进行商户的数据库等处理,前台通知实现客户浏览器跳转<br>").append("签名是否正确：" + signatureCheck).append("<br>交易是否成功：" + "00".equals(resArr[10]));
			if (!"00".equals(resArr[10])) {
				response.getWriter().append("<br>失败原因:" + resArr[11]);
			}
		} catch (IOException e) {

		}

		response.setStatus(HttpServletResponse.SC_OK);
	}

	int i = 0;

	@RequestMapping("craeteTest")
	public void craeteTest(HttpServletRequest request, HttpServletResponse response) {
		// 商户需要组装如下对象的数据
		String[] valueVo = new String[] { QuickPayConf.version,// 协议版本
				QuickPayConf.charset,// 字符编码
				"01",// 交易类型
				"",// 原始交易流水号
				QuickPayConf.merCode,// 商户代码
				QuickPayConf.merName,// 商户简称
				"",// 收单机构代码（仅收单机构接入需要填写）
				"",// 商户类别（收单机构接入需要填写）
				"http://218.80.192.2231/shop1/payment/quickpay/quickpay_result.php?payid=123456&dd=123",// 商品URL
				"物品名称如短袖",// 商品名称
				"3000",// 商品单价 单位：分
				"1",// 商品数量
				"0",// 折扣 单位：分
				"1000",// 运费 单位：分
				new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + (++i),// 订单号（需要商户自己生成）
				"3100",// 交易金额 单位：分
				"156",// 交易币种
				"20110523194505",// 交易时间
				"127.0.0.1",// 用户IP
				"张三",// 用户真实姓名
				"",// 默认支付方式
				"",// 默认银行编号
				"120000",// 交易超时时间
				QuickPayConf.merFrontEndUrl,// 前台回调商户URL
				QuickPayConf.merBackEndUrl,// 后台回调商户URL
				""// 商户保留域
		};

		/*
		 * 说明：以下代码直接返回跳转到银联在线支付页面字符串 new QuickPayUtils().createPayHtml(valueVo)
		 */
		String html = new QuickPayUtils().createPayHtml(valueVo);// 跳转到银联页面支付

		/*
		 * 说明：以下代码直接返回跳转到银行支付页面字符串
		 * 目前:支持工行(ICBC)，农行(ABC)，中行(BOC)，建行(CCB)，招行(CMB)，广发(GDB)，浦发(SPDB) new
		 * QuickPayUtils().createPayHtml(valueVo, "CCB")
		 */
		// String html = new QuickPayUtils().createPayHtml(valueVo,
		// "CCB");//直接跳转到网银页面支付
		response.setContentType("text/html;charset=" + QuickPayConf.charset);
		response.setCharacterEncoding(QuickPayConf.charset);
		try {
			response.getWriter().write(html);
		} catch (IOException e) {

		}
		response.setStatus(HttpServletResponse.SC_OK);
	}
}
