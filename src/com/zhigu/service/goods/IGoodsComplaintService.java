package com.zhigu.service.goods;

import java.util.List;

import com.zhigu.model.GoodsComplaint;
import com.zhigu.model.GoodsComplaintType;
import com.zhigu.model.PageBean;

/**
 * 商品投诉
 * 
 * @author zhouqibing 2014年11月6日上午11:48:26
 */
public interface IGoodsComplaintService {
	/**
	 * 保存商品投诉
	 * 
	 * @param gc
	 */
	public int saveGoodsComplaint(GoodsComplaint gc);

	/**
	 * 查询商品投诉
	 * 
	 * @param id
	 * @return
	 */
	public GoodsComplaint queryGoodsComplaint(int id);

	/**
	 * 查询商品投诉
	 * 
	 * @param goodsId
	 * @return
	 */
	public List<GoodsComplaint> queryGoodsComplaints(PageBean<GoodsComplaint> page, int goodsId);

	/**
	 * 查询商品投诉类型
	 * 
	 * @return
	 */
	public List<GoodsComplaintType> queryGoodsComplaintType();
}
