/**
 * @ClassName: GoodsDistributionServiceImpl.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月27日
 * 
 */
package com.zhigu.service.goods.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.GoodsDistributionMapper;
import com.zhigu.model.GoodsDistribution;
import com.zhigu.service.goods.IGoodsDistributionService;

/**
 * @author Administrator
 *
 */
@Service
public class GoodsDistributionServiceImpl implements IGoodsDistributionService {

	@Autowired
	private GoodsDistributionMapper goodsDistributionMapper;

	@Override
	public int insertSelective(GoodsDistribution goodsDistribution) {

		return goodsDistributionMapper.insertSelective(goodsDistribution);
	}

}
