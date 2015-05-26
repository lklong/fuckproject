package com.zhigu.service.data.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.PropertyRefMapper;
import com.zhigu.model.PropertyRef;
import com.zhigu.service.data.PropertyRefService;

@Service
public class PropertyRefServiceImpl implements PropertyRefService {

	@Autowired
	private PropertyRefMapper propertyRefMapper;

	public int insertSelective(PropertyRef record) {

		return propertyRefMapper.insert(record);

	}

	public List<PropertyRef> selectAll() {

		return propertyRefMapper.selectAll();
	}

	public PropertyRef selectByPrimaryKey(Integer id) {

		return propertyRefMapper.selectById(id);

	}

	public List<PropertyRef> selectByCatId(Integer catId, Long cid) {

		return propertyRefMapper.selectByCatId(catId, cid);

	}

	@Override
	public void deleteByPrimaryKey(Integer id) {
		propertyRefMapper.deleteById(id);

	}

	@Override
	public PropertyRef queryCategoryRefByCidAndPropID(Integer cid, Integer propID) {

		return propertyRefMapper.queryCategoryRefByCidAndPropID(cid, propID);
	}

}
