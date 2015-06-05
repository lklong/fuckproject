<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
<title>手机设置</title>
</head>
<body>
	<div class="rightContainer fr">
		<h4 class="ddtitle">手机设置</h4>
		<table cellpadding="0" cellspacing="0" class="user-form-table">
				<tr>
					<td style="width:15%">原始手机号：</td>
					<td style="width:85%"><input class="input-txt" type="text" id="oldPhone" value="${oldPhone }" disabled="disabled"/><input class="input-button ml20" style="cursor: pointer;" onclick="sendCaptcha(this)" type="button" value="获取验证码" /> </td>
				</tr>
				<tr>
					<td>验证码：</td>
					<td><input id="captcha" name="captcha" class="input-txt" type="text" /><span id="captchaSpan" class="color-red"></span></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><span id="info_area" class="color-red">${msg }</span></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><input class="input-button" value="验证原手机号" type="button"  onclick="_submit();"/></td>
				</tr>
			</table>
</div>
	<script type="text/javascript">
		function sendCaptcha(obj){
			var oldPhone = $("#oldPhone").val();
			ajaxSubmit("/user/security/verifyOldPhone/send", {}, function(msgBean){
				if(msgBean.code==zhigu.code.success){
					$("#info_area").html(msgBean.msg);
					send_captcha_waiting(obj);	
				}else{
					$("#info_area").html(msgBean.msg);
				}
			});
		}
		function _submit(){
			var captcha = $("#captcha").val();
			if(!captcha){
				$("#info_area").html("请输入验证码");
				return false;
			}
			ajaxSubmit("user/security/verifyOldPhone", {"captcha":captcha}, function(msgBean){
				if(msgBean.code==zhigu.code.success){
					layer.msg(msgBean.msg,function(){
						window.location.href = "/user/security/phone?oldPhoneVerifyKey="+msgBean.data.oldPhoneVerifyKey;
					});
				}else{
					layer.alert(msgBean.msg);
				}
			});
		}
	</script>
</body>
</html>