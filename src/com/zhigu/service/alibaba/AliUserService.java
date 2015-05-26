package com.zhigu.service.alibaba;

import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import com.zhigu.common.alibaba.AlibabaConfig;

public interface AliUserService extends AlibabaConfig {

	String APIMETHOD = "member.get";

	/**
	 * 获取单个阿里巴阿中国网站会员信息。非会员本人只返回非隐私数据
	 * 
	 * @param token
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	Map<String, Object> getUser(String code) throws InterruptedException, ExecutionException, TimeoutException;

}
