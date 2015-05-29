/**
 * @ClassName: ITaobaoTokenService.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月27日
 * 
 */
package com.zhigu.service.taobao;

import com.zhigu.common.exception.ServiceException;
import com.zhigu.model.TaobaoToken;

/**
 * @author Administrator
 * 
 * @description 处理用户的授权信息
 */
public interface ITaobaoTokenService {

	int insertSelective(TaobaoToken taobaoToken);

	TaobaoToken getTaobaoTokenByCode(int userId, String code, int goodsId);

	/**
	 * @param userId
	 * @param goodsId
	 * @return
	 */
	TaobaoToken getTaobaoTokenByUserId(int userId);

	/**
	 * @param token
	 */
	int updateSelective(TaobaoToken token);

	/**
	 * @param code
	 * @param userId
	 * @return
	 */
	String getToken(String code, Integer userId) throws ServiceException;

}
