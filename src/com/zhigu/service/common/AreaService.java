package com.zhigu.service.common;

import java.util.List;

import com.zhigu.model.Area;

public interface AreaService {

	Area selectById(String id);

	List<Area> selectByParentId(String parentId);

}