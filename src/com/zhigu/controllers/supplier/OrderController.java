package com.zhigu.controllers.supplier;

import java.text.ParseException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.Order;
import com.zhigu.model.OrderCondition;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IOrderService;

/**
 * 网商订单
 * 
 * @author zhouqibing 2014年8月10日下午1:53:37
 */
@Controller("supplierOrder")
@RequestMapping("/supplier/order")
public class OrderController {
	@Autowired
	private IOrderService orderService;

	/**
	 * 网站查看订单详情
	 * 
	 * @param mv
	 * @param orderID
	 * @return
	 */
	@RequestMapping("/detail")
	public ModelAndView detail(ModelAndView mv, Integer orderID) {
		Order order = orderService.queryOrder(orderID);
		// 非网商订单
		if (order != null && order.getStoreUserID() == SessionHelper.getSessionUser().getUserID())
			mv.addObject("order", order);
		mv.setViewName("/supplier/order/detail");
		return mv;
	}

	/**
	 * 网商订单
	 * 
	 * @param mv
	 * @param od
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("")
	public ModelAndView list(ModelAndView mv, OrderCondition oc, String startDateStr, String endDateStr, PageBean<Order> page) throws ParseException {
		oc.setUserID(SessionHelper.getSessionUser().getUserID());
		oc.setUserType(2);
		page.setPageSize(10);
		if (StringUtils.isNotBlank(startDateStr)) {
			oc.setStartDate(DateUtils.parseDate(startDateStr, "yyyy-MM-dd"));
		}
		if (StringUtils.isNotBlank(endDateStr)) {
			oc.setEndDate(DateUtils.parseDate(endDateStr, "yyyy-MM-dd"));
		}
		mv.addObject("orders", orderService.queryOrders(page, oc));
		mv.addObject("page", page);
		mv.setViewName("/supplier/order/list");
		mv.addObject("oc", oc);
		return mv;
	}

	/**
	 * 修改订单金额
	 * 
	 * @return
	 */
	@RequestMapping("/modifyOrderMoney")
	@ResponseBody
	public MsgBean modifyOrderMoney(int orderID, String money) {

		return new MsgBean(Code.FAIL, "不能修改订单金额", MsgLevel.ERROR);
	}
}
