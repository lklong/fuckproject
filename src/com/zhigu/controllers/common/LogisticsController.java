package com.zhigu.controllers.common;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.constant.enumconst.OrderStatus;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.logistics.Querier;
import com.zhigu.model.Order;
import com.zhigu.service.user.IOrderService;

/**
 * 物流查询
 * 
 * @author zhouqibing 2014年8月18日下午2:43:17
 */
@Controller
@RequestMapping("/logistics")
public class LogisticsController {
	@Autowired
	private IOrderService orderService;

	@RequestMapping("/query")
	@ResponseBody
	public String query(@RequestParam Integer orderID) {
		Order order = orderService.queryOrder(orderID);
		String progress = "[]";
		if (!StringUtil.isEmpty(order.getLogisticsCode(), order.getLogisticsNO())) {
			if (order.getStatus() == OrderStatus.ORDER_SUCCESS.getValue() && StringUtil.isEmpty(order.getLogisticsProgress())) {
				JSONObject json = Querier.query(order.getLogisticsCode(), order.getLogisticsNO());
				if (json.getInt("status") == 3 || json.getInt("status") == 3) {
					progress = json.getJSONArray("data").toString();
					order.setLogisticsProgress(progress);
					orderService.updateOrder(order);
				}
				return progress;
			} else if (order.getStatus() == OrderStatus.ORDER_WAIT_CONFIRM_RECEIVE_GOODS.getValue()) {
				progress = Querier.queryProgress(order.getLogisticsCode(), order.getLogisticsNO()).toString();
			}
		}

		return progress;
	}
}
