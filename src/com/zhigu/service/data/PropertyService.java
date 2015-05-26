package com.zhigu.service.data;

import java.util.List;

import com.zhigu.model.CategoryProperty;
import com.zhigu.model.Property;

public interface PropertyService {

	public List<Property> selectPropByCatId(Integer catId);

	/**
	 * @param name
	 * @return
	 */
	public Property queryPropByName(String name);

	/**
	 * @param prop
	 */
	public void save(Property prop);

	/**
	 * @param catProp
	 */
	public void saveCatProp(CategoryProperty catProp);

	/**
	 * @return
	 */
	public List<Property> queryPropsByCatId(int catId);

	/**
	 * 添加属性，关联，映射数据
	 * 
	 * @param prop
	 * @param catId
	 * @param pid
	 * @param pname
	 */
	public void addPropAndRef(Property prop, Integer catId, Long pid, String pname);

}
