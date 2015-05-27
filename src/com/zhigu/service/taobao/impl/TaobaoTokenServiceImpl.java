/**
 * @ClassName: TaobaoTokenServiceImpl.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月27日
 * 
 */
package com.zhigu.service.taobao.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.TaobaoTokenMapper;
import com.zhigu.model.TaobaoToken;
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

}
