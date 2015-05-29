package com.zhigu.service.common.impl;

import java.util.Date;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.PhoneSendStatus;
import com.zhigu.common.constant.PhoneSendType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.common.utils.NetUtil;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.StringUtil.RandomType;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.common.utils.sms.SMSUtil;
import com.zhigu.mapper.PhoneSendMapper;
import com.zhigu.mapper.UserMapper;
import com.zhigu.model.PhoneSend;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.IPhoneSendService;

@Service
public class PhoneSendServiceImpl implements IPhoneSendService {
	@Autowired
	private PhoneSendMapper phoneSendMapper;
	@Autowired
	private UserMapper userMapper;
	/** 手机验证码有效时间（秒） */
	private static final int PHONE_CAPTCHA_EXPIRY_SECONDS = 120;

	@Override
	public MsgBean send(String phone, int type) {
		if (!VerifyUtil.phoneVerify(phone)) {
			return new MsgBean(Code.FAIL, "手机号码输入错误！", MsgLevel.ERROR);
		}
		Date now = new Date();
		String ip = NetUtil.getIpAddr(SessionHelper.getRequest());

		if (type == 1) {
			// 注册验证码，手机号重复check
			UserAuth user = userMapper.queryUserAuthByPhone(phone);
			if (user != null) {
				return new MsgBean(Code.FAIL, "该手机号码手机号已被注册！", MsgLevel.ERROR);
			}
		}
		// 发送次数check
		int phoneCount = phoneSendMapper.countPhoneSend(phone, null, DateUtil.format(DateUtils.addSeconds(now, 60), DateUtil.yyyy_MM_dd_HH_mm_ss));
		if (phoneCount > 0) {
			return new MsgBean(Code.FAIL, "该手机号码发送频繁，请稍后再发送！", MsgLevel.ERROR);
		}
		int ipCount = phoneSendMapper.countPhoneSend(null, ip, DateUtil.format(DateUtils.addMinutes(now, 10), DateUtil.yyyy_MM_dd_HH_mm_ss));
		if (ipCount > 8) {
			return new MsgBean(Code.FAIL, "短信发送频繁，请稍后再发送！", MsgLevel.ERROR);
		}

		// 根据类型生成短信内容
		String captcha = StringUtil.randomStr(RandomType.NUMBER, 6);
		// String template = SMSTemplate.getTemplate(type);
		// if (StringUtils.isBlank(template)) {
		// return new MsgBean(Code.FAIL, "无效短信内容！", MsgLevel.ERROR);
		// }
		// String content = template.replace("?", captcha);
		String content = null;
		switch (type) {
		case PhoneSendType.DEFAULT:
			content = "本次安全码：" + captcha + ",仅可使用一次,请勿泄漏。";
			break;
		case PhoneSendType.PHONE_REGISTER:
			content = "本次安全码用于手机注册：" + captcha + ",仅可使用一次,请勿泄漏。";
			break;
		case PhoneSendType.PASSWORD_RESET:
			content = "本次安全码用于重置密码：" + captcha + ",仅可使用一次,请勿泄漏。";
			break;
		case PhoneSendType.PHONE_BIND:
			content = "本次安全码用于新手机绑定验证：" + captcha + ",仅可使用一次,请勿泄漏。";
			break;
		case PhoneSendType.PHONE_BIND_OLD_VERIFY:
			content = "本次安全码用于旧手机验证：" + captcha + ",仅可使用一次,请勿泄漏。";
			break;
		case PhoneSendType.PAY_PASSWORD:
			content = "本次安全码用于支付密码设置：" + captcha + ",仅可使用一次,请勿泄漏。";
			break;
		case PhoneSendType.BANK_BIND:
			content = "本次安全码用于绑定银行卡：" + captcha + ",仅可使用一次,请勿泄漏。";
			break;
		case PhoneSendType.APP_LINK:
			content = "请求发送的智谷android手机APP下载地址：" + ZhiguConfig.getValue(ZhiguConfig.APP_ANDROID_LINK);
			break;
		default:
			return new MsgBean(Code.FAIL, "短信类型错误！", MsgLevel.ERROR);

		}
		// 调用第三方接口，发送短信
		SMSUtil.sendMsg(content, phone);

		// 发送记录存入数据库
		PhoneSend ps = new PhoneSend();
		ps.setAddTime(now);
		ps.setCaptcha(captcha);
		ps.setPhone(phone);
		ps.setStatus(PhoneSendStatus.SEND_SUCCESS);
		ps.setType(type);
		ps.setExpiryDate(DateUtils.addSeconds(now, PHONE_CAPTCHA_EXPIRY_SECONDS));
		ps.setIp(ip);
		phoneSendMapper.insert(ps);
		return new MsgBean(Code.SUCCESS, "短信发送成功", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean verify(String phone, int type, String captcha) {
		PhoneSend ps = phoneSendMapper.selectByPhoneAndType(phone, type);
		if (ps == null) {
			return new MsgBean(Code.FAIL, "无效手机验证码，请重新发送！", MsgLevel.ERROR);
		}
		if (ps.getExpiryDate().getTime() < new Date().getTime()) {
			return new MsgBean(Code.FAIL, "手机验证码已过期，请重新发送！", MsgLevel.ERROR);
		}
		if (ps.getCaptcha().equalsIgnoreCase(captcha) && ps.getStatus() == PhoneSendStatus.SEND_SUCCESS) {
			// ps.setStatus(PhoneSendStatus.USED);
			// phoneSendMapper.updateByPrimaryKey(ps);
			return new MsgBean(Code.SUCCESS, "手机验证码正确", MsgLevel.NORMAL);
		}
		return new MsgBean(Code.FAIL, "无效手机验证码，请重新发送！", MsgLevel.ERROR);
	}

}
