package com.zhigu.mapper;

import com.zhigu.model.ZhiguFile;

public interface ZhiguFileMapper {

	int insert(ZhiguFile file);

	int deleteById(Long id);

	ZhiguFile selectById(Long id);

}