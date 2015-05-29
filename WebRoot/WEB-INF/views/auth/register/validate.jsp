<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<link href="/css/default/user.css" rel="stylesheet"/>
<title>用户注册</title>
</head>
<body>
<body>
	<!--** 注册板块 **-->
	<!--** Step.2 去邮箱点击连接进行验证 **-->
	<div class="userRegPanel disnonex">
		<div class="urpInside">
			<div class="urpMiddleBox">
				<div class="urpTopTip">
					<div id="step1">
						<img src="img/regstep2.jpg" />
					</div>
				</div>
				<div class="urpMiddleDiv">
					<c:choose>
						<c:when test="${regway == 1}">
							<div class="urpAlert" style="width: 410px;">
								<p class="okMsg">
									<em></em><font size="3" color="#000000">验证邮件已发送，请前往邮箱点击激活链接完成注册！</font>
								</p>
							</div>
							<br />
							<div class="urpAlert">
								注册邮箱：<span class="cf86666">${username }</span>
							</div>
						</c:when>
						<c:otherwise>请填写6位手机验证码：<br/><br/>
							<form method="post" action="register/verify/phone">
								<input type="text" placeholder="填写6位手机验证码" name="captcha"
									id="captcha" class="gophone_txt" /> <input
									onclick="sendCaptcha(this)" id="captchaBtn" type="button"
									value="发送验证码" style="cursor: pointer; width: 80px;"> <span
									class="gophone_help" id="e_captcha">${msg }</span><br> 
									<br/><br/>
									<input class="reg_ph_next mb20 cp" type="submit" onclick="return verify()" value="下一步" />
							</form>
						</c:otherwise>
					</c:choose>
					<br />
					<br />
					<br /> <br />
					<br />
					<br />
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	$(function(){
		send_captcha_waiting($("#captchaBtn"));
	});
	function sendCaptcha(obj){
		ajaxSubmit("captcha/phone", "phone=${username}&t=1", function(msgBean){
			if(msgBean.code==zhigu.code.success){
				send_captcha_waiting(obj);
			}else{
			}
			layer.alert(msgBean.msg);
		},"json");
	}
	function verify(){
		var captcha = $("#captcha").val();
		if(captcha == ""){
			$("#e_captcha").html("请输入验证码！");
			return false;			
		}
		return true;
	}
	function dismsg(input){
		$(input).parent().parent().find(".reg_help").addClass("disnone");
	}
</script>
</body>
</html>