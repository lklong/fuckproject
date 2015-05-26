package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.Category;
import com.zhigu.model.Property;
import com.zhigu.model.PropertyValue;

/**
 * 类别dao
 * 
 * @author zhouqibing 2014年9月28日下午3:23:54
 */
public interface CategoryMapper extends BaseMapper<Category> {
	/**
	 * 查询所有类别
	 * 
	 * @return
	 */
	public List<Category> queryCategoryList();

	/**
	 * 查询指定类别下的子类别
	 * 
	 * @param parentId
	 * @return
	 */
	public List<Category> queryCategoryByParent(int parentId);

	/**
	 * 查询类别，根据code查询，包含code和code下的子类（like模糊查询）
	 * 
	 * @param code
	 * @return
	 */
	public List<Category> queryCategoryByCode(String code);

	/**
	 * 查询指定类型
	 * 
	 * @param catagoryId
	 * @return
	 */
	public Category queryCategoryById(int ID);

	/**
	 * 根据类型，加载属性
	 * 
	 * @param category
	 * @return
	 */
	public List<Property> queryPropertyByCategory(int value);

	public List<PropertyValue> privatePropertyValueList(@Param("categoryId") Integer categoryId, @Param("propertyId") Integer propertyId);

	/**
	 * @return
	 */
	public List<Category> queryAll();

}
