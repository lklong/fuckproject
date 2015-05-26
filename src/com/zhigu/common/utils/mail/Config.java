package com.zhigu.common.utils.mail;

import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

import com.zhigu.common.utils.ZhiguConfig;

/**
 * 邮件基本配置
 * 
 * @author zhouqibing
 * @time 2014年7月15日 上午9:16:07
 */
public class Config {

	private static final String CONFIG_FILE = "email.properties";
	private static final String VALIDATE = "mail.smtp.auth";
	private static final String USERNAME = "username";
	private static final String PASSWORD = "password";
	/** 邮件验证地址 */
	public static String EMAIL_VERIFY_ADDRESS = ZhiguConfig.getValue(ZhiguConfig.HOST) + "mail/notify";

	// email.properties文件
	private static Properties properties = null;

	private Config() {
	}

	public static Properties getProperties() {

		if (properties != null) {

			return properties;

		}

		synchronized (Config.class) {
			if (properties == null) {
				properties = new Properties();
				try {
					properties.load(new InputStreamReader(Config.class.getClassLoader().getResourceAsStream(CONFIG_FILE), "UTF-8"));
					return properties;
				} catch (IOException e) {
					System.out.println("未找到：" + CONFIG_FILE);
					e.printStackTrace();
				}
			}
		}

		return properties;
	}

	/**
	 * 用户名
	 * 
	 * @return
	 */
	public static String getUsername() {
		return (String) getProperties().get(USERNAME);
	}

	/**
	 * 密码
	 * 
	 * @return
	 */
	public static String getPassword() {
		return (String) getProperties().get(PASSWORD);
	}

	/**
	 * 验证
	 * 
	 * @return
	 */
	public static boolean isValidate() {
		return getProperties().get(VALIDATE).toString().equals("true");
	}

	public static void main(String[] args) {
		System.out.println(isValidate());
	}

}
