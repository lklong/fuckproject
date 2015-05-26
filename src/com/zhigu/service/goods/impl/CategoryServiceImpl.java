package com.zhigu.service.goods.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.CategoryMapper;
import com.zhigu.mapper.CategoryRefMapper;
import com.zhigu.mapper.PropertyValueMapper;
import com.zhigu.model.Category;
import com.zhigu.model.CategoryRef;
import com.zhigu.model.Property;
import com.zhigu.model.PropertyValue;
import com.zhigu.service.goods.ICategoryService;
import com.zhigu.service.taobao.ITaobaoCategoryService;

/**
 * 类别
 * 
 * @author zhouqibing 2014年9月28日下午5:23:14
 */
@Service
public class CategoryServiceImpl implements ICategoryService {

	@Autowired
	private ITaobaoCategoryService taobaoCategoryService;

	@Autowired
	private CategoryMapper categoryDao;
	@Autowired
	private PropertyValueMapper propertyValueMapper;

	@Autowired
	private CategoryRefMapper categoryRefDao;

	@Override
	public List<Category> queryCategory() {
		return categoryDao.queryCategoryList();
	}

	@Override
	public List<Category> queryCategoryByParent(int parentId) {
		return categoryDao.queryCategoryByParent(parentId);
	}

	@Override
	public Category queryCategoryById(int catagoryId) {
		return categoryDao.queryCategoryById(catagoryId);
	}

	@Override
	public List<Property> queryPropertyByCategory(int categoryId) {
		List<Property> pList = categoryDao.queryPropertyByCategory(categoryId);
		for (Property property : pList) {
			List<PropertyValue> privatePropertyValueList = propertyValueMapper.privatePropertyValueList(categoryId, property.getId());
			if (!privatePropertyValueList.isEmpty()) {
				property.setValues(privatePropertyValueList);
			}

		}
		return pList;
	}

	@Override
	public List<Category> queryCategoryByCode(String code) {
		return categoryDao.queryCategoryByCode(code);
	}

	@Override
	public void addCategory(Category category) {
		// Category parent = cmnDao.queryObject("category.queryCategoryById",
		// category.getParentId());
		// List<Category> clist =
		// cmnDao.queryList("category.queryCategoryByCode", parent.getCode());
		// // 查找最大code码
		// Category maxCodeCategory = null;
		// for (Category c : clist) {
		// if (maxCodeCategory == null) {
		// maxCodeCategory = c;
		// continue;
		// }
		// if (maxCodeCategory.getCode().compareTo(c.getCode()) < 0) {
		// maxCodeCategory = c;
		// }
		// }
	}

	@Override
	public int save(Category category) {
		categoryDao.insert(category);
		category.setSort(category.getId());
		return categoryDao.update(category);

	}

	public int delete(int id) {
		return categoryDao.deleteById(id);
	}

	public int update(Category category) {
		return categoryDao.update(category);
	}

	@Override
	public List<Category> queryAll() {
		return categoryDao.queryAll();
	}

	@Override
	public Category addCategoryAndRef(String name, Boolean isParent, String code, Integer parentId) {

		Category category = new Category();

		category.setCode(code);

		category.setIsParent(isParent);

		category.setName(name);

		parentId = parentId == null ? 0 : parentId;

		category.setParentId(parentId);

		categoryDao.insert(category);

		// 添加关联关系
		if (!category.getIsParent()) {

			CategoryRef ref = new CategoryRef();

			ref.setCategoryID(Long.valueOf(category.getId()));

			ref.setCategoryName(category.getName());

			ref.setThirdCatID(Long.valueOf(category.getCode()));

			ref.setThirdCatName(category.getName());

			categoryRefDao.insertSelective(ref);

		}

		return category;
	}

}
