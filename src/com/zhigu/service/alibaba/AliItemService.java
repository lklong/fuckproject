package com.zhigu.service.alibaba;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import com.zhigu.common.alibaba.AlibabaConfig;

public interface AliItemService extends AlibabaConfig {

	String addAlibabaItem(String json, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	String APIMETHOD = "offer.new";

}
