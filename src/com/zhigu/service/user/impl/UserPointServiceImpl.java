package com.zhigu.service.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.constant.enumconst.PointType;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.ServiceMsg;
import com.zhigu.mapper.PointMapper;
import com.zhigu.mapper.UserMapper;
import com.zhigu.model.PageBean;
import com.zhigu.model.PointExchangeGoods;
import com.zhigu.model.SendAward;
import com.zhigu.model.UserPoint;
import com.zhigu.model.UserPointExchange;
import com.zhigu.service.user.IUserPointService;

@Service
public class UserPointServiceImpl implements IUserPointService {
	@Autowired
	private UserMapper userDao;
	@Autowired
	private PointMapper pointDao;

	@Override
	public int saveUserPoint(UserPoint userPoint) {
		return userDao.saveUserPoint(userPoint);
	}

	@Override
	public int updateUserPoint(UserPoint userPoint) {
		UserPoint oldUserPoint = userDao.queryUserPoint(userPoint.getUserID());
		if (oldUserPoint != null) {
			oldUserPoint.setName(userPoint.getName());
			oldUserPoint.setPhone(userPoint.getPhone());
			oldUserPoint.setAddress(userPoint.getAddress());
			return userDao.updateUserPoint(oldUserPoint);
		} else {
			ServiceMsg.addMsg(1, "未找到用户充值记录！", MsgLevel.ERROR);
		}
		return 0;
	}

	@Override
	public UserPoint queryUserPoint(int userID) {
		return userDao.queryUserPoint(userID);
	}

	@Override
	public int updateRechargePoint(int userID, float rechargePoint) {
		UserPoint userPoint = userDao.queryUserPoint(userID);
		if (userPoint == null) {
			userPoint = new UserPoint();
			userPoint.setUserID(userID);
			userDao.saveUserPoint(userPoint);
		}
		userPoint.setRechargePoint(userPoint.getRechargePoint() + rechargePoint);
		return userDao.updateUserPoint(userPoint);
	}

	@Override
	public List<UserPoint> queryUserPointByPage(PageBean page) {
		return userDao.queryUserPointByPage(page);
	}

	@Override
	public int saveSendAward(SendAward sendAward) {
		UserPoint userPoint = userDao.queryUserPoint(sendAward.getUserID());
		int code = 0;
		float newRechargePoint = userPoint.getRechargePoint() - sendAward.getUsePoint();
		if (newRechargePoint >= 0) {
			userPoint.setRechargePoint(newRechargePoint);
			userDao.updateUserPoint(userPoint);
			sendAward.setOrignalPoint(userPoint.getRechargePoint());
			code = userDao.saveSendAward(sendAward);
		} else {
			ServiceMsg.addMsg(1, "积分点不足！", MsgLevel.ERROR);
		}
		return code;
	}

	@Override
	public List<SendAward> querySendAwardByUserID(int userID) {
		return userDao.querySendAwardByUserID(userID);
	}

	@Override
	public int saveUserPointExchange(UserPointExchange userPointExchange) {
		PointExchangeGoods pGoods = pointDao.queryPointExchangeGoodsById(userPointExchange.getExchangeId());
		if (pGoods.getStatus() == 0) {
			throw new ServiceException("该积分商品已不可兑换！");
		}
		UserPoint userPoint = userDao.queryUserPoint(userPointExchange.getUserId());
		// 使用充值积分兑换
		if (pGoods.getPointType() == PointType.POINT_RECHARGE.getValue()) {

			if (!(pGoods.getRepertory() > 0)) {
				ServiceMsg.setMsg(Code.FAIL, "库存不足！", MsgLevel.ERROR);
				return 0;
			}
			float surplusPoint = userPoint.getRechargePoint() - pGoods.getNeedPoint();
			if (surplusPoint >= 0) {
				userPointExchange.setOrignalPoint(userPoint.getRechargePoint());

				userPointExchange.setPointType(PointType.POINT_RECHARGE.getValue());
				// 更新用户剩余充值积分
				userPoint.setRechargePoint(surplusPoint);
				userDao.updateUserPoint(userPoint);
			} else {
				ServiceMsg.setMsg(Code.FAIL, "充值积分不足，不能兑换该物品！", MsgLevel.ERROR);
				return 0;
			}
		} else if (pGoods.getPointType() == PointType.POINT_SHOPPING_GOODS.getValue()) {
			float surplusPoint = userPoint.getGoodsPoint() - pGoods.getNeedPoint();
			if (surplusPoint >= 0) {
				userPointExchange.setOrignalPoint(userPoint.getGoodsPoint());
				userPointExchange.setExchangeName(pGoods.getName());
				userPointExchange.setUsePoint(pGoods.getNeedPoint());
				// 更新用户剩余商品消费积分
				userPoint.setGoodsPoint(userPoint.getGoodsPoint() - pGoods.getNeedPoint());
				userDao.updateUserPoint(userPoint);
			} else {
				ServiceMsg.setMsg(Code.FAIL, "商品消费积分不足，不能兑换该物品！", MsgLevel.ERROR);
				return 0;
			}
		} else if (pGoods.getPointType() == PointType.POINT_SHOPPING_SERVICE.getValue()) {
			float surplusPoint = userPoint.getServicePoint() - pGoods.getNeedPoint();
			if (surplusPoint >= 0) {
				userPointExchange.setOrignalPoint(userPoint.getServicePoint());
				userPointExchange.setExchangeName(pGoods.getName());
				userPointExchange.setUsePoint(pGoods.getNeedPoint());
				// 更新用户剩余服务消费积分
				userPoint.setServicePoint(surplusPoint);
				userDao.updateUserPoint(userPoint);
			} else {
				ServiceMsg.setMsg(Code.FAIL, "服务消费积分不足，不能兑换该物品！", MsgLevel.ERROR);
				return 0;
			}
		} else {
			// ServiceMsg.setMsg(Code.FAIL, "商品的积分类型错误！", MsgLevel.ERROR);
			throw new ServiceException("商品的积分类型错误！");
		}

		userPointExchange.setExchangeName(pGoods.getName());
		userPointExchange.setUsePoint(pGoods.getNeedPoint());
		pGoods.setRepertory(pGoods.getRepertory() - 1);
		pointDao.updatePointExchangeGoodsRepertory(pGoods);
		// 保存兑换记录
		int row = userDao.saveUserPointExchange(userPointExchange);
		StringBuilder sb = new StringBuilder();
		sb.append("兑换 ");
		sb.append(userPointExchange.getExchangeName());
		sb.append(" 成功。使用 ");
		sb.append(pGoods.getPointTypeLabel());
		sb.append(":");
		sb.append(userPointExchange.getUsePoint());
		sb.append("（剩余：");
		sb.append(userPointExchange.getOrignalPoint() - userPointExchange.getUsePoint());
		sb.append(")。");
		ServiceMsg.setMsg(Code.SUCCESS, sb.toString(), MsgLevel.NORMAL);
		return row;
	}

	@Override
	public List<UserPointExchange> queryUserPointExchange(PageBean<UserPointExchange> page) {
		return userDao.queryUserPointExchange(page);
	}

	@Override
	public int handlerSendUserPointExchange(int id, String comment) {
		UserPointExchange ue = new UserPointExchange();
		ue.setId(id);
		ue.setComment(comment);
		ue.setAdminId(SessionHelper.getSessionAdmin().getId());
		ue.setStatus(Flg.ON);
		return userDao.updateUserPointExchange(ue);
	}

}
