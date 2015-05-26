package com.zhigu.service.goods.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.GoodsComplaintMapper;
import com.zhigu.model.GoodsComplaint;
import com.zhigu.model.GoodsComplaintType;
import com.zhigu.model.PageBean;
import com.zhigu.service.goods.IGoodsComplaintService;
import com.zhigu.service.user.IOrderService;

/**
 * 商品投诉
 * 
 * @author zhouqibing 2014年11月6日下午1:12:06
 */
@Service
public class GoodsComplaintServiceImpl implements IGoodsComplaintService {

	@Autowired
	private GoodsComplaintMapper goodsComplaintDao;
	@Autowired
	private IOrderService orderService;

	@Override
	public int saveGoodsComplaint(GoodsComplaint gc) {
		if (!orderService.isBuyGoods(gc.getGoodsId(), gc.getUserId())) {
			return 2;
		}
		GoodsComplaint exist = goodsComplaintDao.queryGoodsComplaint(null, gc.getGoodsId(), gc.getUserId());
		if (exist != null)
			return 1;
		goodsComplaintDao.saveGoodsComplaint(gc);
		return 0;
	}

	@Override
	public GoodsComplaint queryGoodsComplaint(int id) {
		// TODO Auto-generated method stub
		return goodsComplaintDao.queryGoodsComplaint(id, null, null);
	}

	@Override
	public List<GoodsComplaint> queryGoodsComplaints(PageBean<GoodsComplaint> page, int goodsId) {
		// TODO Auto-generated method stub
		return goodsComplaintDao.queryGoodsComplaintsByPage(page, goodsId);
	}

	@Override
	public List<GoodsComplaintType> queryGoodsComplaintType() {
		return goodsComplaintDao.queryGoodsComplaintType();
	}

}
