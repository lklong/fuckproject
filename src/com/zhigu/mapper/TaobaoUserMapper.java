package com.zhigu.mapper;

import com.zhigu.model.TaobaoUser;

public interface TaobaoUserMapper {
	int insertSelective(TaobaoUser record);

	TaobaoUser selectByPrimaryKey(Long userId);

	int updateByPrimaryKeySelective(TaobaoUser record);

}