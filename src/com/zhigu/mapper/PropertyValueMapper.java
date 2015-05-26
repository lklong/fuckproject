package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.PropertyValue;

public interface PropertyValueMapper extends BaseMapper<PropertyValue> {

	List<PropertyValue> privatePropertyValueList(@Param("categoryId") int categoryId, @Param("propertyId") int propertyId);

	List<PropertyValue> queryPropertyValue(int propertyId);

	PropertyValue queryPropValueByName(String name);

}