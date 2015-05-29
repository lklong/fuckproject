/**
 * 
 */
package com.zhigu.service.taobao.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.domain.DeliveryTemplate;
import com.taobao.api.domain.SellerCat;
import com.taobao.api.domain.User;
import com.taobao.api.request.DeliveryTemplatesGetRequest;
import com.taobao.api.request.SellercatsListGetRequest;
import com.taobao.api.request.UserSellerGetRequest;
import com.taobao.api.response.DeliveryTemplatesGetResponse;
import com.taobao.api.response.SellercatsListGetResponse;
import com.taobao.api.response.UserSellerGetResponse;
import com.zhigu.common.taobao.TaobaoConfig;
import com.zhigu.model.TaobaoUser;
import com.zhigu.service.taobao.ITaobaoUserRelateService;
import com.zhigu.service.taobao.ITaobaoUserService;

/**
 * 用户相关信息业务
 * 
 * @author Administrator
 *
 */
@Service
public class TaobaoUserRelateServiceImpl implements ITaobaoUserRelateService {

	private static final Logger LOGGER = Logger.getLogger(TaobaoUserRelateServiceImpl.class);

	private static final TaobaoClient client = new DefaultTaobaoClient(TaobaoConfig.API_URL, TaobaoConfig.APP_KEY, TaobaoConfig.APP_SECRET);

	@Autowired
	private ITaobaoUserService taobaoUserService;

	/**
	 * 获取用户店铺目录
	 * 
	 * @param nick
	 * @return
	 * @throws ApiException
	 */
	public List<SellerCat> getSellerCats(String nick) throws ApiException {

		SellercatsListGetRequest req = new SellercatsListGetRequest();

		req.setNick(nick);

		SellercatsListGetResponse response = client.execute(req);

		return response.getSellerCats();

	}

	/**
	 * 获取用户信息
	 * 
	 * @param access_token
	 * @return
	 * @throws ApiException
	 */
	public User getUser(String access_token) throws ApiException {

		UserSellerGetRequest req = new UserSellerGetRequest();

		req.setFields("user_id,nick,sex,seller_credit,type,has_more_pic,item_img_num,item_img_size,prop_img_num,prop_img_size,auto_repost,promoted_type,status,alipay_bind,consumer_protection,avatar,liangpin,sign_food_seller_promise,has_shop,is_lightning_consignment,has_sub_stock,is_golden_seller,vip_info,magazine_subscribe,vertical_market,online_gaming");

		UserSellerGetResponse response = client.execute(req, access_token);

		if (response.isSuccess()) {

			User user = response.getUser();

			TaobaoUser taobaoUser = taobaoUserService.selectByUserId(user.getUserId());

			if (taobaoUser == null) {

				DateConverter converter = new DateConverter(null);

				ConvertUtils.register(converter, java.util.Date.class);

				taobaoUser = new TaobaoUser();

				try {

					BeanUtils.copyProperties(taobaoUser, user);

					taobaoUserService.insertSelective(taobaoUser);

				} catch (IllegalAccessException e) {
					LOGGER.error("属性copy错误1：" + e.getMessage());
				} catch (InvocationTargetException e) {
					LOGGER.error("属性copy错误2：" + e.getMessage());
				}
			}
		}

		return response.getUser();

	}

	/**
	 * 获取用户模板
	 * 
	 * @param access_token
	 * @return
	 * @throws ApiException
	 */
	public List<DeliveryTemplate> getDeliveryTemplate(String access_token) throws ApiException {

		DeliveryTemplatesGetRequest req = new DeliveryTemplatesGetRequest();

		req.setFields("template_id,template_name,created,modified,supports,assumer,valuation,query_express,query_ems,query_cod,query_post");

		DeliveryTemplatesGetResponse response = client.execute(req, access_token);

		return response.getDeliveryTemplates();

	}

}
