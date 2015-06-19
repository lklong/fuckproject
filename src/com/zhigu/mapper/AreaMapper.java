package com.zhigu.mapper;

import java.util.List;

import com.zhigu.model.Area;

public interface AreaMapper {

	Area selectById(String id);

	List<Area> selectByParentId(String parentId);

}