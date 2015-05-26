package com.zhigu.service.open;

import com.zhigu.model.OpenAuth;
import com.zhigu.model.dto.MsgBean;

/**
 * 第三方服务
 * 
 * @author zhouqibing 2014年7月21日下午2:25:07
 */
public interface IOpenAuthService {
	/**
	 * 保存第三方认证信息
	 * 
	 * @return
	 */
	public MsgBean saveOpenAuth(String userName, String password, String openID);

	/**
	 * 查询第三方认证信息
	 * 
	 * @param openID
	 * @return
	 */
	public OpenAuth queryOpenAuthByOpenID(String openID);
}
