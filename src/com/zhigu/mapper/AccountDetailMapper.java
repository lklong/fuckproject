package com.zhigu.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.AccountDetail;
import com.zhigu.model.PageBean;

public interface AccountDetailMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(AccountDetail record);

	int insertSelective(AccountDetail record);

	AccountDetail selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(AccountDetail record);

	int updateByPrimaryKey(AccountDetail record);

	AccountDetail queryAccountDetailBySno(String sno);

	/**
	 * 根据日期查询用户的收支详细的订单
	 * 
	 * @param page
	 * @param userID
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public List<AccountDetail> queryAccountDetailListByPage(@Param("page") PageBean<AccountDetail> page, @Param("userId") Integer userId, @Param("startDate") Date startDate,
			@Param("endDate") Date endDate);
}