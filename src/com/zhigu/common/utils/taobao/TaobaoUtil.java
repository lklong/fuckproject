package com.zhigu.common.utils.taobao;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.alibaba.druid.support.json.JSONUtils;
import com.taobao.api.internal.util.WebUtils;
import com.zhigu.common.taobao.TaobaoConfig;
import com.zhigu.common.utils.ZhiguConfig;

public class TaobaoUtil {

	/**
	 * 根据code获取tokenMap
	 * 
	 * @param code
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, String> getTokenMap(String code, Integer state) throws IOException {

		Map<String, String> param = new HashMap<String, String>();

		param.put("grant_type", "authorization_code");

		param.put("code", code);

		param.put("client_id", TaobaoConfig.APP_KEY);

		param.put("client_secret", TaobaoConfig.APP_SECRET);

		param.put("redirect_uri", ZhiguConfig.getValue("taobao_redirect_url"));

		param.put("view", "web");

		if (state != null) {

			param.put("state", state.toString());

		}

		WebUtils.setIgnoreSSLCheck(true);

		String responseJson = WebUtils.doPost(TaobaoConfig.TOKEN_URL, param, 3000, 3000);

		Map<String, String> tokenMap = (Map<String, String>) JSONUtils.parse(responseJson);

		// TODO 存入数据库

		return tokenMap;
	}

	/**
	 * 刷新token：根据refreshToken获取token
	 * 
	 * @param state
	 * @param refreshToken
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, String> getRefreshTokenMap(Integer state, String refreshToken) throws IOException {

		Map<String, String> param = new HashMap<String, String>();

		param.put("grant_type", "refresh_token");

		param.put("refresh_token", refreshToken);

		param.put("client_id", TaobaoConfig.APP_KEY);

		param.put("client_secret", TaobaoConfig.APP_SECRET);

		param.put("view", "web");

		if (state != null) {

			param.put("state", state.toString());

		}

		String responseJson = WebUtils.doPost(TaobaoConfig.TOKEN_URL, param, 3000, 3000);

		Map<String, String> tokenMap = (Map<String, String>) JSONUtils.parse(responseJson);

		// TODO 存入数据库

		return tokenMap;

	}

	/** 临时缓存token */
	private static Map<String, String> tokenMap = new HashMap<String, String>();

	public static String getToken(String code, Integer goodsId) throws IOException {

		// TODO 从数据库里获取token

		String token = tokenMap.get(code);

		String refresh_token = null;

		String access_token = null;

		Map<String, String> tokenMap2 = null;

		if (StringUtils.isBlank(token)) {

			tokenMap2 = TaobaoUtil.getTokenMap(code, goodsId);

		} else {

			refresh_token = tokenMap.get(tokenMap.get(code));

			tokenMap2 = TaobaoUtil.getRefreshTokenMap(goodsId, refresh_token);

		}

		refresh_token = tokenMap2.get("refresh_token");

		access_token = tokenMap2.get("access_token");

		tokenMap.put(code, access_token);

		tokenMap.put(access_token, refresh_token);

		return access_token;

	}

}
