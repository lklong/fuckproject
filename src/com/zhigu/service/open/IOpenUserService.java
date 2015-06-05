package com.zhigu.service.open;

import com.zhigu.model.OpenUser;
import com.zhigu.model.dto.MsgBean;

/**
 * 第三方服务
 * 
 * @author zhouqibing 2014年7月21日下午2:25:07
 */
public interface IOpenUserService {
	/**
	 * 保存第三方认证信息
	 * 
	 * @return
	 */
	public MsgBean saveOpenUser(String userName, String password, String openId);

	/**
	 * 查询第三方认证信息
	 * 
	 * @param openID
	 * @return
	 */
	public OpenUser queryOpenUserByOpenId(String openId);
}
