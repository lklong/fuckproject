/**
 * @ClassName: CategoryRefServiceImpl.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月14日
 * 
 */
package com.zhigu.service.data.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.CategoryRefMapper;
import com.zhigu.model.CategoryRef;
import com.zhigu.service.data.CategoryRefService;

/**
 * @author Administrator
 *
 */
@Service
public class CategoryRefServiceImpl implements CategoryRefService {

	@Autowired
	private CategoryRefMapper categoryRefMapper;

	public CategoryRef add(CategoryRef ref) {

		categoryRefMapper.insertSelective(ref);

		return ref;

	}

	public List<CategoryRef> selectAll() {

		return categoryRefMapper.selectAll();

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.zhigu.service.datamanager.CategoryRefService#getById(java.lang.Integer
	 * )
	 */
	@Override
	public CategoryRef getById(Integer id) {

		return categoryRefMapper.selectByPrimaryKey(id);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.zhigu.service.datamanager.CategoryRefService#deleteByPrimaryKey(java
	 * .lang.Integer)
	 */
	@Override
	public int deleteByPrimaryKey(Integer id) {
		return categoryRefMapper.deleteByPrimaryKey(id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.zhigu.service.data.CategoryRefService#selectTBCatByPlat(java.lang
	 * .Integer)
	 */
	@Override
	public CategoryRef selectTBCatByPlat(Integer catId) {
		CategoryRef catRef = categoryRefMapper.selectTBCatByPlat(catId);
		return catRef;
	}

}
