package com.zhigu.service.admin.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.AdminOrderMapper;
import com.zhigu.service.admin.IAdminOrderService;

@Service
public class AdminOrderServiceImpl implements IAdminOrderService {
	@Autowired
	private AdminOrderMapper adminOrderDao;

	@Override
	public Map<String, Object> memberOrderStat(Integer memberID) {
		return adminOrderDao.memberOrderStatByMemberID(memberID);
	}

}
