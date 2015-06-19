package com.zhigu.controllers.user;

import java.io.IOException;
import java.rmi.ServerException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipayNotify;
import com.alipay.util.AlipaySubmit;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.RechargeStatus;
import com.zhigu.common.constant.RechargeType;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.model.RechargeRecord;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IUserService;

/**
 * 充值
 * 
 */
@Controller
public class RechargeController {
	private Logger logger = Logger.getLogger(RechargeController.class);
	@Autowired
	private IAccountService accountService;
	@Autowired
	private IUserService userService;

	/**
	 * 充值
	 * 
	 * @return
	 */
	@RequestMapping("/user/recharge")
	public ModelAndView recharge(ModelAndView mv) {
		mv.setViewName("user/acc/recharge");
		boolean hasPaypasswd = StringUtils.isNotBlank(accountService.queryAccountByUserID(SessionHelper.getSessionUser().getUserId()).getPayPasswd());
		mv.addObject("hasPaypasswd", hasPaypasswd);
		mv.addObject("auth", userService.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserId()));
		return mv;
	}

	/**
	 * 重新充值
	 * 
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/user/repayent")
	public void repayent(Integer rechargeId, HttpServletResponse response) throws IOException {
		RechargeRecord rr = accountService.queryRechargeRecord(rechargeId);
		if (rr != null) {
			if (rr.getStatus() != RechargeStatus.WAITING_PAY) {
				throw new ServerException("支付状态错误");
			}
			response.getWriter().print(createAlipayForm(rr));
		}
	}

	/**
	 * 充值支付
	 * 
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/user/recharge/pay")
	public void pay(int rechargeType, String money, HttpServletResponse response) throws IOException {
		if (rechargeType == RechargeType.ALIPAY) {
			RechargeRecord rr = (RechargeRecord) accountService.saveRechargeRecord(rechargeType, money).getData();
			response.getWriter().print(createAlipayForm(rr));
		} else {
			throw new ServiceException("不支持的充值类型");
		}
	}

	/**
	 * 创建支付宝支付表单
	 * 
	 * @param rr
	 * @return
	 */
	private String createAlipayForm(RechargeRecord rr) {
		// 把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "create_direct_pay_by_user");
		sParaTemp.put("partner", AlipayConfig.partner);
		sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("payment_type", AlipayConfig.payment_type);
		sParaTemp.put("notify_url", AlipayConfig.notify_url);
		sParaTemp.put("return_url", AlipayConfig.return_url);
		sParaTemp.put("seller_email", AlipayConfig.seller_email);
		sParaTemp.put("subject", AlipayConfig.subject);
		sParaTemp.put("out_trade_no", rr.getPaymentNo());// 内部充值订单号
		sParaTemp.put("total_fee", rr.getRechargeMoney().toString());
		// 建立请求
		return AlipaySubmit.buildRequest(sParaTemp, "post", "确认");
	}

	/**
	 * 支付宝充值异步通知
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/recharge/alipay/notify")
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
		// 商户订单号
		String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"), "UTF-8");
		// 支付宝交易号
		String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"), "UTF-8");
		// 交易状态
		String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"), "UTF-8");
		// 支付宝账户
		String buyer_email = new String(request.getParameter("buyer_email").getBytes("ISO-8859-1"), "UTF-8");
		if (logger.isInfoEnabled()) {
			logger.info("支付宝异步通知........商户订单号：" + out_trade_no + "支付宝交易号:" + trade_no + "交易状态：" + trade_status + "支付宝账户：" + buyer_email);
		}
		if (AlipayNotify.verify(params)) {// 验证成功

			RechargeRecord rr = accountService.queryRechargeRecord(out_trade_no);
			if (rr.getStatus() == 1) {// 充值成功
				response.getWriter().println("success");
				return;
			}
			// 请在这里加上商户的业务逻辑程序代码
			if (trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")) {
				rr.setExternalNo(trade_no);
				rr.setRechargeAcc(buyer_email);
				accountService.updateRechargeSuccess(rr);
			}
			response.getWriter().println("success"); // 请不要修改或删除

		} else {// 验证失败
			if (logger.isInfoEnabled()) {
				logger.info("支付宝异步通知........验证失败！");
			}
			response.getWriter().println("fail");
		}
	}
}
