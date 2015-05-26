package com.zhigu.mapper;

import java.util.List;

import com.zhigu.model.AD;

public interface ADMapper {
	/**
	 * 查询广告ALL
	 * 
	 * @param markID
	 * @return
	 */
	public List<AD> queryADList();

	/**
	 * 查询广告by MarkID
	 * 
	 * @param markID
	 * @return
	 */
	public List<AD> queryADByGroupList(int group);

	/**
	 * 查询广告by ID
	 * 
	 * @param ID
	 * @return
	 */
	public AD queryADByID(int ID);

	/**
	 * 更新广告
	 * 
	 * @param ad
	 * @return
	 */
	public int updateAD(AD ad);
}
