package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.PropertyRef;

public interface PropertyRefMapper extends BaseMapper<PropertyRef> {

	List<PropertyRef> selectAll();

	/**
	 * @param catId
	 * @param cid
	 * @return
	 */
	List<PropertyRef> selectByCatId(@Param("catId") Integer catId, @Param("cid") Long cid);

	PropertyRef selectTBPropByPlat(@Param("catId") Integer catId, @Param("propId") Integer propId);

	PropertyRef queryCategoryRefByCidAndPropID(@Param("cid") Integer cid, @Param("propID") Integer propID);

}