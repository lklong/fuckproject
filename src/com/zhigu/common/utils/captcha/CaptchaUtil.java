package com.zhigu.common.utils.captcha;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import com.zhigu.common.utils.StringUtil;

/**
 * 验证码集合，用于存在验证码
 * 
 * @author zhouqibing 2014年7月21日下午3:32:44
 */
public class CaptchaUtil {

	// 用于存放验证码
	// private static LinkedList<Captcha> list = new LinkedList<Captcha>();
	private static Map<String, Captcha> map = new ConcurrentHashMap<String, Captcha>();

	private CaptchaUtil() {
	}

	public static void put(Captcha captcha) {
		if (captcha == null)
			return;
		map.put(captcha.getKey(), captcha);
	}

	/**
	 * 用于验证验证码，不会移除
	 * 
	 * @param key
	 * @param captcha
	 * @return
	 */
	public synchronized static boolean verify(String key, String captcha) {

		if (StringUtil.isEmpty(key, captcha))
			return false;

		// 迭代map
		Iterator<Entry<String, Captcha>> iter = map.entrySet().iterator();

		Entry<String, Captcha> entry = null;
		// 删除map中已经过期的验证码
		while (iter.hasNext()) {
			entry = iter.next();
			if (entry.getValue().isExpiry()) {
				iter.remove();
			}
		}

		Captcha c = map.get(key);
		if (c != null && c.getCaptcha().trim().equals(captcha.trim())) {
			return true;
		}
		return false;
	}

	/**
	 * 用于验证验证码，验证成功后移除
	 * 
	 * @param key
	 * @param captcha
	 * @return
	 */
	public static boolean verifyAndRemove(String key, String captcha) {
		boolean flag = verify(key, captcha);
		if (flag) {
			remove(key);
		}
		return flag;
	}

	/**
	 * 用于验证验证码，验证成功后移除
	 * 
	 * @param key
	 * @param captcha
	 * @return
	 */
	public static void remove(String key) {
		// synchronized (CaptchaUtil.class) {
		map.remove(key);
		// }
	}

	/**
	 * 取得验证码
	 * 
	 * @param key
	 * @return
	 */
	public static Captcha getCaptcha(String key) {
		return map.get(key);
	}

}
