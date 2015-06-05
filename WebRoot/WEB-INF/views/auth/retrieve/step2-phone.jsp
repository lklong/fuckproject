<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>密码找回</title>
<link href="/css/default/user.css" rel="stylesheet"/>
<script type="text/javascript" src="/js/3rdparty/layer1.9/layer.js"></script>
</head>
<body>
<!--** Step.2 身份验证 **-->
<div class="userRegPanel disnonex">
	<div class="urpInside">
        <div class="urpMiddleBox">
        	<div class="urpTopTip"><div id="step1"><h2>密码找回 - 第二步</h2></div></div>
	            <div class="urpMiddleDiv">
	            	<table cellpadding="0" cellspacing="0" class="user-form-table">
						<tr>
							<td colspan="2">你绑定的手机：${phone }</td>
						</tr>
						<tr>
							<td style="width:20%"> 验证码：</td>
							<td style="width:80%"><input type="text" placeholder="填写6位手机验证码" id="captcha" class="input-txt" /></td>
						</tr>
						<tr>
							<td>新密码：</td>
							<td><input type="password"  id="password" class="input-txt" /></td>
						</tr>
						<tr>
							<td>重复密码：</td>
							<td><input type="password"  id="repassword" class="input-txt" /></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><input type="button" class="urpSubMit" value="修改密码" title="修改密码" onclick="resetPwd()" type="button" /></td>
						</tr>
					</table>
			<div class="msg-alert mt20"><span class="gantanhao"></span>
			<p>没收到验证码短信？</p>
			<p> 由于短信服务商原因，可能会有延迟，请耐心等待。
	                    如果您10分钟还没收到，可以再次发送验证码。
	                    如果以上不能解决，请联系客服。</p>
			</div>   <br/>      
</div>
</div>
</div></div>

<script type="text/javascript">
function resetPwd(){
	var param = {};
	var pwd = $("#password").val();
	var repwd = $("#repassword").val();
	if(!pwd){
		layer.tips('请填写密码', "#password");
		return false;
	}
	if(pwd != repwd){
		layer.tips('重复密码错误', "#repassword");
		return false;
	}
	param.newPwd = pwd;
	param.captcha = $("#captcha").val();
	if(!param.captcha){
		layer.tips('请填写手机验证码', "#captcha");
		return false;
	}
	$.post("/security/retrieve/step2phone",param,function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.msg("密码修改成功，去登陆",2,function(){
				window.location.href = "/login";
			});
		}else{
			layer.alert(msgBean.msg);
		}
	});
}
</script>
</body>
</html>