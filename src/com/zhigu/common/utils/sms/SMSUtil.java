package com.zhigu.common.utils.sms;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.log4j.Logger;

import com.zhigu.common.utils.Md5;

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
		// 异步发送
		new Thread(new Runnable() {
			@Override
			public void run() {
				String phones = getPhones(list);
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
					logger.debug("短信发送结果---->>" + msg);
				} catch (UnsupportedEncodingException e) {
					throw new IllegalArgumentException(e);
				}
			}
		}).start();
	}

	private static String getPhones(List<String> list) {
		StringBuilder sb = new StringBuilder();
		Iterator<String> iter = list.iterator();

		String phone = null;
		while (iter.hasNext()) {
			phone = iter.next();
			if (sb.length() > 0) {
				sb.append(",");
			}
			sb.append(phone);
		}
		return sb.toString();
	}

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
