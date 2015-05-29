<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>手机设置</title>
<script type="text/javascript" src="js/3rdparty/layer/layer.min.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">手机设置</h4>
  <table cellpadding="0" cellspacing="0" class="user-form-table">
    <tr>
      <td>新手机号：</td>
      <td><input class="input-txt" type="text" name="phone" id="phone" />
        <input class="input-button" onclick="sendCaptcha(this)" type="button" value="获取验证码" />
        <span id="info_area" class="color-red"></span></td>
    </tr>
    <tr>
      <td>验证码：</td>
      <td><input id="captcha" name="captcha" class="input-txt" type="text" />
        <span id="captchaSpan" class="color-red"></span></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input class="shoujisub" value="绑定" type="button" onclick="_submit()" /></td>
    </tr>
  </table>
</div>
<script type="text/javascript">
		function sendCaptcha(obj){
			var phone = $("#phone").val();
			if(!phoneReg(phone)){
				$("#info_area").html("请输入正确的手机号码");
				return;				
			}
			ajaxSubmit("/user/security/newphone/send", {"phone":phone}, function(msgBean){
				if(msgBean.code==zhigu.code.success){
					$("#info_area").html(msgBean.msg);
					send_captcha_waiting(obj);
				}else{
					$("#info_area").html(msgBean.msg);
				}
			});
		}
		function _submit(){
			var phone = $("#phone").val();
			var captcha = $("#captcha").val();
			if(!phoneReg(phone)){
				$("#info_area").html("请输入正确的手机号码");
				return;				
			}
			if(!captcha){
				layer.alert("请输入验证码");
				return ;
			}
			$.post("user/security/modifyPhone", {"captcha":captcha,"phone":phone,"oldPhoneVerifyKey":'${oldPhoneVerifyKey}'}, function(msgBean){
				if(msgBean.code==zhigu.code.success){
					layer.alert(msgBean.msg,-1,function(){
						window.location.href = "/user/security/center";
					});
				}else{
					layer.alert(msgBean.msg);
				}
			});
		}
	</script>
</body>
</html>