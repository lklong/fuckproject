package com.zhigu.service.alibaba.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.alibaba.openapi.client.Request;
import com.zhigu.common.alibaba.AlibabaUtil;
import com.zhigu.common.alibaba.HttpRequestUtil;
import com.zhigu.service.alibaba.AliItemPropService;

@Service
public class AliItemPropServiceImpl implements AliItemPropService {

	/**
	 * 获取交易属性
	 * 
	 * @param cid
	 * @param accessToken
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<Map<String, Object>> getCateTradeProps(Long cid, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "tradeAttributes.get", VERSION);

		apiRequest.setParam("categoryID", cid);

		Map<String, Object> result = AlibabaUtil.callAPI(accessToken, apiRequest, LinkedHashMap.class, false, true);

		return AlibabaUtil.getReturnFromMap(result);

	}

	/**
	 * 根据叶子类目ID获取类目发布属性信息
	 * 
	 * @param cid
	 * @param accessToken
	 * @return
	 * @throws TimeoutException
	 * @throws ExecutionException
	 * @throws InterruptedException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<Map<String, Object>> getItemCateProps(Long cid, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "offerPostFeatures.get", VERSION);

		apiRequest.setParam("categoryID", cid);

		Map<String, Object> result = AlibabaUtil.callAPI(accessToken, apiRequest, LinkedHashMap.class, false, false);

		return AlibabaUtil.getReturnFromMap(result);

	}

	/**
	 * 本接口实现通过数据接口的形式，通过输入用户填写的某个类目关键产品属性，返回该类目产品属性的SPU信息
	 * 
	 * @param cid
	 * @param accessToken
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 *             keyAttributes String 产品关键属性和值，以“>”为分隔符， 输入格式如示例 ：
	 *             属性:属性值>属性:属性值 2176:BARDEN>3151:01B114EX
	 */
	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<Map<String, Object>> getItemCateSPUProps(Long cid, String keyAttributes, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "offerPostFeatures.get", VERSION);

		apiRequest.setParam("categoryID", cid);

		apiRequest.setParam("keyAttributes", keyAttributes);

		Map<String, Object> result = AlibabaUtil.callAPI(accessToken, apiRequest, LinkedHashMap.class, false, false);

		return AlibabaUtil.getReturnFromMap(result);

	}

	// http://spu.1688.com/spu/ajax/getLevelInfoByPath.htm?callback=jQuery&catId=1034340&pathValues=2600%3A20533
	public JSONArray getChildrenProps(Long catId, String pathValues) throws UnsupportedEncodingException {

		String url = "http://spu.1688.com/spu/ajax/getLevelInfoByPath.htm?callback=jQuery&";

		pathValues = URLEncoder.encode(pathValues, "utf-8");

		// 获取请求URL及url后面传输的参数
		url = url + "catId=" + catId + "&pathValues=" + pathValues;

		JSONObject json = HttpRequestUtil.httpGet(url);

		return (JSONArray) json.get("data");

	}

}
