package com.zhigu.service.admin.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.StatMapper;
import com.zhigu.service.admin.IStatService;

@Service
public class StatServiceImpl implements IStatService {

	@Autowired
	private StatMapper statDao;

	@Override
	public Map<String, Object> statMember() {
		return statDao.statMember();
	}

	@Override
	public Map<String, Object> statCommodity() {
		return statDao.statCommodity();
	}

	@Override
	public Map<String, Object> statRecharge() {
		return statDao.statRecharge();
	}

	@Override
	public Map<String, Object> statOrder() {
		return statDao.statOrder();
	}

}
