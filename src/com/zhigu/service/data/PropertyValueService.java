/**
 * @ClassName: PropertyValueService.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月15日
 * 
 */
package com.zhigu.service.data;

import java.util.List;

import com.zhigu.model.PropertyValue;

/**
 * @author Administrator
 *
 */
public interface PropertyValueService {

	public List<PropertyValue> queryPropertyByCategory(int categoryId, int propertyId);

	List<PropertyValue> queryPropertyValue(int propertyId);

	public int add(PropertyValue prov);

	public PropertyValue queryPropValueByName(String name);

}
