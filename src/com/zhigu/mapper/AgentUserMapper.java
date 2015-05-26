package com.zhigu.mapper;

import java.util.List;

import com.zhigu.model.AgentUser;

public interface AgentUserMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(AgentUser record);

	int insertSelective(AgentUser record);

	AgentUser selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(AgentUser record);

	int updateByPrimaryKey(AgentUser record);

	List<AgentUser> selectAll();

	AgentUser selectByAgentUserId(Integer userId);
}