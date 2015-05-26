/**
 * 
 */
package com.zhigu.service.alibaba.impl;

import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import org.springframework.stereotype.Service;

import com.alibaba.openapi.client.Request;
import com.zhigu.common.alibaba.AlibabaUtil;
import com.zhigu.service.alibaba.AliDeliveryAddressService;

/**
 * @author lkl
 *
 */
@Service
public class AliDeliveryAddressServiceImpl implements AliDeliveryAddressService {

	/**
	 * 本接口实现获取指定会员在阿里巴巴中文站上的发货地址列表信息(只能查自己的信息)
	 * 
	 * @param accessToken
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	@SuppressWarnings("unchecked")
	public ArrayList<Map<String, Object>> getSendAddressList(String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "trade.freight.sendGoodsAddressList.get", VERSION);

		apiRequest.setParam("returnFields", "deliveryAddressId,address");

		Map<String, Object> object = AlibabaUtil.callAPI(accessToken, apiRequest, Map.class, true, true);

		return AlibabaUtil.getReturnFromMap(object);
	}

	/**
	 * 用户运费模板列表描述查询
	 * 
	 * @param token
	 * @return templateId,templateName
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	@SuppressWarnings("unchecked")
	public ArrayList<Map<String, Object>> getDeliveryTemplateList(String token) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "e56.delivery.template.list", VERSION);

		Map<String, Object> map = AlibabaUtil.callAPI(token, apiRequest, Map.class, true, true);

		ArrayList<Map<String, Object>> templates = (ArrayList<Map<String, Object>>) map.get("result");

		return templates;
	}

}
