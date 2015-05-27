package com.zhigu.common.utils.taobao;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.druid.support.json.JSONUtils;
import com.taobao.api.domain.UserInfo;
import com.taobao.api.internal.util.WebUtils;
import com.zhigu.common.taobao.TaobaoConfig;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.model.TaobaoToken;
import com.zhigu.service.taobao.ITaobaoImageService;
import com.zhigu.service.taobao.ITaobaoTokenService;

@Service
public class TaobaoUtil2 {

	@Autowired
	private ITaobaoTokenService taobaoTokenService;

	@Autowired
	private ITaobaoImageService taobaoImageService;

	/**
	 * 根据code获取tokenMap
	 * 
	 * @param code
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> getTokenMap(String code, Integer userId) throws IOException {

		Map<String, String> param = new HashMap<String, String>();

		param.put("grant_type", "authorization_code");

		param.put("code", code);

		param.put("client_id", TaobaoConfig.APP_KEY);

		param.put("client_secret", TaobaoConfig.APP_SECRET);

		param.put("redirect_uri", ZhiguConfig.getValue("taobao_redirect_url"));

		param.put("view", "web");

		WebUtils.setIgnoreSSLCheck(true);

		String responseJson = WebUtils.doPost(TaobaoConfig.TOKEN_URL, param, 3000, 3000);

		Map<String, String> tokenMap = (Map<String, String>) JSONUtils.parse(responseJson);

		// 存入数据库
		insertTaobaoToken(tokenMap, userId);

		return tokenMap;
	}

	private void insertTaobaoToken(Map<String, String> tokenMap, Integer userId) {
		// 存入数据库
		TaobaoToken token = new TaobaoToken();
		token.setAccessToken(tokenMap.get("access_token"));
		token.setAddDate(new Date());
		token.setExpiresIn(Integer.valueOf(tokenMap.get("expires_in")));
		token.setRefreshToken(tokenMap.get("refresh_token"));
		token.setTaobaoUserId(tokenMap.get("user_id"));
		token.setUserNick(tokenMap.get("user_nick"));
		token.setUserId(userId);

		taobaoTokenService.insertSelective(token);
	}

	private void updateTaobaoToken(Map<String, String> tokenMap, Integer userId) {

		TaobaoToken token = taobaoTokenService.getTaobaoTokenByUserId(userId);

		// 存入数据库
		token.setAccessToken(tokenMap.get("access_token"));
		token.setAddDate(new Date());
		token.setExpiresIn(Integer.valueOf(tokenMap.get("expires_in")));
		token.setRefreshToken(tokenMap.get("refresh_token"));
		token.setRefreshDate(new Date());

		taobaoTokenService.updateSelective(token);
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
	public String getRefreshTokenMap(String refreshToken, Integer userId) throws IOException {

		Map<String, String> param = new HashMap<String, String>();

		param.put("grant_type", "refresh_token");

		param.put("refresh_token", refreshToken);

		param.put("client_id", TaobaoConfig.APP_KEY);

		param.put("client_secret", TaobaoConfig.APP_SECRET);

		param.put("view", "web");

		String responseJson = WebUtils.doPost(TaobaoConfig.TOKEN_URL, param, 3000, 3000);

		Map<String, String> tokenMap = (Map<String, String>) JSONUtils.parse(responseJson);

		updateTaobaoToken(tokenMap, userId);

		return tokenMap.get("access_token");

	}

	public String getToken(String code, Integer userId) throws IOException {

		TaobaoToken taobaoToken = taobaoTokenService.getTaobaoTokenByUserId(userId);

		String refresh_token = null;

		String access_token = null;

		if (taobaoToken == null) {

			Map<String, String> tokenMap2 = TaobaoUtil.getTokenMap(code, userId);

			refresh_token = tokenMap2.get("refresh_token");

			access_token = tokenMap2.get("access_token");

		} else {

			access_token = taobaoToken.getAccessToken();

			refresh_token = taobaoToken.getRefreshToken();

		}

		// 测试access_token

		UserInfo userInfo = taobaoImageService.getUserInfo(access_token);

		if (userInfo == null) {
			access_token = getRefreshTokenMap(refresh_token, userId);
		}
		// 刷新token
		return access_token;

	}
}
