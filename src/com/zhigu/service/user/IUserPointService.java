package com.zhigu.service.user;

import java.util.List;

import com.zhigu.model.PageBean;
import com.zhigu.model.SendAward;
import com.zhigu.model.UserPoint;
import com.zhigu.model.UserPointExchange;

/**
 * 活动获奖用户
 * 
 * @author HeSiMin
 * @date 2014年9月29日
 *
 */
public interface IUserPointService {
	/**
	 * 活动获奖人相关信息
	 * 
	 * @param userPoint
	 * @return
	 */
	public int saveUserPoint(UserPoint userPoint);

	/**
	 * 更新活动获奖人信息
	 * 
	 * @param userPoint
	 * @return
	 */
	public int updateUserPoint(UserPoint userPoint);

	/**
	 * 查询活动获奖人信息
	 * 
	 * @param userID
	 * @return
	 */
	public UserPoint queryUserPoint(int userID);

	/**
	 * 加充值积分点记录，无记录时添加新纪录
	 * 
	 * @param userID
	 * @param rechargePoint
	 * @return
	 */
	public int updateRechargePoint(int userID, float rechargePoint);

	/**
	 * 充值活动用户
	 * 
	 * @param page
	 * @return
	 */
	public List<UserPoint> queryUserPointByPage(PageBean page);

	/**
	 * 保存发送奖励记录
	 * 
	 * @param sendAward
	 * @return
	 */
	public int saveSendAward(SendAward sendAward);

	/**
	 * 用户的发送奖励记录
	 * 
	 * @param userID
	 * @return
	 */
	public List<SendAward> querySendAwardByUserID(int userID);

	/**
	 * 保存用户积分兑换
	 * 
	 * @param userPointExchange
	 * @return
	 */
	public int saveUserPointExchange(UserPointExchange userPointExchange);

	/**
	 * 发送用户积分兑换物品
	 * 
	 * @param id
	 * @param comment
	 * @return
	 */
	public int handlerSendUserPointExchange(int id, String comment);

	/**
	 * 分页查询用户积分兑换
	 * 
	 * @param page
	 * @return
	 */
	public List<UserPointExchange> queryUserPointExchange(PageBean<UserPointExchange> page);
}
