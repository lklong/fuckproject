package com.zhigu.service.alibaba;

import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import com.zhigu.common.alibaba.AlibabaConfig;

public interface AliDeliveryAddressService extends AlibabaConfig {

	public ArrayList<Map<String, Object>> getSendAddressList(String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	public ArrayList<Map<String, Object>> getDeliveryTemplateList(String token) throws InterruptedException, ExecutionException, TimeoutException;

}
