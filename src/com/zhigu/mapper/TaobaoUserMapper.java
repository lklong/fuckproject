package com.zhigu.mapper;

import com.zhigu.model.TaobaoUser;

public interface TaobaoUserMapper {
	int insertSelective(TaobaoUser record);

	TaobaoUser selectByPrimaryKey(String uid);

	int updateByPrimaryKeySelective(TaobaoUser record);

}