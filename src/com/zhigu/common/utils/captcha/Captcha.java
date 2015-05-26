package com.zhigu.common.utils.captcha;

import java.io.Serializable;

import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.StringUtil.RandomType;
/**
 * 验证码
 * @author zhouqibing
 * 2014年7月21日下午3:24:42
 */
public class Captcha implements Serializable{
	//标识
	private String key;
	//验证码
	private String captcha;
	//生成时间
	private long generateTime = System.currentTimeMillis();
	//存活时间
	private long life = 1000 * 60 * 5;
	
	//是否过期
	public boolean isExpiry(){
		return generateTime + life < System.currentTimeMillis();
	}
	
	
	
	public Captcha(){
		this.key = StringUtil.randomStr(RandomType.MIXTURE, 8);
		this.captcha = StringUtil.randomStr(RandomType.MIXTURE, 16);
	}
	public Captcha(String key,String captcha){
		this.key = key;
		this.captcha = captcha;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getCaptcha() {
		return captcha;
	}
	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}

	public long getGenerateTime() {
		return generateTime;
	}

	public void setGenerateTime(long generateTime) {
		this.generateTime = generateTime;
	}

	public long getLife() {
		return life;
	}

	public void setLife(long minute) {
		this.life = 1000 * 60 * minute;
	}
	
	
	
	
}