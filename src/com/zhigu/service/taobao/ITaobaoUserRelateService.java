/**
 * 
 */
package com.zhigu.service.taobao;

import java.util.List;

import com.taobao.api.ApiException;
import com.taobao.api.domain.DeliveryTemplate;
import com.taobao.api.domain.SellerCat;
import com.taobao.api.domain.User;

/**
 * @author Administrator
 *
 */
public interface ITaobaoUserRelateService {
	
	/**
	 * 获取用户店铺目录
	 * 
	 * @param nick
	 * @return
	 * @throws ApiException
	 */
	public List<SellerCat> getSellerCats(String nick) throws ApiException;

	/**
	 * 获取用户信息
	 * 
	 * @param access_token
	 * @return
	 * @throws ApiException
	 */
	public User getUser(String access_token) throws ApiException;

	/**
	 * 获取用户模板
	 * 
	 * @param access_token
	 * @return
	 * @throws ApiException
	 */
	public List<DeliveryTemplate> getDeliveryTemplate(String access_token) throws ApiException;
	
	

}
