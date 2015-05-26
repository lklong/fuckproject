/**
 * @ClassName: PropValueRefServiceImpl.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月15日
 * 
 */
package com.zhigu.service.data.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.ValueRefMapper;
import com.zhigu.model.ValueRef;
import com.zhigu.service.data.ValueRefService;

/**
 * @author Administrator
 *
 */
@Service
public class ValueRefServiceImpl implements ValueRefService {

	@Autowired
	private ValueRefMapper valueRefMapper;

	@Override
	public int insertSelective(ValueRef record) {
		return valueRefMapper.insert(record);
	}

	@Override
	public List<ValueRef> selectPropValueRefs(Integer refId) {
		return valueRefMapper.selectValueRefs(refId);
	}

	@Override
	public void deleteByPrimaryKey(Integer id) {
		valueRefMapper.deleteById(id);

	}

}
