package com.zhigu.mapper;

import com.zhigu.model.TaobaoToken;

public interface TaobaoTokenMapper {

	int insertSelective(TaobaoToken record);

	TaobaoToken selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(TaobaoToken record);

	/**
	 * @param userId
	 * @param code
	 * @param goodsId
	 * @return
	 */
	TaobaoToken getTaobaoTokenByCode(int userId, String code, int goodsId);

	/**
	 * @param userId
	 * @return
	 */
	TaobaoToken getTaobaoTokenByUserId(int userId);
}