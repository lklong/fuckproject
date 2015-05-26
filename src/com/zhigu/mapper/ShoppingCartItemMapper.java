package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.ShoppingCartItem;

public interface ShoppingCartItemMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(ShoppingCartItem record);

	int insertSelective(ShoppingCartItem record);

	ShoppingCartItem selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(ShoppingCartItem record);

	int updateByPrimaryKey(ShoppingCartItem record);

	int countNumByUserId(int userId);

	ShoppingCartItem selectByUserIdAndSkuId(@Param("userId") Integer userId, @Param("skuId") Integer skuId);

	List<ShoppingCartItem> selectByUserId(@Param("userId") Integer userId, @Param("checked") Boolean checked);

	/**
	 * 系统自动删除购物车
	 * 
	 * @param date
	 *            YYYY-mm-dd
	 * @return
	 */
	int systemDeleteBeforeByDate(String date);
}