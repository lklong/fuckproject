package com.zhigu.mapper;

import java.util.Map;

/**
 * 统计
 * 
 * @author zhouqibing 2014年9月12日上午9:48:05
 */
public interface StatMapper {
	/**
	 * 会员统计
	 * 
	 * @return
	 */
	public Map<String, Object> statMember();

	/**
	 * 商品统计
	 * 
	 * @return
	 */
	public Map<String, Object> statCommodity();

	/**
	 * 充值统计
	 * 
	 * @return
	 */
	public Map<String, Object> statRecharge();

	/**
	 * 订单统计
	 * 
	 * @return
	 */
	public Map<String, Object> statOrder();

}
