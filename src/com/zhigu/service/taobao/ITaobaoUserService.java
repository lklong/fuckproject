/**
 * @ClassName: ITaobaoUserService.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月27日
 * 
 */
package com.zhigu.service.taobao;

import com.zhigu.model.TaobaoUser;

/**
 * @author Administrator
 * 
 * @decription 处理淘宝用户基本信息存储到平台
 *
 */
public interface ITaobaoUserService {

	int insertSelective(TaobaoUser user);

	/**
	 * @param userId
	 * @return
	 */
	TaobaoUser selectByUserId(Long userId);

}
