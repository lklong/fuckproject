/**
 * @ClassName: TaobaoTokenServiceImpl.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月27日
 * 
 */
package com.zhigu.service.taobao.impl;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taobao.api.domain.UserInfo;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.taobao.TaobaoTokenUtil;
import com.zhigu.mapper.TaobaoTokenMapper;
import com.zhigu.model.TaobaoToken;
import com.zhigu.service.taobao.ITaobaoImageService;
import com.zhigu.service.taobao.ITaobaoTokenService;

/**
 * @author Administrator
 *
 */
@Service
public class TaobaoTokenServiceImpl implements ITaobaoTokenService {

	@Autowired
	private TaobaoTokenMapper taobaoTokenMapper;

	@Override
	public int insertSelective(TaobaoToken taobaoToken) {
		return taobaoTokenMapper.insertSelective(taobaoToken);
	}

	@Override
	public TaobaoToken getTaobaoTokenByCode(int userId, String code, int goodsId) {
		return taobaoTokenMapper.getTaobaoTokenByCode(userId, code, goodsId);
	}

	@Override
	public TaobaoToken getTaobaoTokenByUserId(int userId) {
		return taobaoTokenMapper.getTaobaoTokenByUserId(userId);
	}

	@Override
	public int updateSelective(TaobaoToken token) {
		return taobaoTokenMapper.updateByPrimaryKeySelective(token);
	}

	@Autowired
	private ITaobaoImageService taobaoImageService;

	/**
	 * 根据code获取tokenMap
	 * 
	 * @param code
	 * @return
	 * @throws IOException
	 */
	private Map<String, String> getTokenMap(String code, Integer userId) {

		Map<String, String> tokenMap = TaobaoTokenUtil.getTokenMap(code, userId);

		saveTaobaoToken(tokenMap, userId);

		return tokenMap;
	}

	private void saveTaobaoToken(Map<String, String> tokenMap, Integer userId) {

		TaobaoToken token = getTaobaoTokenByUserId(userId);

		if (token == null) {

			token = new TaobaoToken();

			token.setAccessToken(tokenMap.get("access_token"));
			token.setAddDate(new Date());
			Object exin = tokenMap.get("expires_in");
			token.setExpiresIn((Integer) exin);
			token.setRefreshToken(tokenMap.get("refresh_token"));
			token.setTaobaoUserId(tokenMap.get("user_id"));
			token.setUserNick(tokenMap.get("user_nick"));
			token.setUserId(userId);

			insertSelective(token);

		} else {

			// 存入数据库
			token.setAccessToken(tokenMap.get("access_token"));
			token.setAddDate(new Date());
			Object exin = tokenMap.get("expires_in");
			token.setExpiresIn((Integer) exin);
			token.setRefreshToken(tokenMap.get("refresh_token"));
			token.setRefreshDate(new Date());

			updateSelective(token);
		}

	}

	/**
	 * 刷新token：根据refreshToken获取token
	 * 
	 * @param state
	 * @param refreshToken
	 * @return
	 * @throws IOException
	 */
	private String getRefreshTokenMap(String refreshToken, Integer userId) {

		Map<String, String> tokenMap = TaobaoTokenUtil.getRefreshTokenMap(refreshToken, userId);

		saveTaobaoToken(tokenMap, userId);

		return tokenMap.get("access_token");

	}

	public String getToken(String code, Integer userId) throws ServiceException {

		TaobaoToken taobaoToken = null;

		String refresh_token = null;

		String access_token = null;

		if (StringUtils.isNotBlank(code)) {

			Map<String, String> tokenMap = getTokenMap(code, userId);

			if (tokenMap == null) {

				throw new ServiceException("用户授权码过期，请重新获取授权");

			}

			refresh_token = tokenMap.get("refresh_token");

			access_token = tokenMap.get("access_token");

		} else {

			taobaoToken = getTaobaoTokenByUserId(userId);

			access_token = taobaoToken.getAccessToken();

			refresh_token = taobaoToken.getRefreshToken();

		}

		// 测试access_token
		UserInfo userInfo = taobaoImageService.getUserInfo(access_token);

		if (userInfo == null) {

			// 刷新token
			access_token = getRefreshTokenMap(refresh_token, userId);

			// throw new ServiceException("用户授权信息已过期，请重新获取授权");

		}

		return access_token;

	}

}
