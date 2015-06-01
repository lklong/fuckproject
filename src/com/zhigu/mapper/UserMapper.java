package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.PageBean;
import com.zhigu.model.SendAward;
import com.zhigu.model.UserAuth;
import com.zhigu.model.UserInfo;
import com.zhigu.model.UserPoint;
import com.zhigu.model.UserPointExchange;
import com.zhigu.model.UserRecommend;
import com.zhigu.model.UserTaobao;

/**
 * 会员数据访问
 *
 * @author ZhouQiBing
 * @date 2014年7月20日
 * @Description:
 */
public interface UserMapper {
	/**
	 * ip注册数统计
	 * 
	 * @param ip
	 * @param startTime
	 * @return
	 */
	public int countUserAuthByIp(@Param("ip") String ip, @Param("startTime") String startTime);

	/**
	 * 电话查询认证信息
	 * 
	 * @param phone
	 * @return
	 */
	public UserAuth queryUserAuthByPhone(String phone);

	/**
	 * Email查询认证信息
	 * 
	 * @param email
	 * @return
	 */
	public UserAuth queryUserAuthByEmail(String email);

	/**
	 * 用户名查询认证信息
	 * 
	 * @param username
	 * @return
	 */
	public UserAuth queryUserAuthByUsername(String username);

	/**
	 * 保存用户的认证信息
	 * 
	 * @param auth
	 * @return
	 */
	public int saveUserAuth(UserAuth auth);

	/**
	 * 保存用户信息
	 * 
	 * @param info
	 */
	public void saveUserInfo(UserInfo info);

	/**
	 * 查询用户认证信息
	 * 
	 * @param userID
	 * @return
	 */
	public UserAuth queryUserAuthByUserID(int userID);

	/**
	 * 查询用户基本信息
	 * 
	 * @param userID
	 * @return
	 */
	public UserInfo queryUserInfoById(int userID);

	/**
	 * 修改手机号
	 * 
	 * @param userID
	 * @param phone
	 */
	public void updateUserInfoPhone(@Param("userID") int userID, @Param("phone") String phone);

	/**
	 * 修改手机号
	 * 
	 * @param userID
	 * @param phone
	 */
	public void updateUserAuthPhone(@Param("userID") int userID, @Param("phone") String phone);

	/**
	 * 修改用户认证邮箱
	 * 
	 * @param userID
	 * @param email
	 */
	public void updateUserAuthEmail(@Param("userID") int userID, @Param("email") String email);

	/**
	 * 修改用户信息邮箱
	 * 
	 * @param userID
	 * @param email
	 */
	public void updateUserInfoEmail(@Param("userID") int userID, @Param("email") String email);

	/**
	 * 修改userInfo的实名认证Flg
	 * 
	 * @param userID
	 * @param realUserFlg
	 * @return
	 */
	public int updateUserInfoRealUserFlg(@Param("userID") int userID, @Param("realUserFlg") int realUserFlg);

	/**
	 * 修改用户名
	 * 
	 * @param userID
	 * @param username
	 */
	public void updateUsername(@Param("userID") int userID, @Param("username") String username);

	/**
	 * 修改登录密码
	 * 
	 * @param userID
	 * @param pwd
	 */
	public int updateLoginPwd(@Param("userID") int userID, @Param("pwd") String pwd, @Param("salt") String salt);

	/**
	 * 修改用户基本信息
	 * 
	 * @param info
	 */
	public void updateUserInfo(UserInfo info);

	/**
	 * 修改头像
	 * 
	 * @param path
	 * @param userID
	 */
	public void updateAvatar(@Param("path") String path, @Param("userID") int userID);

	/**
	 * 修改用户类型
	 * 
	 * @param userID
	 * @param userType
	 */
	public int updateUserType(@Param("userID") int userID, @Param("userType") int userType);

	/**
	 * 更新userauth的用户登录记录（最后登录时间，登录count）
	 * 
	 * @param userID
	 */
	public void updateUserauthInfoLoginData(int userID);

	/**
	 * 添加用户淘宝
	 * 
	 * @param userTaobao
	 */
	public void addUserTaobao(UserTaobao userTaobao);

	/**
	 * 查询用户淘宝（取最新的一条）
	 * 
	 * @param userID
	 * @return
	 */
	public UserTaobao queryUserTaobaoByUserID(int userID);

	/**
	 * 修改用户等级点数（plus：LevelPoint+=#{levelPoint}）
	 * 
	 * @param userID
	 * @param levelPoint
	 */
	public void updateLevelPoint(@Param("userID") int userID, @Param("levelPoint") int levelPoint);

	/**
	 * 活动获奖人相关信息
	 * 
	 * @param UserPoint
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
	 * 查询用户的已注册被推荐人
	 * 
	 * @param userID
	 * @return
	 */
	public List<UserInfo> queryRecommended(int userID);

	/**
	 * 更新用户保证金等级
	 * 
	 * @param userInfo
	 * @return
	 */
	public int updateDepositLevel(UserInfo userInfo);

	/**
	 * 保存用户积分兑换
	 * 
	 * @param userPointExchange
	 * @return
	 */
	public int saveUserPointExchange(UserPointExchange userPointExchange);

	/**
	 * 更新用户积分兑换
	 * 
	 * @param userPointExchange
	 * @return
	 */
	public int updateUserPointExchange(UserPointExchange userPointExchange);

	/**
	 * 分页查询用户积分兑换
	 * 
	 * @param page
	 * @return
	 */
	public List<UserPointExchange> queryUserPointExchange(PageBean<UserPointExchange> page);

	/**
	 * 添加用户推荐人,推荐人主动记录
	 * 
	 * @param userRecommend
	 * @return
	 */
	public int saveUserRecommend(UserRecommend userRecommend);

	/**
	 * 查询用户推荐人
	 * 
	 * @param recommendPhone
	 * @return
	 */
	public UserRecommend queryUserRecommend(String recommendPhone);

	/**
	 * 查询用户填写的推荐
	 * 
	 * @param userID
	 * @return
	 */
	public List<UserRecommend> queryUserRecommendByUserIDByPage(@Param("page") PageBean<UserRecommend> page, @Param("userID") int userID);

	/**
	 * 查询用户填写的推荐人
	 * 
	 * @param id
	 * @return
	 */
	public UserRecommend queryUserRecommendById(int id);

	/**
	 * 删除用户填写的推荐人
	 * 
	 * @param id
	 * @return
	 */
	public int deleteUserRecommend(int id);

}
