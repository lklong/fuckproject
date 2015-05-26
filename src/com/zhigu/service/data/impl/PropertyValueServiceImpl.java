/**
 * @ClassName: PropertyValueServiceImpl.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月15日
 * 
 */
package com.zhigu.service.data.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.PropertyValueMapper;
import com.zhigu.model.PropertyValue;
import com.zhigu.service.data.PropertyValueService;

/**
 * @author Administrator
 *
 */
@Service
public class PropertyValueServiceImpl implements PropertyValueService {

	@Autowired
	private PropertyValueMapper propertyValueMapper;

	@Override
	public List<PropertyValue> queryPropertyByCategory(int categoryId, int propertyId) {
		return propertyValueMapper.privatePropertyValueList(categoryId, propertyId);
	}

	public List<PropertyValue> queryPropertyValue(int propertyId) {

		return propertyValueMapper.queryPropertyValue(propertyId);

	}

	@Override
	public int add(PropertyValue prov) {
		return propertyValueMapper.insert(prov);

	}

	@Override
	public PropertyValue queryPropValueByName(String name) {
		return propertyValueMapper.queryPropValueByName(name);
	}

}
