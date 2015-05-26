package com.zhigu.common.utils.mail;
/**
 * 邮件内容对象
 * @author zhouqibing
 * @time 2014年7月15日 上午9:53:35
 */
public class MailMessage {

	private String receiveAddress;//收件人
	
	private String subject;//主题
	
	private String content;//内容

	public MailMessage(String receiveAddress,String subject,String content){
		this.receiveAddress = receiveAddress;
		this.subject = subject;
		this.content = content;
	}
	
	public String getReceiveAddress() {
		return receiveAddress;
	}

	public void setReceiveAddress(String receiveAddress) {
		this.receiveAddress = receiveAddress;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
}
