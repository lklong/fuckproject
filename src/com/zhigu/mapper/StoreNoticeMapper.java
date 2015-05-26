package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.PageBean;
import com.zhigu.model.StoreNotice;

public interface StoreNoticeMapper {
	/**
	 * 保存店铺公告
	 * 
	 * @param notice
	 */
	public void saveStoreNotice(StoreNotice notice);

	/**
	 * 修改店铺公告
	 * 
	 * @param notice
	 * @return
	 */
	public int updataStoreNotice(StoreNotice notice);

	/**
	 * 根据店铺ID和类型查询店铺公告
	 * 
	 * @param storeID
	 * @param type
	 *            1:商品动态日志 2:商家日志
	 * @return
	 */
	public List<StoreNotice> queryStoreNoticeByPage(@Param("page") PageBean<StoreNotice> page, @Param("storeID") Integer storeID, @Param("type") Integer type);

	/**
	 * 删除指定ID的店铺公告
	 * 
	 * @param id
	 * @return
	 */
	public int delStoreNotice(Integer id);

}