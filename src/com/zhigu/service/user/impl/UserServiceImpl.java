package com.zhigu.service.user.impl;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.time.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.Common;
import com.zhigu.common.constant.CookieKey;
import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.SystemConstants;
import com.zhigu.common.constant.UserAuthStatus;
import com.zhigu.common.constant.UserType;
import com.zhigu.common.constant.enumconst.AuthStatus;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.common.utils.Md5;
import com.zhigu.common.utils.NetUtil;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.StringUtil.RandomType;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.mapper.AccountMapper;
import com.zhigu.mapper.AdminMemberMapper;
import com.zhigu.mapper.OpenUserMapper;
import com.zhigu.mapper.StoreMapper;
import com.zhigu.mapper.UserMapper;
import com.zhigu.model.Account;
import com.zhigu.model.LoginLog;
import com.zhigu.model.OpenUser;
import com.zhigu.model.Store;
import com.zhigu.model.UserAuth;
import com.zhigu.model.UserInfo;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.ILoginLogService;
import com.zhigu.service.user.IUserService;

/**
 * 
 * @author ZhouQiBing
 * @date 2014年7月20日
 * @Description:
 */
@Service
public class UserServiceImpl implements IUserService {
	private static final Logger logger = Logger.getLogger(UserServiceImpl.class);
	@Autowired
	private OpenUserMapper openUserMapper;
	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private UserMapper userDao;
	@Autowired
	private IAccountService accountService;
	@Autowired
	private ILoginLogService loginLogService;
	@Autowired
	private AdminMemberMapper memberDao;
	@Autowired
	private StoreMapper storeMapper;

	@Override
	public UserAuth queryUserAuthByPhone(String phone) {
		return userDao.queryUserAuthByPhone(phone);
	}

	@Override
	public UserAuth queryUserAuthByEmail(String email) {
		return userDao.queryUserAuthByEmail(email);
	}

	@Override
	public UserAuth queryUserAuthByUsername(String username) {
		return userDao.queryUserAuthByUsername(username);
	}

	@Override
	public UserAuth queryUserAuthByLoginName(String loginName) {
		UserAuth auth = null;
		if (VerifyUtil.emailVerify(loginName)) {
			auth = queryUserAuthByEmail(loginName);
		} else if (VerifyUtil.phoneVerify(loginName)) {
			auth = queryUserAuthByPhone(loginName);
		} else {
			auth = queryUserAuthByUsername(loginName);
		}
		return auth;
	}

	private String generateUsername() {
		for (int i = 1; i <= 10; i++) {
			String username = "tc_" + StringUtil.randomStr(RandomType.MIXTURE, 8);
			if (queryUserAuthByUsername(username) == null)
				return username;
		}
		return "tc_" + System.currentTimeMillis();
	}

	@Override
	public UserInfo queryUserInfoById(int userID) {
		return userDao.queryUserInfoById(userID);
	}

	@Override
	public UserAuth queryUserAuthByUserID(int userID) {
		return userDao.queryUserAuthByUserID(userID);
	}

	@Override
	public MsgBean updatePhone(int userID, String phone) {
		UserAuth auth = userDao.queryUserAuthByPhone(phone);
		if (auth != null) {
			if (auth.getUserID() == userID) {
				return new MsgBean(Code.FAIL, "新手机号不能和原手机号码一样", MsgLevel.ERROR);
			} else {
				return new MsgBean(Code.FAIL, "手机号已被使用", MsgLevel.ERROR);
			}
		}
		userDao.updateUserInfoPhone(userID, phone);
		userDao.updateUserAuthPhone(userID, phone);
		return new MsgBean(Code.SUCCESS, "绑定成功", MsgLevel.NORMAL);
	}

	@Override
	public void updateEmail(int userID, String email) {
		userDao.updateUserAuthEmail(userID, email);
		userDao.updateUserInfoEmail(userID, email);
	}

	@Override
	public MsgBean updateLoginPwd(String oldPassword, String newPassword) {
		int userId = SessionHelper.getSessionUser().getUserID();

		UserAuth auth = userDao.queryUserAuthByUserID(userId);
		// 存在原始密码，则要求传入旧密码
		if (!StringUtil.isEmpty(auth.getPassword())) {
			if (StringUtil.isEmpty(oldPassword) || !Md5.convert(oldPassword, auth.getSalt()).equals(auth.getPassword())) {
				return new MsgBean(Code.FAIL, "原始密码输入错误", MsgLevel.ERROR);
			}
		}
		if (!VerifyUtil.passwordVerify(newPassword)) {
			return new MsgBean(Code.FAIL, "密码为6-16个字符，必须包含数字、字母", MsgLevel.ERROR);
		}

		String salt = StringUtil.randomStr(RandomType.MIXTURE, 6);
		int row = userDao.updateLoginPwd(userId, Md5.convert(newPassword, salt), salt);
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}

		return new MsgBean(Code.SUCCESS, "密码修改成功", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean saveUserAuth(String username, String password) {
		String ip = NetUtil.getIpAddr(SessionHelper.getRequest());

		Date countIpTime = DateUtils.addHours(new Date(), 24);
		if (userDao.countUserAuthByIp(ip, DateUtil.format(countIpTime, DateUtil.yyyy_MM_dd_HH_mm_ss)) > 15) {
			return new MsgBean(Code.FAIL, "同一IP在天之内只能注册15个账号！", MsgLevel.ERROR);
		}
		if (!VerifyUtil.phoneVerify(username)) {
			return new MsgBean(Code.FAIL, "手机号码错误！", MsgLevel.ERROR);
		}
		if (userDao.queryUserAuthByPhone(username) != null) {
			return new MsgBean(Code.FAIL, "手机号码已被注册使用！", MsgLevel.ERROR);
		}
		// 密码
		if (!VerifyUtil.passwordVerify(password)) {
			return new MsgBean(Code.FAIL, "密码为6-16个字符，必须包含数字、字母！", MsgLevel.ERROR);
		}

		// 用户认证信息
		UserAuth auth = new UserAuth();
		auth.setUsername(generateUsername());
		auth.setRegisterIP(ip);
		String salt = StringUtil.randomStr(RandomType.MIXTURE, 6);
		auth.setPassword(Md5.convert(password, salt));
		auth.setSalt(salt);
		auth.setStatus(1);// 正常
		if (VerifyUtil.emailVerify(username)) {
			auth.setEmail(username);
		} else if (VerifyUtil.phoneVerify(username)) {
			auth.setPhone(username);
		}
		// 保存用户认证信息，并得到userId
		userDao.saveUserAuth(auth);

		int userId = auth.getUserID();
		// 用户基本信息
		UserInfo info = new UserInfo();
		info.setUserID(userId);
		info.setEmail(auth.getEmail());
		info.setPhone(auth.getPhone());
		info.setNickName(auth.getUsername());
		info.setRegisterTime(new Date());
		info.setRealUserAuthFlg(AuthStatus.ON_AUTH.getValue());

		userDao.saveUserInfo(info);

		// 保存帐户信息
		Account acc = new Account();
		acc.setUserId(userId);
		acc.setFreezeMoney(new BigDecimal(0));
		acc.setNormalMoney(new BigDecimal(0));
		acc.setVersion(0);

		accountMapper.insert(acc);

		return new MsgBean(Code.SUCCESS, "注册成功", MsgLevel.NORMAL);
	}

	@Override
	public void updateUserInfo(String username, UserInfo info) {
		userDao.updateUserInfo(info);
		if (!StringUtil.isEmpty(username)) {
			UserAuth auth = userDao.queryUserAuthByUserID(info.getUserID());
			if (!auth.getUsername().equals(username))
				userDao.updateUsername(info.getUserID(), username);
			refreshSessionUser();
		}

	}

	/**
	 * 修改头像
	 * 
	 * @param path
	 * @param userID
	 */
	public void updateAvatar(String path, int userID) {
		userDao.updateAvatar(path, userID);
		refreshSessionUser();
	}

	@Override
	public SessionUser getSessionUser(int userID) {
		UserAuth auth = userDao.queryUserAuthByUserID(userID);
		UserInfo info = queryUserInfoById(userID);

		SessionUser sess = new SessionUser();
		sess.setUserID(userID);
		sess.setUsername(auth.getUsername());
		if (info.getAvatar() != null) {
			sess.setAvatar(info.getAvatar());
		}
		sess.setUserType(info.getUserType());
		if (sess.getUserType() > UserType.USER) {
			Store store = storeMapper.queryStoreByUserID(userID);
			sess.setStoreId(store.getID());
		}
		return sess;
	}

	@Override
	public void refreshSessionUser() {
		SessionUser su = SessionHelper.getSessionUser();
		if (su != null)
			SessionHelper.setSessionUser(this.getSessionUser(su.getUserID()));
	}

	@Override
	public LoginLog queryLastTimeLogin(int userID) {
		return loginLogService.queryPreviousLoginLogByUserID(userID);
	}

	@Override
	public MsgBean login(String username, String password) {
		return login(username, password, null, null);
	}

	@Override
	public MsgBean login(String username, String password, String autoLogin, HttpServletResponse response) {
		UserAuth auth = this.queryUserAuthByLoginName(username);
		// 用户名或错误
		if (auth == null || !Md5.convert(password, auth.getSalt()).equals(auth.getPassword())) {
			if (auth != null) {
				loginFailLog(auth.getUserID());
			}
			return new MsgBean(Code.FAIL, "用户名或密码填写错误！", MsgLevel.ERROR);
		}
		if (auth.getStatus() == UserAuthStatus.FREEZE) {
			return new MsgBean(Code.FAIL, "帐号已被冻结，请联系客服！", MsgLevel.ERROR);
		}
		// 登录成功，转向用户中心
		SessionUser sess = this.getSessionUser(auth.getUserID());
		SessionHelper.setSessionUser(sess);
		this.loginSucessLog();

		// 设置自动登录
		if ("1".equals(autoLogin) && response != null) {
			Cookie cu = null;
			try {
				cu = new Cookie(CookieKey.USER_NAME, URLEncoder.encode(username, Common.UTF_8));
				cu.setMaxAge(7 * 24 * 60 * 60);// 7天
				cu.setPath("/");
				// MD5(加密密码 + randomStr)
				Cookie cp = new Cookie(CookieKey.USER_PASSWORD, Md5.convert(auth.getPassword(), SystemConstants.RANDOM_KEY));
				cp.setMaxAge(7 * 24 * 60 * 60);// 7天
				cp.setPath("/");

				response.addCookie(cu);
				response.addCookie(cp);
			} catch (UnsupportedEncodingException e) {
				logger.warn("encode error", e);
			}
		}
		return new MsgBean(Code.SUCCESS, "登陆成功", MsgLevel.NORMAL);
	}

	@Override
	public boolean cookieLogin(Cookie[] cookies) {
		SessionUser sessionUser = SessionHelper.getSessionUser();
		if (sessionUser != null) {
			return true;
		}
		if (cookies != null) {
			Map<String, String> map = new HashMap<String, String>();
			for (Cookie ck : cookies) {
				map.put(ck.getName(), ck.getValue());
			}
			// 取得用户名与密码
			String username = map.get(CookieKey.USER_NAME);
			String password = map.get(CookieKey.USER_PASSWORD);

			if (!StringUtil.isEmpty(username, password)) {
				try {
					username = URLDecoder.decode(username, Common.UTF_8);
				} catch (UnsupportedEncodingException e) {
					logger.warn("decode error", e);
					return false;
				}
				UserAuth auth = this.queryUserAuthByLoginName(username);
				// cookie验证,与加密写入cookie一致
				if (auth != null && Md5.convert(auth.getPassword(), SystemConstants.RANDOM_KEY).equals(password)) {
					sessionUser = this.getSessionUser(auth.getUserID());
					SessionHelper.setSessionUser(sessionUser);
					// 添加登陆日志
					this.loginSucessLog();
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public MsgBean openIDLogin(String openId) {
		OpenUser openUser = openUserMapper.selectByOpenId(openId);
		if (openUser == null) {
			return new MsgBean(Code.FAIL, "未找到openID", MsgLevel.ERROR);
		}
		UserAuth ua = userDao.queryUserAuthByUserID(openUser.getUserId());
		if (ua == null) {
			openUserMapper.deleteByPrimaryKey(openUser.getId());
			return new MsgBean(Code.FAIL, "账号不存在，请重新绑定！", MsgLevel.ERROR);
		}
		if (ua.getStatus() == UserAuthStatus.FREEZE) {
			return new MsgBean(Code.FAIL, "帐号已被冻结，请联系客服！", MsgLevel.ERROR);
		}
		SessionUser sess = this.getSessionUser(openUser.getUserId());
		SessionHelper.setSessionUser(sess);
		this.loginSucessLog();
		return new MsgBean(Code.SUCCESS, "登陆成功", MsgLevel.NORMAL);
	}

	private void loginSucessLog() {
		SessionUser sess = SessionHelper.getSessionUser();
		if (sess == null)
			return;

		// 添加登陆日志
		HttpServletRequest request = SessionHelper.getRequest();

		LoginLog loginLog = new LoginLog();
		loginLog.setUserID(sess.getUserID());
		loginLog.setLoginDate(new Date());
		loginLog.setIP(NetUtil.getIpAddr(request));
		loginLog.setBrowser(request.getHeader("User-Agent"));
		loginLog.setLoginStatus(Flg.ON);
		loginLogService.addLoginLog(loginLog);
	}

	/**
	 * 登录日志
	 */
	private void loginFailLog(int userID) {
		// 添加登陆日志
		HttpServletRequest request = SessionHelper.getRequest();

		LoginLog loginLog = new LoginLog();
		loginLog.setUserID(userID);
		loginLog.setLoginDate(new Date());
		loginLog.setIP(NetUtil.getIpAddr(request));
		loginLog.setBrowser(request.getHeader("User-Agent"));
		loginLog.setLoginStatus(Flg.OFF);
		loginLogService.addLoginLog(loginLog);
	}

	@Override
	public MsgBean resetLoginPwd(String userName, String newPassword) {
		UserAuth auth = this.queryUserAuthByLoginName(userName);
		if (auth == null) {
			return new MsgBean(Code.FAIL, "用户不存在", MsgLevel.ERROR);
		}
		if (!VerifyUtil.passwordVerify(newPassword)) {
			return new MsgBean(Code.FAIL, "密码为6-16个字符，必须包含数字、字母", MsgLevel.ERROR);
		}
		String salt = StringUtil.randomStr(RandomType.MIXTURE, 6);
		int row = userDao.updateLoginPwd(auth.getUserID(), Md5.convert(newPassword, salt), salt);
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		return new MsgBean(Code.SUCCESS, "密码修改成功", MsgLevel.NORMAL);
	}
}
