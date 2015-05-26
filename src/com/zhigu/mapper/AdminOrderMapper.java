package com.zhigu.mapper;

import java.util.Map;

/**
 * 后台订单
 * 
 * @author zhouqibing 2014年9月2日下午1:41:30
 */
public interface AdminOrderMapper {
	/**
	 * 会员订单统计
	 * 
	 * @param memberID
	 * @return
	 */
	public Map<String, Object> memberOrderStatByMemberID(Integer memberID);
}
