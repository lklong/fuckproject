package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.PageBean;
import com.zhigu.model.Withdraw;

public interface WithdrawMapper {
	int deleteByPrimaryKey(Long id);

	int insert(Withdraw record);

	int insertSelective(Withdraw record);

	Withdraw selectByPrimaryKey(Long id);

	int updateByPrimaryKeySelective(Withdraw record);

	int updateByPrimaryKey(Withdraw record);

	List<Withdraw> queryWithdrawByPage(@Param("page") PageBean<Withdraw> page, @Param("userId") Integer userId, @Param("status") Integer status);

	List<Withdraw> adminQueryWithdrawByPage(@Param("page") PageBean<Withdraw> page, @Param("userId") Integer userId, @Param("userPhone") String userPhone, @Param("status") Integer status,
			@Param("bankNo") String bankNo, @Param("bankCardMaster") String bankCardMaster);
}