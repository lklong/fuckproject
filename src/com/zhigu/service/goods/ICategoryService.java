package com.zhigu.service.goods;

import java.util.List;

import com.zhigu.model.Category;
import com.zhigu.model.Property;

/**
 * 类别服务接口
 * 
 * @author zhouqibing 2014年9月28日下午2:59:16
 */
public interface ICategoryService {
	/**
	 * 查询所有类别
	 * 
	 * @return
	 */
	public List<Category> queryCategory();

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
	public Category queryCategoryById(int catagoryId);

	/**
	 * 根据类型，加载属性
	 * 
	 * @param category
	 * @return
	 */
	public List<Property> queryPropertyByCategory(int category);

	/**
	 * 添加类目
	 * 
	 * @param category
	 */
	public void addCategory(Category category);

	/**
	 * 添加类目
	 * 
	 * @param category
	 */
	public int save(Category category);

	/**
	 * 更新类目
	 * 
	 * @param id
	 * @return
	 */
	int update(Category category);

	/**
	 * 删除类目
	 * 
	 * @param id
	 * @return
	 */
	int delete(int id);

	/**
	 * 
	 * @return
	 */
	List<Category> queryAll();

	/**
	 * 保存类目，类目映射
	 * 
	 * @param name
	 * @param isParent
	 * @param code
	 * @param parentId
	 * @return
	 */
	public Category addCategoryAndRef(String name, Boolean isParent, String code, Integer parentId);

}
