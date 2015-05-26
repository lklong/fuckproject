package com.zhigu.service.admin;

import java.util.Map;

/**
 * 统计
 * @author zhouqibing
 * 2014年9月12日上午9:41:01
 */
public interface IStatService {
	/**
	 * 会员统计
	 * @return
	 */
	public Map<String, Object> statMember();
	/**
	 * 商品统计
	 * @return
	 */
	public Map<String, Object> statCommodity();
	/**
	 * 充值统计
	 * @return
	 */
	public Map<String, Object> statRecharge();
	/**
	 * 订单统计
	 * @return
	 */
	public Map<String, Object> statOrder();
	
	
}
