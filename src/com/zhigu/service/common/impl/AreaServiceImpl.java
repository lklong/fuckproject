package com.zhigu.service.common.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.AreaMapper;
import com.zhigu.model.Area;
import com.zhigu.service.common.AreaService;

@Service
public class AreaServiceImpl implements AreaService {

	@Autowired
	private AreaMapper areaMapper;

	public Area selectById(String id) {

		return areaMapper.selectById(id);

	}

	public List<Area> selectByParentId(String parentId) {

		return areaMapper.selectByParentId(parentId);

	}

}