package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.GoodsComplaint;
import com.zhigu.model.GoodsComplaintType;
import com.zhigu.model.PageBean;

/**
 * 商品投诉
 * 
 * @author zhouqibing 2014年11月6日下午1:12:56
 */
public interface GoodsComplaintMapper {

	/**
	 * 保存商品投诉
	 * 
	 * @param gc
	 */
	public void saveGoodsComplaint(GoodsComplaint gc);

	/**
	 * 查询商品投诉
	 * 
	 * @param goodsId
	 * @param userId
	 * @return
	 */
	public GoodsComplaint queryGoodsComplaint(@Param("id") Integer id, @Param("goodsId") Integer goodsId, @Param("userId") Integer userId);

	/**
	 * 查询商品投诉
	 * 
	 * @param goodsId
	 * @return
	 */
	public List<GoodsComplaint> queryGoodsComplaintsByPage(@Param("page") PageBean<GoodsComplaint> page, @Param("goodsId") int goodsId);

	/**
	 * 查询商品投诉类型
	 * 
	 * @return
	 */
	public List<GoodsComplaintType> queryGoodsComplaintType();
}
