<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>手机设置</title>
</head>
<body>
	<div class="body_center2 fl p10 ml10">
		<div class="chongzhititle">
			<h4>手机设置</h4>
		</div>
			<div class="shoujiform">
						<div class="shoujibox">
							<p class="shoujip fl"></p><span id="info_area" class="red">${msg }</span>
							<div class="clear"></div>
						</div>
					<div class="shoujibox">
						<p class="shoujip fl">原始手机号：</p>
						<input class="shoujitxt" type="text" id="oldPhone" value="${oldPhone }" disabled="disabled"/><input class="shoujibut fl" style="cursor: pointer;" onclick="sendCaptcha(this)" type="button" value="获取验证码" /> 
						<div class="clear"></div>
					</div>
					<div class="shoujibox">
						<p class="shoujip fl">　验证码：</p>
						<input id="captcha" name="captcha" class="shoujitxt fl" type="text" /> 
						<span id="captchaSpan" class="red"></span> 
						<div class="clear"></div>
					</div>
					<input class="shoujisub" value="验证原手机号" type="button"  onclick="_submit();"/>
			</div>
	</div>
	<div class="clear"></div>
	<script type="text/javascript">
		function sendCaptcha(obj){
			var oldPhone = $("#oldPhone").val();
			ajaxSubmit("captcha/phone", {"t":3,"phone":'${oldPhone }'}, function(msgBean){
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
					layer.msg(msgBean.msg,2,function(){
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