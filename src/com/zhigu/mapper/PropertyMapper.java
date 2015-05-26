package com.zhigu.mapper;

import java.util.List;

import com.zhigu.model.CategoryProperty;
import com.zhigu.model.Property;

public interface PropertyMapper extends BaseMapper<Property> {

	List<Property> selectPropByCatId(Integer catId);

	/**
	 * @param name
	 * @return
	 */
	Property queryPropByName(String name);

	/**
	 * @param catProp
	 */
	void saveCatProp(CategoryProperty catProp);

	List<Property> queryPropsByCatId(int catId);
}