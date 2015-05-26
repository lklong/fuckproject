package com.zhigu.controllers.mobile.common;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mobile.com.alipay.util.AlipayNotify;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zhigu.model.RechargeRecord;
import com.zhigu.service.user.IAccountService;

@Controller
public class MobileAlipayController {
	@Autowired
	private IAccountService accountService;

	/**
	 * 支付宝充值异步通知
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/mobile/recharge/alipay/notify")
	public void alipayNotify(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 获取支付宝POST过来反馈信息
		Map<String, String> params = new HashMap<String, String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
			}
			// 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			// valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
			params.put(name, valueStr);
		}

		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
		// 商户订单号
		String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"), "UTF-8");
		// 支付宝交易号
		String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"), "UTF-8");
		// 交易状态
		String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"), "UTF-8");
		// 卖家支付宝账号
		String buyer_email = new String(request.getParameter("buyer_email").getBytes("ISO-8859-1"), "UTF-8");
		// 交易金额
		String total_fee = new String(request.getParameter("total_fee").getBytes("ISO-8859-1"), "UTF-8");

		if (AlipayNotify.verify(params)) {// 验证成功
			RechargeRecord rr = accountService.queryRechargeRecord(out_trade_no);
			if (rr.getStatus() == 1) {// 充值成功
				response.getWriter().println("success");
				return;
			}
			if (rr.getRechargeMoney().compareTo(new BigDecimal(total_fee)) != 0) {
				// 淘宝返回的金额和订单金额不一致
				response.getWriter().println("fail");
			}

			if (trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")) {
				rr.setExternalNo(trade_no);
				rr.setRechargeAcc(buyer_email);
				accountService.updateRechargeSuccess(rr);
			}

			response.getWriter().println("success"); // 请不要修改或删除

		} else {// 验证失败
			response.getWriter().println("fail");
		}
	}
}
