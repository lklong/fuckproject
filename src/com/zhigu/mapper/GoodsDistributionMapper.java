package com.zhigu.mapper;

import com.zhigu.model.GoodsDistribution;

public interface GoodsDistributionMapper {
	int deleteByPrimaryKey(Integer id);

	int insertSelective(GoodsDistribution record);

	GoodsDistribution selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(GoodsDistribution record);

}