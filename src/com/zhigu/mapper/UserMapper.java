package com.zhigu.mapper;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.UserAuth;
import com.zhigu.model.UserInfo;

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

}
