package com.zhigu.common.utils.taobao;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.druid.support.json.JSONUtils;
import com.taobao.api.internal.util.WebUtils;
import com.zhigu.common.taobao.TaobaoConfig;
import com.zhigu.common.utils.ZhiguConfig;

public class TaobaoTokenUtil {

	private static final Logger LOGGER = Logger.getLogger(TaobaoTokenUtil.class);

	/**
	 * 根据code获取tokenMap
	 * 
	 * @param code
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, String> getTokenMap(String code, Integer userId) {

		Map<String, String> param = new HashMap<String, String>();

		param.put("grant_type", "authorization_code");

		param.put("code", code);

		param.put("client_id", TaobaoConfig.APP_KEY);

		param.put("client_secret", TaobaoConfig.APP_SECRET);

		param.put("redirect_uri", ZhiguConfig.getValue("taobao_redirect_url"));

		param.put("view", "web");

		WebUtils.setIgnoreSSLCheck(true);

		try {
			String responseJson = WebUtils.doPost(TaobaoConfig.TOKEN_URL, param, 3000, 3000);

			Map<String, String> tokenMap = (Map<String, String>) JSONUtils.parse(responseJson);

			return tokenMap;

		} catch (IOException e) {

			LOGGER.error("获取淘宝授权失败：参数code:" + code + ",userId" + userId + e.getMessage());
		}

		return null;
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
	public static Map<String, String> getRefreshTokenMap(String refreshToken, Integer userId) {

		Map<String, String> param = new HashMap<String, String>();

		param.put("grant_type", "refresh_token");

		param.put("refresh_token", refreshToken);

		param.put("client_id", TaobaoConfig.APP_KEY);

		param.put("client_secret", TaobaoConfig.APP_SECRET);

		param.put("view", "web");

		try {
			String responseJson = WebUtils.doPost(TaobaoConfig.TOKEN_URL, param, 3000, 3000);

			Map<String, String> tokenMap = (Map<String, String>) JSONUtils.parse(responseJson);

			return tokenMap;

		} catch (IOException e) {

			LOGGER.error("刷新淘宝授权失败：参数code:" + refreshToken + ",userId" + userId + e.getMessage());
		}

		return null;

	}

}
