package com.zhigu.service.user;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import com.zhigu.common.SessionUser;
import com.zhigu.model.LoginLog;
import com.zhigu.model.UserAuth;
import com.zhigu.model.UserInfo;
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
	 * @param openId
	 * @return
	 */
	public MsgBean openIDLogin(String openId);

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
	 * 刷新SessionUser对象
	 */
	public void refreshSessionUser();

	/**
	 * 用户上次登录日志
	 * 
	 * @param userID
	 * @return
	 */
	public LoginLog queryLastTimeLogin(int userID);

}
