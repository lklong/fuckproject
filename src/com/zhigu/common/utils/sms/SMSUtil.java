package com.zhigu.common.utils.sms;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.log4j.Logger;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.common.utils.Md5;
import com.zhigu.common.utils.NetUtil;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.StringUtil.RandomType;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.common.utils.captcha.Captcha;
import com.zhigu.common.utils.captcha.CaptchaUtil;

/**
 * 短信工具
 * 
 * @author zhouqibing 2014年7月21日下午4:08:33
 */
public class SMSUtil {

	private static final Logger logger = Logger.getLogger(SMSUtil.class);

	private static final String sn = "SDK-JQT-010-00071";
	private static final String pwd = "(2-7ecc-";
	private static final String url = "http://sdk.entinfo.cn:8061/webservice.asmx/mdsmssend";
	private static final String sign = "【智谷网】";
	private static final long interval = 1000 * 60 * 1;// 发送短信间隔时间

	// 手机短信发送记录
	private static final Map<String, Integer> SEND_RECORD_MAP = new ConcurrentHashMap<String, Integer>();
	static {
		// 定时清除手机短信发送记录
		Timer timer = new Timer(true);
		timer.schedule(new java.util.TimerTask() {
			@Override
			public void run() {
				SEND_RECORD_MAP.clear();
			}
		}, 3 * 60 * 1000, 3 * 60 * 1000);// 3minutes
	}

	/**
	 * 发送手机验证码
	 * 
	 * @param captcha
	 * @param phone
	 */
	private static void sendCaptcha(String phone, String captcha, String template) {
		logger.info("验证码:" + captcha);
		if (StringUtil.isEmpty(phone, captcha, template)) {
			throw new IllegalArgumentException("参数不能为空");
		}
		// 保存验证码
		CaptchaUtil.put(new Captcha(phone, captcha));
		// 构建短信内容
		String content = template.replace("?", captcha);
		sendMsg(content, phone);
	}

	/**
	 * 发送手机验证码
	 * 
	 * @param captcha
	 * @param phone
	 */
	public static void sendCaptcha(String phone, String template) {
		sendCaptcha(phone, StringUtil.randomStr(RandomType.NUMBER, 6), template);
	}

	/**
	 * 手机短信
	 * 
	 * @param msg
	 * @param phone
	 */
	public static void sendMsg(String msg, String phone) {
		List<String> list = new ArrayList<String>();
		list.add(phone);
		sendMsg(msg, list);
	}

	/**
	 * 发送手机短信，文件内容
	 * 
	 * @param msg
	 * @param phones
	 */
	private static void sendMsg(final String msg, final List<String> list) {
		String ip = NetUtil.getIpAddr(SessionHelper.getRequest());
		Integer count = SEND_RECORD_MAP.get(ip);
		if (count == null) {
			SEND_RECORD_MAP.put(ip, 1);
		} else {
			count++;
			SEND_RECORD_MAP.put(ip, count);
		}
		// 异步发送
		new Thread(new Runnable() {
			@Override
			public void run() {
				String phones = getPhones(list);
				StringUtil.assertEmpty(phones);
				try {
					List<NameValuePair> params = new ArrayList<NameValuePair>();
					params.add(new NameValuePair("sn", sn));
					params.add(new NameValuePair("pwd", Md5.convert(sn + pwd).toUpperCase()));
					params.add(new NameValuePair("mobile", phones));
					params.add(new NameValuePair("content", URLEncoder.encode(msg + sign, "utf-8")));
					params.add(new NameValuePair("ext", ""));
					params.add(new NameValuePair("stime", ""));
					params.add(new NameValuePair("rrid", ""));
					params.add(new NameValuePair("msgfmt", ""));
					String msg = request(params.toArray(new NameValuePair[params.size()]));
					System.out.println(msg);
				} catch (UnsupportedEncodingException e) {
					throw new IllegalArgumentException(e);
				}
			}
		}).start();
	}

	private static String getPhones(List<String> list) {
		StringBuffer sb = new StringBuffer();
		Iterator<String> iter = list.iterator();

		String phone = "";
		while (iter.hasNext()) {
			phone = iter.next();
			if (!VerifyUtil.phoneVerify(phone))
				continue;
			sb.append(phone).append(",");
		}
		if (!StringUtil.isEmpty(sb.toString()))
			return sb.toString().substring(0, sb.length() - 1);
		return null;
	}

	/**
	 * 是否可以发送
	 * 
	 * @param phone
	 *            false不可以发送 true可以发送
	 * @return
	 */
	public static boolean isSend(String phone) {
		Integer count = SEND_RECORD_MAP.get(NetUtil.getIpAddr(SessionHelper.getRequest()));
		if (count != null && count > 5) {
			return false;
		}
		Captcha cp = CaptchaUtil.getCaptcha(phone);
		if (cp == null)
			return true;
		if (cp.getGenerateTime() + interval > DateUtil.currentTimeMillis())
			return false;
		return true;
	}

	// public static void main(String[] args) throws Exception {
	// sendCaptcha("15902895870", SMSTemplate.getTemplate(2));
	// }

	private static String request(NameValuePair[] params) {
		String result = null;
		HttpClient client = new HttpClient();
		PostMethod postMethod = new PostMethod(url);
		postMethod.setRequestBody(params);
		int statusCode = 0;
		try {
			statusCode = client.executeMethod(postMethod);
		} catch (HttpException e) {
		} catch (IOException e) {
		}

		try {
			if (statusCode == HttpStatus.SC_OK) {
				result = postMethod.getResponseBodyAsString();
				return result;
			} else {
			}
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}
		postMethod.releaseConnection();
		return result;

	}

}
