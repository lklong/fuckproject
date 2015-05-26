package com.zhigu.common.utils.mail;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zhigu.common.utils.Md5;
import com.zhigu.common.utils.StringUtil;

/**
 * 邮件验证
 * 
 * @author zhouqibing 2014年7月25日下午2:07:33
 */
public class MailSign {
	private static final String SIGN_KEY = "sdfhsrtgjsdvhb9qwu3y346yio4y6o78gvlzuj/*-@#$^34dsfgzdfg57+";

	/**
	 * 除去数组中的空值和签名参数
	 * 
	 * @param sArray
	 *            签名参数组
	 * @return 去掉空值与签名参数后的新签名参数组
	 */
	private static Map<String, String> paraFilter(Map<String, String> sArray) {
		Map<String, String> result = new HashMap<String, String>();
		if (sArray == null || sArray.size() <= 0) {
			return result;
		}

		for (String key : sArray.keySet()) {
			String value = sArray.get(key);
			if (value == null || value.equals("") || key.equalsIgnoreCase("sign")) {
				continue;
			}
			result.put(key, value);
		}
		return result;
	}

	/**
	 * 把数组所有元素排序，并按照“参数=参数值”的模式用“&”字符拼接成字符串
	 * 
	 * @param params
	 *            需要排序并参与字符拼接的参数组
	 * @return 拼接后字符串
	 */
	public static String createLinkString(Map<String, String> params) {

		List<String> keys = new ArrayList<String>(params.keySet());
		Collections.sort(keys);

		String prestr = "";

		for (int i = 0; i < keys.size(); i++) {
			String key = keys.get(i);
			String value = params.get(key);

			if (i == keys.size() - 1) {// 拼接时，不包括最后一个&字符
				prestr = prestr + key + "=" + value;
			} else {
				prestr = prestr + key + "=" + value + "&";
			}
		}
		try {
			prestr = "encodeparam=" + URLEncoder.encode(prestr, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return prestr;
	}

	/**
	 * MD5 签名
	 * 
	 * @param map
	 * @return
	 */
	public static String sign(Map<String, String> map) {
		map = paraFilter(map);
		String link = createLinkString(map);
		return Md5.convert(link + SIGN_KEY);
	}

	/**
	 * 邮件参数验证
	 * 
	 * @param map
	 * @return
	 */
	public static boolean verify(Map<String, String> map) {
		String sign = map.get("sign");
		if (StringUtil.isEmpty(sign))
			return false;

		Map smap = paraFilter(map);
		String link = createLinkString(smap);

		return sign.equals(Md5.convert(link + SIGN_KEY));
	}

}
