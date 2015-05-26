package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.PageBean;
import com.zhigu.model.RechargeRecord;

public interface RechargeRecordMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(RechargeRecord record);

	int insertSelective(RechargeRecord record);

	RechargeRecord selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(RechargeRecord record);

	int updateByPrimaryKey(RechargeRecord record);

	/**
	 * 查询用户充值记录
	 * 
	 * @param userID
	 */
	public List<RechargeRecord> queryRechargeRecordByPage(@Param("userId") Integer userID, @Param("page") PageBean<RechargeRecord> page);

	/**
	 * 查询充值记录
	 * 
	 * @param recordID
	 * @return
	 */
	public RechargeRecord queryRechargeRecordByNo(String PaymentNo);

	/**
	 * 系统取消超期充值记录
	 * 
	 * @param date
	 *            YYYY-mm-dd
	 * @return
	 */
	public int systemCancel(String date);
}