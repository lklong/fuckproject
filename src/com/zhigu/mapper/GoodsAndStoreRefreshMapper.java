package com.zhigu.mapper;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.GoodsAndStroeRefresh;

public interface GoodsAndStoreRefreshMapper {
	int deleteByPrimaryKey(Long id);

	int insert(GoodsAndStroeRefresh record);

	int insertSelective(GoodsAndStroeRefresh record);

	GoodsAndStroeRefresh selectByPrimaryKey(Long id);

	int updateByPrimaryKeySelective(GoodsAndStroeRefresh record);

	int updateByPrimaryKey(GoodsAndStroeRefresh record);

	/**
	 * 
	 * @param startDate
	 *            s yyyy-mm-dd
	 * @return
	 */
	int countNum(@Param("startDate") String startDate, @Param("userId") Integer userId, @Param("goodsId") Integer goodsId, @Param("storeId") Integer storeId);
}