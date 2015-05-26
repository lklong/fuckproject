/**
 * 
 */
package com.zhigu.service.data.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.CategoryRefMapper;
import com.zhigu.mapper.PropertyMapper;
import com.zhigu.mapper.PropertyRefMapper;
import com.zhigu.model.CategoryProperty;
import com.zhigu.model.CategoryRef;
import com.zhigu.model.Property;
import com.zhigu.model.PropertyRef;
import com.zhigu.service.data.PropertyService;

/**
 * @author Administrator
 *
 */
@Service
public class PropertyServiceImpl implements PropertyService {

	@Autowired
	private PropertyMapper propertyDao;

	@Autowired
	private CategoryRefMapper categoryRefDao;

	@Autowired
	private PropertyRefMapper propertyRefDao;

	@Override
	public List<Property> selectPropByCatId(Integer catId) {
		return propertyDao.selectPropByCatId(catId);
	}

	@Override
	public Property queryPropByName(String name) {
		return propertyDao.queryPropByName(name);
	}

	@Override
	public void save(Property prop) {
		propertyDao.insert(prop);

	}

	@Override
	public void saveCatProp(CategoryProperty catProp) {
		propertyDao.saveCatProp(catProp);

	}

	@Override
	public List<Property> queryPropsByCatId(int catId) {
		return propertyDao.queryPropsByCatId(catId);
	}

	@Override
	public void addPropAndRef(Property prop, Integer catId, Long pid, String pname) {

		// 1.验证属性名称是否存在
		Property _prop = propertyDao.queryPropByName(prop.getName());

		// 2.不存在，保存基本数据
		if (_prop == null) {

			prop.setCategoryID(catId);

			propertyDao.insert(prop);

		} else {
			prop = _prop;
		}

		// 3.保存关系表
		CategoryProperty catProp = new CategoryProperty();
		catProp.setCategoryId(catId);
		catProp.setPropertyId(prop.getId());

		propertyDao.saveCatProp(catProp);

		// 4.保存数据映射关系
		CategoryRef catRef = categoryRefDao.selectTBCatByPlat(catId);

		PropertyRef ref = new PropertyRef();
		ref.setCategoryID(Long.valueOf(catId));
		ref.setThirdCatID(catRef.getThirdCatID());
		ref.setCategoryPropID(Long.valueOf(prop.getId()));
		ref.setCatPropName(prop.getName());
		ref.setThirdCatPropID(pid);
		ref.setThirdCatPropName(pname);

		propertyRefDao.insert(ref);

	}

}
