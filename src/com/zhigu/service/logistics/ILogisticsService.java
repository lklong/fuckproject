package com.zhigu.service.logistics;

import java.util.List;

public interface ILogisticsService {
	public List<com.zhigu.model.AgentUser> queryAllAgentUser();

	public List<com.zhigu.model.Logistics> queryAllLogistics();
}
