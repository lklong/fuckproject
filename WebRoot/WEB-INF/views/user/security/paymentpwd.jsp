<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设置支付密码</title>
</head>
<body>
	 <div class="body_center2 fl p10 ml10">
    	<div class="chongzhititle">
            <h4>设置支付密码</h4>
        </div>
        
        <c:choose>
	        <c:when test="${empty auth.phone }">
	        	<div class="shezhimima">
	            	<div class="shezhititle">您可以通过以下方式设置支付密码：</div>
	                <div class="shezhitel">
	                	<img class="shezhitelimg fl mr20 mt10" src="img/telhong.png"/>
	                    <p class="shezhip fl mr20">用手机号码设置</p>
	                    <a href="user/security/phone">
		                    <input class="shezhibut fl cp" type="button" value="立即设置" />
	                    </a>
	                    <div class="clear"></div>
	                </div>
	            </div>
	        </c:when>
        	<c:otherwise>
		        <div class="shezhimima2">
		        	<div class="shemiform">
		            	<div class=" mb10">
		                	<p class="telTitle fl">手机号码：</p>
		                    <strong class="ce81268">${auth.phone }</strong>
		                </div>
		                <div class="shoujibox">
							<p class="telTitle fl">　验证码：</p>
							<input id="captcha" name="captcha" class="shoujitxt fl" type="text" autocomplete="off"/>
							<input class="shoujibut fl" style="cursor: pointer;" onclick="sendCaptcha(this)" type="button" value="发送验证码" /> 
							<span id="captchaSpan" class="shoujihelp disblock"></span>
							<span id="sendmsg" class="shoujihelp2"> </span>
							<div class="clear"></div>
						</div>
						<div class=" mb10">
		                	<p class="telTitle fl">支付密码：</p>
		                    <input class="shoujitxt fl" type="password" id="paymentPwd" autocomplete="off"/>
		                    <span></span>
		                    <span id="captchaSpan" class="shoujihelp disblock"></span>
		                </div>
		                <div class="clear"></div>
		                <input class="shemenext cp mt10" type="button"  value="设置" onclick="savePaypasspw();"/>
		        </div>
		        </div>
        	</c:otherwise>
        </c:choose>
    </div>
    <div class="clear"></div>
	<script type="text/javascript">
		function sendCaptcha(obj){
			ajaxSubmit("captcha/phone", {t:4}, function(msgBean){
				if(msgBean.code==zhigu.code.success){
					$("#sendmsg").html(msgBean.msg);
					send_captcha_waiting(obj);					
				}else{
					$("#phoneSpan").html(msgBean.msg);
				}
			});
		}
		function savePaypasspw(){
			var params = {};
			params.paypasswd = zhigu.encodeBase64($("#paymentPwd").val());
			params.captcha = $("#captcha").val();
			
			ajaxSubmit('user/security/savepayPasswd', params, function(msgBean){
				var dialogId = layer.alert(msgBean.msg,-1,function(){
					layer.close(dialogId);
					if(msgBean.code== zhigu.code.success){
						window.location.href="/user/security/center";
					}
				});
			},"json");
		}
	</script>
</body>
</html>