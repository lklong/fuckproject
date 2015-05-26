package com.zhigu.service.goods.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.mapper.GoodsEvaluateMapper;
import com.zhigu.mapper.OrderMapper;
import com.zhigu.model.GoodsEvaluate;
import com.zhigu.model.OrderDetail;
import com.zhigu.model.PageBean;
import com.zhigu.model.UserInfo;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.goods.IGoodsEvaluateService;
import com.zhigu.service.user.IUserService;

/**
 * 商品评论
 * 
 */
@Service
public class GoodsEvaluateServiceImpl implements IGoodsEvaluateService {
	@Autowired
	private GoodsEvaluateMapper goodsEvaluateMapper;
	@Autowired
	private OrderMapper orderDao;
	@Autowired
	private IUserService userService;

	@Override
	public MsgBean saveGoodsEvaluate(Integer orderDetailId, Integer score, String content) {

		int userId = SessionHelper.getSessionUser().getUserID();

		OrderDetail orderDetail = orderDao.queryOrderDetail(userId, orderDetailId);

		UserInfo user = userService.queryUserInfoById(userId);

		if (orderDetail == null) {
			return new MsgBean(Code.FAIL, "系统出错，请重试！", MsgLevel.ERROR);
		}
		if (user == null) {
			return new MsgBean(Code.FAIL, "登录已超时，请重新登录！", MsgLevel.ERROR);
		}
		if (orderDetail.isEvaluate()) {
			return new MsgBean(Code.FAIL, "您已经评论过该订单的此款商品了！", MsgLevel.ERROR);
		}

		GoodsEvaluate goodsEvaluate = new GoodsEvaluate();
		goodsEvaluate.setUserId(userId);
		goodsEvaluate.setAddTime(new Date());
		goodsEvaluate.setBuySpec(orderDetail.getPropertystrname());
		goodsEvaluate.setContent(content);
		goodsEvaluate.setGoodsId(orderDetail.getGoodsID());
		goodsEvaluate.setScore(score);
		goodsEvaluate.setSkuId(orderDetail.getSkuID());
		goodsEvaluate.setUserName(user.getRealName());
		goodsEvaluate.setAvatar(user.getAvatar());

		goodsEvaluateMapper.insertSelective(goodsEvaluate);

		orderDetail.setEvaluate(true);
		// 根据订单id,商品id 更新订单详情中商品的评论状态
		int row = orderDao.updateOrderDetailByGoodsIdAndOrderId(orderDetail.getOrderID(), orderDetail.getGoodsID());
		if (row == 0) {
			return new MsgBean(Code.FAIL, "添加出错，请重试！", MsgLevel.ERROR);
		}
		MsgBean msgBean = new MsgBean(Code.SUCCESS, "评论成功！", MsgLevel.NORMAL);
		msgBean.setData(goodsEvaluate);
		return msgBean;
	}

	@Override
	public List<GoodsEvaluate> queryGoodsEvaluatesByPage(PageBean<GoodsEvaluate> page, Integer goodsId, Integer type) {

		return goodsEvaluateMapper.queryGoodsEvaluatesByPage(page, goodsId, type);
	}

	@Override
	public Map<String, Integer> countCommentsByScore(int goodsId) {

		Map<String, Integer> map = goodsEvaluateMapper.countCommentsByScore(goodsId);

		return map;
	}

	@Override
	public int addMerchantReply(String reply, Long id) {
		return goodsEvaluateMapper.addMerchantReply(reply, id);
	}

	@Override
	public GoodsEvaluate queryGoodsEvaluatesById(Long id) {
		return goodsEvaluateMapper.selectByPrimaryKey(id);
	}

}
