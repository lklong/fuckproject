<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<link href="/css/default/user.css" rel="stylesheet" />
<script src="js/3rdparty/layer1.9/layer.js"></script>
<title>用户注册</title>
</head>
<body>
<body>
<!--** 注册板块 **--> 
<!--** Step.1 填写信息 **-->
<form action="#" method="post" id="registerForm">
  <div class="userRegPanel">
    <div class="urpInside">
      <div class="urpMiddleBox">
        <div class="urpTopTip">
          <div id="step1">
            <h2>用户注册</h2>
          </div>
        </div>
        <!--** 帐号 **-->
        <div class="urpMiddleDiv"><strong class="color-red fwb"> * </strong>
          <input id="usernameReg" name="username" default_value="手机" type="text" class="userRegInput_1"  value="${username }"/>
          <input type="button" id="phoneCaptchaSend" value="发送手机验证码" disabled="disabled" class="input-button-gray">
          <div class="urpAlert"> 
	          <!--** 验证成功与失败的消息 **-->
	          <p class="fl" id="msg_username">请输入11位的手机号</p>
	        </div>
        </div>
        <!--** 验证码 **-->
        <div class="urpMiddleDiv">
          <div class="fl"><strong class="color-red fwb"> * </strong>
            <input id="phoneCaptcha" type="text" class="urpYanZhengCode_1" />
          </div>
          <div class="urpAlert"> 
	          <!--** 验证成功与失败的消息 **-->
	          <p id="msg_captcha"></p>
	        </div>
        </div>
        <!--** 密码 **-->
        <div class="urpMiddleDiv"><strong class="color-red fwb"> * </strong>
          <input id="urpRegPassWord" name="password" type="password" class="urpRegPassWord_1"/>
          <div class="urpAlert"> 
	          <!--** 验证成功与失败的消息 **-->
	          <p id="msg_password">密码为6-16个字符，必须包含数字、字母！</p>
	        </div>
        </div>
        <!--重复密码 -->
        <div class="urpMiddleDiv"><strong class="color-red fwb"> * </strong>
          <input id="reurpRegPassWord" name="repassword" type="password" class="urpRegPassWord_10"/>
          <div class="urpAlert"> 
	          <!--** 验证成功与失败的消息 **-->
	          <p id="msg_repassword"></p>
	        </div>
        </div>
        <!--** 同意 **-->
<!--         <div class="urpMiddleDiv"> -->
<!--           <input type="checkbox" checked="checked"  id="readagree"/> -->
<!--           <a class="agree_a" target="_blank " href="help/agreement"> 我同意《智谷同城货源网用户服务协议》</a> </div> -->
        <div class="urpMiddleDiv mt30">
          <input type="button" class="urpSubMit" value="注册" title="注册" id="registerBtn"/>
          <br />
          <br />
        </div>
      </div>
    </div>
  </div>
</form>
<script type="text/javascript">
function sendCaptcha(){
	var username = $("#usernameReg").val();
	if(!zhigu.verify.phoneReg(username)){
		layer.alert("请填写正确的手机号");
		return false;
	}
	$.post("/register/verifyPhone", {"phone":username},function(msgBean){
		if(msgBean.code==zhigu.code.success){
			$("#phoneCaptchaSend").attr("disabled",false);
			$.post("/register/phone/send", {'phone':username}, function(msgBean){
				if(msgBean.code==zhigu.code.success){
					$("#phoneCaptchaSend").val("手机验证码已发送");
					$("#phoneCaptchaSend").attr("disabled",true);
					$("#phoneCaptchaSend").removeClass("input-button");
					$("#phoneCaptchaSend").addClass("input-button-gray");
				}else{
					layer.alert(msgBean.msg);
					$("#phoneCaptchaSend").attr("disabled",false);
					$("#phoneCaptchaSend").removeClass("input-button-gray");
					$("#phoneCaptchaSend").addClass("input-button");
				}
			});
		}else{
			$("#phoneCaptchaSend").attr("disabled",true);
			$("#phoneCaptchaSend").removeClass("input-button");
			$("#phoneCaptchaSend").addClass("input-button-gray");
			layer.alert(msgBean.msg);
		}
	})
}

$(function(){
	$("#phoneCaptchaSend").click(sendCaptcha);
	
	$("#usernameReg").focusout(function(){
		var username = $(this).val();
		//用户名
		if(username && zhigu.verify.phoneReg(username)){
			$.post("/register/verifyPhone", {"phone":username}, function (msgBean){
				if(msgBean.code==zhigu.code.success){
					$("#phoneCaptchaSend").attr("disabled",false);
					$("#phoneCaptchaSend").removeClass("input-button-gray");
					$("#phoneCaptchaSend").addClass("input-button");
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
				layer.alert(msgBean.msg,function(){
					window.location.href = "/login";
				})
			}else{
				layer.alert(msgBean.msg);
			}
		});
	});
});
//注册切换输入框的背景
//页面重新渲染时清空输入框值
$("#usernameReg").val("");
$("#urpRegPassWord").val("");
$("#urpRegPassWordre").val("");
$("#phoneCaptcha").val("");
$("#urpRegMoble").val("");
$("#usernameReg").focus(function() {
	$("#usernameReg").removeClass("userRegInput_1");
	$("#usernameReg").addClass("userRegInput_2");
});
$("#urpRegPassWord").focus(function() {
	$("#urpRegPassWord").removeClass("urpRegPassWord_1");
	$("#urpRegPassWord").addClass("urpRegPassWord_2");
});
$("#phoneCaptcha").focus(function() {
	$("#phoneCaptcha").removeClass("urpYanZhengCode_1");
	$("#phoneCaptcha").addClass("urpYanZhengCode_2");
});
$("#reurpRegPassWord").focus(function() {
	$("#reurpRegPassWord").removeClass("urpRegPassWord_10");
	$("#reurpRegPassWord").addClass("urpRegPassWord_2");
});
$("#recommendPhone").focus(function() {
	$("#recommendPhone").removeClass("urpRegPassWord_11");
	$("#recommendPhone").addClass("urpRegPassWord_12");
});
</script>
</body>
</html>