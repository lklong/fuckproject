<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户注册</title>
</head>
<body>
<body>
<!--** 注册板块 **-->
<!--** Step.1 填写信息 **-->
<form action="#" method="post" id="registerForm">
<div class="userRegPanel">
	<div class="urpInside">
    	<div class="urpTopBox"></div>
        <div class="urpMiddleBox">
        	<div class="urpTopTip">
        	<div id="step1">
        	<h1>用户注册</h1>
        	<!-- <img src="img/regstep1.jpg" /> -->
        	</div>
        	</div>
            <!--** 帐号 **-->
            <div class="urpMiddleDiv" style="width:400px">
            	<span style="color:red">*</span>
            	<input id="usernameReg" name="username" default_value="手机" type="text" class="userRegInput_1"  value="${username }"/>
            	&nbsp;&nbsp;<input type="button" id="phoneCaptchaSend" value="发送手机验证码" disabled="disabled" class="button white">
            </div>
            <div class="urpAlert">
            	<!--** 验证成功与失败的消息 **-->
            	<p class="" id="msg_username" style="padding:0 3px ;">请输入11位的手机号</p>
            </div>
            <!--** 验证码 **-->
            <div class="urpMiddleDiv" style="width:400px">
            	<div class="fl"><span style="color:red;margin:0 3px;">*</span><input id="phoneCaptcha" type="text" class="urpYanZhengCode_1" /></div>
            </div>
            <div class="urpAlert">
            	<!--** 验证成功与失败的消息 **-->
            	<p id="msg_captcha" style="padding:0 3px ;"></p>
            </div>
            <!--** 密码 **-->
            <div class="urpMiddleDiv" style="width:400px">
            	<span style="color:red">*</span>
            	<input id="urpRegPassWord" name="password" type="password" class="urpRegPassWord_1"/>
            </div>
            <div class="urpAlert">
            	<!--** 验证成功与失败的消息 **-->
            	<p id="msg_password" style="padding:0 3px ;">密码为6-16个字符，必须包含数字、字母！</p>
            </div>
            <!--重复密码 -->
            <div class="urpMiddleDiv" style="width:400px">
            	<span style="color:red">*</span>
            	<input id="reurpRegPassWord" name="repassword" type="password" class="urpRegPassWord_10"/>
            </div>
            <div class="urpAlert">
            	<!--** 验证成功与失败的消息 **-->
            	<p id="msg_repassword" style="padding:0 3px ;"></p>
            </div>
            
            <!--** 同意 **-->
            <div class="urpMiddleDiv disnone">
            	<input type="checkbox" checked="checked"  id="readagree"/><a class="agree_a" target="_blank " href="help/agreement"> 我同意《智谷同城货源网用户服务协议》</a>
            </div>
            <div class="urpMiddleDiv mt30">
            	<br /><br /><br />
            	<input type="button" class="urpSubMit" value="注册" title="注册" id="registerBtn"/>
                <br /><br /><br />
                <br /><br /><br />
            </div>
        </div>
        <div class="urpFootBox"></div>
    </div>
</div>
</form>
<script type="text/javascript">
function sendCaptcha(){
	var username = $("#usernameReg").val();
	$.post("/register/verifyPhone", {"phone":username},function(msgBean){
		if(msgBean.code==zhigu.code.success){
			$("#phoneCaptchaSend").attr("disabled",false);
			$.post("/captcha/phone", {'t':1,'phone':username}, function(msgBean){
				if(msgBean.code==zhigu.code.success){
					$("#phoneCaptchaSend").val("手机验证码已发送");
					$("#phoneCaptchaSend").attr("disabled",true);
				}else{
					layer.alert(msgBean.msg);
					$("#phoneCaptchaSend").attr("disabled",false);
				}
			});
		}else{
			$("#phoneCaptchaSend").attr("disabled",true);
			layer.alert(msgBean.msg);
		}
	})
}

$(function(){
	$("#phoneCaptchaSend").click(sendCaptcha);
	
	$("#usernameReg").focusout(function(){
		var username = $(this).val();
		//用户名
		if(username && phoneReg(username)){
			$.post("/register/verifyPhone", {"phone":username}, function (msgBean){
				if(msgBean.code==zhigu.code.success){
					$("#phoneCaptchaSend").attr("disabled",false);
					$("#msg_username").removeClass("okMsg failMsg").addClass("okMsg").html("<em></em>"+msgBean.msg);
				}else{
					$("#msg_username").removeClass("okMsg failMsg").addClass("failMsg").html("<em></em>"+msgBean.msg);
				}
			});
		}else{
			$("#msg_username").removeClass("okMsg failMsg").addClass("failMsg").html("<em></em>请输入正确的手机号码！");
		}
	});
	
	$("#registerBtn").click(function(){
// 		if(!$("#readagree").prop("checked")){
// 			layer.alert("请阅读并同意用户服务协议");
// 			return false;
// 		}
		var params = {};
		params.username = $("#usernameReg").val();
		params.captcha = $("#phoneCaptcha").val();
		var opwd = $("#urpRegPassWord").val();
		var orepwd = $("#reurpRegPassWord").val();
		if(opwd != orepwd){
			layer.alert("重复密码错误");
			return false;
		}
		params.encodePwd = zhigu.encodeBase64(opwd);
		$.post("/register",params,function(msgBean){
			if(msgBean.code==zhigu.code.success){
				layer.msg(msgBean.msg,2,function(){
					window.location.href = "/login";
				})
			}else{
				layer.alert(msgBean.msg);
			}
		});
	});
});
</script>
</body>
</html>