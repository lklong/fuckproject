package com.zhigu.mapper;

import com.zhigu.model.OpenAuth;

/**
 * 
 * @author zhouqibing 2014年7月21日下午5:30:19
 */
public interface OpenAuthMapper {
	/**
	 * 保存第三方认证信息
	 * 
	 * @return
	 */
	public int saveOpenAuth(OpenAuth auth);

	/**
	 * 查询第三方认证信息
	 * 
	 * @param openID
	 * @return
	 */
	public OpenAuth queryOpenAuthByOpenID(String openID);
}
