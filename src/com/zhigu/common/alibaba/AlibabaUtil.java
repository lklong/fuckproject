/**
 * 
 */
package com.zhigu.common.alibaba;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import org.apache.commons.lang.StringUtils;

import com.alibaba.openapi.client.AlibabaClient;
import com.alibaba.openapi.client.Request;
import com.alibaba.openapi.client.auth.AuthorizationToken;
import com.alibaba.openapi.client.auth.DefaultAuthorizationTokenStore;
import com.alibaba.openapi.client.policy.ClientPolicy;
import com.alibaba.openapi.client.policy.RequestPolicy;

/**
 * @author lkl
 *
 */
public class AlibabaUtil {

	/** 缓存token */
	private static DefaultAuthorizationTokenStore store = new DefaultAuthorizationTokenStore();

	/** 临时缓存token */
	private static Map<String, String> tokenMap = new HashMap<String, String>();

	public static Map<String, String> getTokenMap() {
		return tokenMap;
	}

	public static void setTokenMap(Map<String, String> tokenMap) {
		AlibabaUtil.tokenMap = tokenMap;
	}

	public static DefaultAuthorizationTokenStore getStore() {
		return store;
	}

	public static void setStore(DefaultAuthorizationTokenStore store) {
		AlibabaUtil.store = store;
	}

	public static AlibabaClient getClient() {
		// 使用默认的client策略，包括使用域名gw.open.1688.com,端口http 80，https443等
		ClientPolicy policy = ClientPolicy.getDefaultChinaAlibabaPolicy();
		// 设置app的appKey以及对应的密钥，信息由注册app时生成
		policy = policy.setAppKey(AlibabaConfig.client_id).setSigningKey(AlibabaConfig.secret_key);
		// 使用client策略来初始化AlibabaClient,建议保持单例
		AlibabaClient client = new AlibabaClient(policy);
		// 启动AlibabaClient实例
		return client;
	}

	public static void shutDownClient(AlibabaClient client) {

		if (client != null) {
			client.shutdown();
		}

	}

	/**
	 * 获取token,如果有用户授权信息则刷新token,并临时缓存
	 * 
	 * @param code
	 * @param goodsId
	 * @return
	 * @throws IOException
	 */
	public static String getToken(String code) throws IOException {

		DefaultAuthorizationTokenStore store = new DefaultAuthorizationTokenStore();

		AlibabaClient client = getClient();

		client.start();

		String token = tokenMap.get(code);

		String refresh_token = null;

		String access_token = null;

		AuthorizationToken authorizationToken = null;

		if (StringUtils.isBlank(token)) {

			authorizationToken = client.getToken(code, 3000);

		} else {

			refresh_token = tokenMap.get(tokenMap.get(code));

			if (StringUtils.isBlank(refresh_token)) {

				return tokenMap.get(code);
			}

			authorizationToken = client.refreshToken(refresh_token, 3000);

		}

		access_token = authorizationToken.getAccess_token();

		refresh_token = authorizationToken.getRefresh_token();

		tokenMap.put(code, access_token);

		tokenMap.put(access_token, refresh_token);

		client.shutdown();

		return access_token;

	}

	public static String getTokenFromStore(String code) throws IOException {

		AlibabaClient client = getClient();

		client.start();

		AuthorizationToken authorizationToken = store.getToken(code);

		String refresh_token = null;

		String access_token = null;

		if (authorizationToken == null) {

			authorizationToken = client.getToken(code, 3000);

		} else {

			refresh_token = authorizationToken.getRefresh_token();

			if (StringUtils.isBlank(refresh_token)) {

				return authorizationToken.getAccess_token();

			}

			authorizationToken = client.refreshToken(refresh_token, 3000);

		}

		access_token = authorizationToken.getAccess_token();

		refresh_token = authorizationToken.getRefresh_token();

		store.storeToken(code, authorizationToken);

		client.shutdown();

		return access_token;

	}

	/**
	 * 获取code的url组装
	 * 
	 * @return
	 */
	public static String getCodeUrl(String state) {

		Map<String, String> params = new HashMap<String, String>();

		params.put("client_id", AlibabaConfig.client_id);

		params.put("site", AlibabaConfig.site);

		if (StringUtils.isNotBlank(state)) {

			params.put("state", state);

		}

		params.put("redirect_uri", AlibabaConfig.redirect_uri);

		String _aop_signature = CommonUtil.signatureWithParamsOnly(params, AlibabaConfig.secret_key);

		params.put("_aop_signature", _aop_signature);

		String urlpath = CommonUtil.getWholeUrl(AlibabaConfig.code_url, params);

		return urlpath;

	}

	/**
	 * api调用
	 * 
	 * @param <T>
	 * @param accessToken
	 * @param apiMethod
	 * @param apiRequest
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 *             return object
	 */
	@Deprecated
	public static <T> T callAPI(String accessToken, Request apiRequest, Class<T> t, boolean needAuth) throws InterruptedException, ExecutionException, TimeoutException {

		AlibabaClient client = getClient();

		client.start();
		T result = null;

		RequestPolicy basePolicy = new RequestPolicy().setContentCharset("UTF-8").setTimeout(3000);
		RequestPolicy noAuthPolicy = basePolicy.clone();

		if (needAuth) {
			RequestPolicy oauthPolicy = basePolicy.clone();
			oauthPolicy.setNeedAuthorization(true).setUseSignture(true);
			apiRequest.setAccessToken(accessToken);
			result = client.send(apiRequest, t, oauthPolicy);
		} else {
			noAuthPolicy.setUseSignture(true);
			result = client.send(apiRequest, t, noAuthPolicy);
		}

		shutDownClient(client);

		return result;

	}

	/**
	 * api调用
	 * 
	 * @param accessToken
	 * @param apiRequest
	 * @param t
	 * @param needAuth
	 * @param needSign
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	public static <T> T callAPI(String accessToken, Request apiRequest, Class<T> t, boolean needAuth, boolean needSign) throws InterruptedException, ExecutionException, TimeoutException {

		AlibabaClient client = getClient();

		client.start();

		T result = null;

		RequestPolicy authPolicy = new RequestPolicy().setContentCharset("UTF-8").setTimeout(3000);

		// 是否需要授权
		if (needAuth) {

			authPolicy.setNeedAuthorization(true);

		}

		// 是否需要签名
		if (needSign) {

			authPolicy.setUseSignture(true);

		}

		apiRequest.setAccessToken(accessToken);

		result = client.send(apiRequest, t, authPolicy);

		shutDownClient(client);

		return result;

	}

	public static ArrayList<Map<String, Object>> getReturnFromMap(Map<String, Object> map) {

		return (ArrayList<Map<String, Object>>) ((LinkedHashMap<String, Object>) map.get("result")).get("toReturn");

	}

}
