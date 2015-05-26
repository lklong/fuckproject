package com.zhigu.common.utils.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
/**
 * 邮件认证（密码验证器）
 * @author zhouqibing
 * @time 2014年7月15日 上午10:01:24
 */
public class MailAuthenticator extends Authenticator{
    private String userName = null;
    private String password = null;
        
    public MailAuthenticator(){
    }

    public MailAuthenticator(String username, String password) {    
        this.userName = username;
        this.password = password;
    }
    
    protected PasswordAuthentication getPasswordAuthentication(){   
        return new PasswordAuthentication(userName, password);
    }
}   