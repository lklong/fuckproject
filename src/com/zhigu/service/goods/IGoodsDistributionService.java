/**
 * @ClassName: IGoodsDistributionService.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月27日
 * 
 */
package com.zhigu.service.goods;

import com.zhigu.model.GoodsDistribution;

/**
 * @author Administrator
 * 
 * @decription 商品分销业务处理
 *
 */
public interface IGoodsDistributionService {

	int insertSelective(GoodsDistribution goodsDistribution);

}
