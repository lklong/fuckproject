package com.zhigu.service.data;

import java.util.List;

import com.zhigu.model.PropertyRef;

public interface PropertyRefService {

	public int insertSelective(PropertyRef record);

	public List<PropertyRef> selectAll();

	public PropertyRef selectByPrimaryKey(Integer id);

	/**
	 * @param catId
	 * @param cid
	 * @return
	 */
	public List<PropertyRef> selectByCatId(Integer catId, Long cid);

	/**
	 * @param id
	 */
	public void deleteByPrimaryKey(Integer id);

	PropertyRef queryCategoryRefByCidAndPropID(Integer cid, Integer propID);

}
