/**
 * 
 */
package com.zhigu.service.alibaba.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import org.springframework.stereotype.Service;

import com.alibaba.openapi.client.Request;
import com.alibaba.openapi.client.auth.AuthorizationToken;
import com.alibaba.openapi.client.auth.DefaultAuthorizationTokenStore;
import com.zhigu.common.alibaba.AlibabaUtil;
import com.zhigu.service.alibaba.AliUserService;

/**
 * @author lkl
 *
 */
@Service
public class AliUserServiceImpl implements AliUserService {
	// [result={total=1, toReturn=[{loginId=aliliukl,
	// createTime=20150311223815000+0800, sex=先生, isMobileVerify=false,
	// isMobileBind=false, isEmailBind=true, isEnterpriseTP=false,
	// isMarketTP=false, trustScore=0, addressLocation={address=二环路22号,
	// province=四川, district=成都市金牛区, country=中国, city=成都}, isPersonalTP=false,
	// industry=男装, isDistribution=false, fax=, status=enabled, sellerName=刘开龙,
	// havePrecharge=true, companyName=刘开龙的阿里, product=服装 服装, haveSite=false,
	// haveDistribution=true, lastLogin=20150320222922000+0800, isETCTP=false,
	// isPrecharge=false, isEmailVerify=true, memberId=b2b-2459945043,
	// verifyStatus=Y.E, isTP=false, telephone=86 028 55653424}], success=true}]

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> getUser(String code) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, APIMETHOD, VERSION);

		DefaultAuthorizationTokenStore store = AlibabaUtil.getStore();

		AuthorizationToken auth = store.getToken(code);

		String memberId = auth.getMemberId();

		String token = auth.getAccess_token();

		apiRequest.setParam("memberId", memberId);

		Map<String, Object> object = AlibabaUtil.callAPI(token, apiRequest, HashMap.class, false, true);

		return AlibabaUtil.getReturnFromMap(object).get(0);

	}

}
