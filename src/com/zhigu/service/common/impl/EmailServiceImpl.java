package com.zhigu.service.common.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.EmailVerifyStatus;
import com.zhigu.common.constant.EmailVerifyType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.common.utils.mail.MailMessage;
import com.zhigu.common.utils.mail.MailSender;
import com.zhigu.mapper.EmailVerifyMapper;
import com.zhigu.mapper.UserMapper;
import com.zhigu.model.EmailVerify;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.IEmailService;
import com.zhigu.service.user.IUserService;

@Service
public class EmailServiceImpl implements IEmailService {
	@Autowired
	private EmailVerifyMapper emailVerifyMapper;
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private IUserService userService;

	/** 邮件有效时间（小时） */
	private static final int EXPIRE_HOURS = 6;
	private static final String PARAM_USER_ID = "userId";

	@Override
	public MsgBean sendBindEmail(String email) {
		if (!VerifyUtil.emailVerify(email)) {
			return new MsgBean(Code.FAIL, "无效邮箱地址", MsgLevel.ERROR);
		}
		// 绑定邮件数据，存入数据库
		UserAuth user = userMapper.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserID());
		EmailVerify ev = new EmailVerify();
		ev.setStatus(EmailVerifyStatus.UNUSED);
		ev.setExpireTime(DateUtils.addHours(new Date(), EXPIRE_HOURS));
		ev.setType(EmailVerifyType.BIND);
		String uid = UUID.randomUUID().toString().replaceAll("-", "");
		ev.setUid(uid);
		ev.setMail(email);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put(PARAM_USER_ID, user.getUserID());
		ev.setJsonParam(JSON.toJSONString(param));
		emailVerifyMapper.insert(ev);

		// 发送邮件
		MailMessage msg = new MailMessage(email, "智谷同城网|邮箱绑定", "智谷同城网邮箱绑定，链接6小时内有效，点击下面链接完成邮箱绑定：" + ZhiguConfig.getHost() + "/email/verifyBindEmail?type=" + EmailVerifyType.BIND + "&uid=" + uid);
		MailSender.sendTextMail(msg);
		return new MsgBean(Code.SUCCESS, "绑定邮件已发送，请登录邮箱确认", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean verifyBindEmail(String uid) {
		EmailVerify ev = this.queryVerifyEmail(uid, EmailVerifyType.BIND);
		if (ev == null) {
			return new MsgBean(Code.FAIL, "无效的邮件的邮件链接，请重新发送验证邮件", MsgLevel.ERROR);
		}
		// 取出参数，修改email
		@SuppressWarnings("unchecked")
		Map<String, Object> param = JSON.parseObject(ev.getJsonParam(), Map.class);
		int userId = Integer.parseInt(param.get(PARAM_USER_ID).toString());
		userService.updateEmail(userId, ev.getMail());

		// 修改为已使用
		ev.setStatus(EmailVerifyStatus.USED);
		emailVerifyMapper.updateByPrimaryKey(ev);
		return new MsgBean(Code.SUCCESS, "账户邮箱成功绑定为：" + ev.getMail(), MsgLevel.NORMAL);
	}

	@Override
	public MsgBean sendPasswordResetEmail(String loginName) {
		// UserAuth user =
		// userMapper.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserID());
		UserAuth user = userService.queryUserAuthByLoginName(loginName);
		if (user == null) {
			return new MsgBean(Code.FAIL, "未找到此账号", MsgLevel.ERROR);
		}
		// 绑定邮件数据，存入数据库
		EmailVerify ev = new EmailVerify();
		ev.setExpireTime(DateUtils.addHours(new Date(), EXPIRE_HOURS));
		ev.setStatus(EmailVerifyStatus.UNUSED);
		ev.setType(EmailVerifyType.PASSWORD_RESET);
		String uid = UUID.randomUUID().toString().replaceAll("-", "");
		ev.setUid(uid);
		ev.setMail(user.getEmail());
		Map<String, Object> param = new HashMap<String, Object>();
		param.put(PARAM_USER_ID, user.getUserID());
		ev.setJsonParam(JSON.toJSONString(param));
		emailVerifyMapper.insert(ev);

		// 发送邮件
		MailMessage msg = new MailMessage(user.getEmail(), "智谷同城网|密码重置", "智谷同城网密码重置，链接6小时内有效，点击下面链接完成邮箱绑定：" + ZhiguConfig.getHost() + "security/retrieve/step2Email?type="
				+ EmailVerifyType.PASSWORD_RESET + "&uid=" + uid);
		MailSender.sendTextMail(msg);
		return new MsgBean(Code.SUCCESS, "密码重置邮件已发送至 " + StringUtil.hideEmail(ev.getMail()) + "，请登录邮箱确认", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean verifyPasswordResetEmail(String uid, String newPassword) {
		EmailVerify ev = this.queryVerifyEmail(uid, EmailVerifyType.PASSWORD_RESET);
		if (ev == null) {
			return new MsgBean(Code.FAIL, "无效的邮件的邮件链接，请重新发送验证邮件", MsgLevel.ERROR);
		}
		MsgBean msg = userService.resetLoginPwd(ev.getMail(), newPassword);
		if (msg.getCode() == Code.SUCCESS) {
			// 修改为已使用
			ev.setStatus(EmailVerifyStatus.USED);
			emailVerifyMapper.updateByPrimaryKey(ev);
		}
		return msg;
	}

	@Override
	public EmailVerify queryVerifyEmail(String uid, int emailVerifyType) {
		EmailVerify ev = emailVerifyMapper.selectByUid(uid);
		if (ev == null || ev.getType() != emailVerifyType) {
			return null;
		}
		// 过期和已使用check
		if (ev.getExpireTime().getTime() < new Date().getTime() || ev.getStatus() != EmailVerifyStatus.UNUSED) {
			return null;
		}
		return ev;
	}

}
