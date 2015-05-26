package com.zhigu.controllers.admin;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionAdmin;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.model.Order;
import com.zhigu.model.OrderCondition;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IOrderService;

/**
 * 订单管理
 * 
 * @author zhouqibing 2014年8月16日下午4:02:21
 */
@Controller("adminOrderController")
@RequestMapping("/admin/order")
public class OrderController {
	@Autowired
	private IOrderService orderService;

	/**
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public ModelAndView index(PageBean<Order> page, OrderCondition oc, ModelAndView mv) {
		SessionAdmin au = SessionHelper.getSessionAdmin();
		if (au.getRoleId() != 1)
			oc.setStaffID(au.getId());
		page.setDatas(orderService.queryOrders(page, oc));
		mv.addObject("page", page);
		mv.addObject("orders", page.getDatas());
		mv.addObject("oc", oc);
		mv.setViewName("admin/order/index");

		// 订单统计
		Map<String, Object> stat = orderService.queryStatusCount(null, null);
		mv.addObject("stat", stat);

		return mv;
	}

	/**
	 * 所有订单
	 * 
	 * @param page
	 * @param oc
	 * @param mv
	 * @return
	 */
	@RequestMapping("/allList")
	public ModelAndView allList(PageBean<Order> page, OrderCondition oc, ModelAndView mv) {
		page.setDatas(orderService.queryOrders(page, oc));
		mv.addObject("page", page);
		mv.addObject("orders", page.getDatas());
		mv.addObject("oc", oc);
		mv.setViewName("admin/order/index");
		// 订单统计
		Map<String, Object> stat = orderService.queryStatusCount(null, null);
		mv.addObject("stat", stat);
		return mv;
	}

	/**
	 * 订单详情
	 * 
	 * @param orderID
	 * @return
	 */
	@RequestMapping("/detail")
	public ModelAndView detail(ModelAndView mv, Integer orderID) {

		Order order = orderService.queryOrder(orderID);
		if (order == null) {
			throw new ServiceException("未找到订单！");
		}
		mv.addObject("order", order);

		mv.setViewName("admin/order/detail");
		return mv;
	}

	/**
	 * 发货
	 * 
	 * @param orderID
	 * @return
	 */
	@RequestMapping("/sendOrderGood")
	@ResponseBody
	public MsgBean sendOrderGood(int orderId, String expressNo) {
		return orderService.handlerGoodsSendConfirm(orderId, expressNo, true);
	}

	/**
	 * 修改物流价格
	 * 
	 * @param oid
	 * @param money
	 * @return
	 */
	@RequestMapping("/modifyMoney")
	@ResponseBody
	public MsgBean modifyMoney(Integer oid, String money) {
		return orderService.modifyMoney(oid, money, true);
	}

}
