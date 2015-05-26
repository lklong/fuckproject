package com.zhigu.common.utils.mail;

import java.util.Date;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 * 邮件发送器
 * 
 * @author zhouqibing
 * @time 2014年7月15日 上午10:04:23
 */
public class MailSender {

	/**
	 * 以文本格式发送邮件
	 * @param msg 待发送的邮件信息
	 */
	public static void sendTextMail(final MailMessage msg) {
		new Thread(new Runnable() {
			@Override
			public void run() {
				// 判断是否需要身份认证
				MailAuthenticator authenticator = null;
				if (Config.isValidate()) {
					// 如果需要身份认证，则创建一个密码验证器
					authenticator = new MailAuthenticator(Config.getUsername(),Config.getPassword());
				}
				// 根据邮件会话属性和密码验证器构造一个发送邮件的session
				Session session = Session.getDefaultInstance(Config.getProperties(), authenticator);
				try {
					// 根据session创建一个邮件消息
					Message mMessage = new MimeMessage(session);
					// 创建邮件发送者地址
					Address from = new InternetAddress(Config.getUsername());
					// 设置邮件消息的发送者
					mMessage.setFrom(from);
					// 创建邮件的接收者地址，并设置到邮件消息中
					Address to = new InternetAddress(msg.getReceiveAddress());
					mMessage.setRecipient(Message.RecipientType.TO, to);
					// 设置邮件消息的主题
					mMessage.setSubject(msg.getSubject());
					// 设置邮件消息发送的时间
					mMessage.setSentDate(new Date());
					// 设置邮件消息的主要内容
					mMessage.setText(msg.getContent());
					// 发送邮件
					Transport.send(mMessage);
				} catch (MessagingException ex) {
					ex.printStackTrace();
				}
			}
		}).start();;
	}

	/**
	 * 以HTML格式发送邮件
	 * 
	 * @param msg 待发送的邮件信息
	 */
	public static void sendHtmlMail(final MailMessage msg) {
		
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				// 判断是否需要身份认证
				MailAuthenticator authenticator = null;
				if (Config.isValidate()) {
					// 如果需要身份认证，则创建一个密码验证器
					authenticator = new MailAuthenticator(Config.getUsername(),Config.getPassword());
				}
				// 根据邮件会话属性和密码验证器构造一个发送邮件的session
				Session session = Session.getDefaultInstance(Config.getProperties(), authenticator);
				try {
					// 根据session创建一个邮件消息
					Message mMessage = new MimeMessage(session);
					// 创建邮件发送者地址
					Address from = new InternetAddress(Config.getUsername());
					// 设置邮件消息的发送者
					mMessage.setFrom(from);
					// 创建邮件的接收者地址，并设置到邮件消息中
					Address to = new InternetAddress(msg.getReceiveAddress());
					// Message.RecipientType.TO属性表示接收者的类型为TO 
					mMessage.setRecipient(Message.RecipientType.TO, to);
					// 设置邮件消息的主题
					mMessage.setSubject(msg.getSubject());
					// 设置邮件消息发送的时间
					mMessage.setSentDate(new Date());
					// MiniMultipart类是一个容器类，包含MimeBodyPart类型的对象
					Multipart mainPart = new MimeMultipart();
					// 创建一个包含HTML内容的MimeBodyPart
					BodyPart html = new MimeBodyPart();
					// 设置HTML内容
					html.setContent(msg.getContent(), "text/html; charset=utf-8");
					mainPart.addBodyPart(html);
					// 将MiniMultipart对象设置为邮件内容
					mMessage.setContent(mainPart);
					// 发送邮件
					Transport.send(mMessage);
				} catch (MessagingException ex) {
					ex.printStackTrace();
				}
			}
		}).start();;
	}


	public static void main(String[] args) {
		MailMessage msg = new MailMessage("604986394@qq.com", "123", "123");
		sendTextMail(msg);
	}
}
