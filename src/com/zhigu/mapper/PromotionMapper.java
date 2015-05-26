package com.zhigu.mapper;

import java.util.List;

import com.zhigu.model.CommissionPorportion;
import com.zhigu.model.CommissionRecord;
import com.zhigu.model.PageBean;

/**
 * 推广
 * 
 * @author HeSiMin
 * @date 2014年10月9日
 *
 */
public interface PromotionMapper {
	/**
	 * 保存推广人提成比例
	 * 
	 * @param commissionPorportion
	 * @return
	 */
	public int saveCommissionPorportion(CommissionPorportion commissionPorportion);

	/**
	 * 查询最新提成比
	 * 
	 * @return
	 */
	public CommissionPorportion queryLastCommissionPorportion();

	/**
	 * 添加提成记录
	 * 
	 * @param commissionRecord
	 * @return
	 */
	public int addCommissionRecord(CommissionRecord commissionRecord);

	/**
	 * 分页查询提成记录
	 * 
	 * @param page
	 * @return
	 */
	public List<CommissionRecord> queryCommissionRecordByPage(PageBean page);
}
