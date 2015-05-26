package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.ValueRef;

public interface ValueRefMapper extends BaseMapper<ValueRef> {

	/**
	 * @param refId
	 * @return
	 */
	List<ValueRef> selectValueRefs(Integer refId);

	ValueRef selectTBValueByPlat(@Param("refId") Integer refId, @Param("valueId") Integer valueId);
}