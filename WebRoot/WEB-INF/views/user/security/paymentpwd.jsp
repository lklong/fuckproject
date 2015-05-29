<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>设置支付密码</title>
<script type="text/javascript" src="js/3rdparty/layer/layer.min.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">设置支付密码</h4>
  <div class="msg-alert"><span class="gantanhao"></span>您可以通过以下方式设置支付密码：</div>
  
    <table cellpadding="0" cellspacing="0" class="user-form-table">
    <c:choose>
      <c:when test="${empty auth.phone }">
        <tr>
          <td style="width:10%">用手机号码设置</td>
          <td style="width:90%"><a href="user/security/phone" class="default-a"> 立即设置 </a></td>
        </tr>
      </c:when>
      <c:otherwise>
        <tr>
          <td style="width:10%">手机号码：</td>
          <td style="width:90%">${auth.phone }</td>
        </tr>
        <tr>
          <td>验证码：</td>
          <td><input id="captcha" name="captcha" class="input-txt" type="text" autocomplete="off"/>
            <input class="input-button ml20" onclick="sendCaptcha(this)" type="button" value="发送验证码" />
            <span id="captchaSpan" class="color-red"></span> <span id="sendmsg" class="color-red"> </span></td>
        </tr>
        <tr>
          <td>支付密码：</td>
          <td><input class="input-txt" type="password" id="paymentPwd" autocomplete="off"/>
            <span id="captchaSpan" class="color-red"></span></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><input class="input-button" type="button"  value="设置" onclick="savePaypasspw();"/></td>
        </tr>
      </c:otherwise>
      </c:choose>
    </table>
  
</div>
<script type="text/javascript">
		function sendCaptcha(obj){
			ajaxSubmit("/user/security/paypwd/update/phoneSend", {}, function(msgBean){
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