package com.zhigu.service.admin;

import java.util.Map;

/**
 * 后台会员订单管理
 * @author zhouqibing
 * 2014年9月2日下午1:50:24
 */
public interface IAdminOrderService {
	/**
	 * 会员订单统计
	 * @param memberID
	 * @return
	 */
	public Map<String, Object> memberOrderStat(Integer memberID);
}
