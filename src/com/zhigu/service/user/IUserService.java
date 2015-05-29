package com.zhigu.service.user;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import com.zhigu.common.SessionUser;
import com.zhigu.model.LoginLog;
import com.zhigu.model.PageBean;
import com.zhigu.model.RealUserAuth;
import com.zhigu.model.UserAuth;
import com.zhigu.model.UserInfo;
import com.zhigu.model.UserRecommend;
import com.zhigu.model.UserTaobao;
import com.zhigu.model.dto.MsgBean;

/**
 * 会员服务
 *
 * @author ZhouQiBing
 * @date 2014年7月20日
 * @Description:
 */
public interface IUserService {

	/**
	 * 用户登陆
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	public MsgBean login(String username, String password);

	public MsgBean login(String username, String password, String autoLogin, HttpServletResponse response);

	/**
	 * cookie登陆
	 * 
	 * @param cookies
	 * @return true : 登陆成功 false : 登陆失败
	 */
	public boolean cookieLogin(Cookie[] cookies);

	/**
	 * 第三方登陆
	 * 
	 * @param openID
	 * @return
	 */
	public MsgBean openIDLogin(String openID);

	/**
	 * 取得sessionUser对象
	 * 
	 * @param userID
	 * @return
	 */
	public SessionUser getSessionUser(int userID);

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
	 * 登录名
	 * 
	 * @param loginName
	 *            绑定邮箱、绑定手机、平台账号
	 * @return
	 */
	public UserAuth queryUserAuthByLoginName(String loginName);

	/**
	 * 保存用户认证信息，生成帐号
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	public MsgBean saveUserAuth(String username, String password);

	/**
	 * 查询用户基本信息
	 * 
	 * @return
	 */
	public UserInfo queryUserInfoById(int userID);

	/**
	 * 查询用户认证信息
	 * 
	 * @return
	 */
	public UserAuth queryUserAuthByUserID(int userID);

	/**
	 * 登录验证
	 * 
	 * @param username
	 * @param pwd
	 * @return
	 */
	public UserAuth verifyLogin(String username, String pwd);

	/**
	 * 修改手机号
	 * 
	 * @param userID
	 * @param phone
	 */
	public MsgBean updatePhone(int userID, String phone);

	/**
	 * 修改邮箱
	 * 
	 * @param userID
	 * @param email
	 */
	public void updateEmail(int userID, String email);

	/**
	 * 修改登录密码
	 * 
	 * @param userID
	 * @param pwd
	 */
	public MsgBean updateLoginPwd(String oldPassword, String newPassword);

	/**
	 * 重置登陆密码
	 * 
	 * @param newPassword
	 * @return
	 */
	public MsgBean resetLoginPwd(String userName, String newPassword);

	/**
	 * 修改用户基本信息
	 * 
	 * @param info
	 */
	public void updateUserInfo(String username, UserInfo info);

	/**
	 * 修改头像
	 * 
	 * @param path
	 * @param userID
	 */
	public void updateAvatar(String path, int userID);

	/**
	 * 用户实名认证
	 * 
	 * @param userID
	 */
	public RealUserAuth queryRealUserAuth(int userID);

	/**
	 * 用户实名认证修改
	 * 
	 * @param userID
	 */
	public MsgBean updateRealUserAuth(RealUserAuth realUserAuth);

	/**
	 * 用户实名认证保存
	 * 
	 * @param userID
	 */
	public MsgBean saveRealUserAuth(RealUserAuth realUserAuth);

	/**
	 * 查询用户实名认证
	 * 
	 * @param idcard
	 *            身份证号
	 */
	public RealUserAuth queryRealUserAuthByIdcard(String idcard);

	/**
	 * 刷新SessionUser对象
	 */
	public void refreshSessionUser();

	/**
	 * 添加用户淘宝
	 * 
	 * @param userTaobao
	 */
	public void addUserTaobao(UserTaobao userTaobao);

	/**
	 * 查询用户淘宝(只取有效期内)
	 * 
	 * @param userID
	 * @return
	 */
	public UserTaobao queryUserTaobaoByUserID(int userID);

	/**
	 * 用户上次登录日志
	 * 
	 * @param userID
	 * @return
	 */
	public LoginLog queryLastTimeLogin(int userID);

	/**
	 * 修改用户等级点数（plus：LevelPoint+=#{levelPoint}）
	 * 
	 * @param userID
	 * @param addLevelPoint
	 */
	public void updateLevelPoint(int userID, int addLevelPoint);

	/**
	 * 查询用户的被推荐人
	 * 
	 * @param userID
	 * @return
	 */
	public List<UserInfo> queryRecommended(int userID);

	/**
	 * 支付诚信保证金
	 * 
	 * @param userID
	 * @param depositLevel
	 *            保证金等级
	 * @return
	 */
	public int handlerPayDeposit(int userID, int depositLevel);

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
	public List<UserRecommend> queryUserRecommendByUserID(PageBean<UserRecommend> page, int userID);

	/**
	 * 删除用户填写的推荐
	 * 
	 * @param id
	 */
	public void deleteUserWriteRecommend(int id);

}
