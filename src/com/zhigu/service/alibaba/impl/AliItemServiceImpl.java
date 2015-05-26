package com.zhigu.service.alibaba.impl;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import org.springframework.stereotype.Service;

import com.alibaba.openapi.client.Request;
import com.zhigu.common.alibaba.AlibabaUtil;
import com.zhigu.service.alibaba.AliItemService;

@Service
public class AliItemServiceImpl implements AliItemService {

	@SuppressWarnings("unchecked")
	@Override
	public String addAlibabaItem(String json, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, APIMETHOD, VERSION);

		// 需要传递的参数，如复杂结构，则需要传递合法的json串，如["1","2"],{"key":"value"}
		// apiRequest.setParam("offer", json);

		apiRequest.setParam("offer", json);

		Map<String, Object> object = AlibabaUtil.callAPI(accessToken, apiRequest, Map.class, true, true);

		return (((List<String>) ((Map<String, Object>) object.get("result")).get("toReturn")).get(0));

	}
}
