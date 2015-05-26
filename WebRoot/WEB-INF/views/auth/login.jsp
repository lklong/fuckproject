<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
</head>
<body>
	<!--** 登录板块 **-->
	<div class="mainbodyw">
		<div class="mbInside">
			<div class="fl">
				<img src="img/loginbanner.jpg" />
			</div>
			<div class="fr mbLoginPanel">
				<div class="panelBox">
					<table>
						<tbody>
							<tr>
								<td colspan="2"><h3>用户登录</h3></td>
							</tr>
							<tr>
								<td colspan="2"><input id="username" name="username" type="text" class="input_user_1" value="" /></td>
							</tr>
							<tr>
								<td colspan="2"><input id="password" name="password" type="password" class="input_passw_1" value="" /></td>
							</tr>
							<tr>
								<td><input type="checkbox" id="autoLogin" name="autoLogin" value="1" /><label for="autoLogin"> 7天免登录</label></td>
								<td align="right"><a href="security/retrieve/step1">忘记密码？</a></td>
							</tr>
							<tr>
								<td colspan="2"><input type="button" class="subLogin" title="登录" value="登　录" onclick="login();" /></td>
							</tr>
							<tr>
								<td><img src="img/qqicon.gif" /><a href="login/qq"> QQ登录</a></td>
								<td align="right"><a href="register">没有帐号？立即注册！</a></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="panelBg"></div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
$(function(){
	//登录切换输入框的背景
	//页面重新渲染时清空输入框值
	$("#username").val("");
	$("#password").val("");
	$("#username").focus(function() {
		$("#username").removeClass("input_user_1");
		$("#username").addClass("input_user_2");
	});
	$("#password").focus(function() {
		$("#password").removeClass("input_passw_1");
		$("#password").addClass("input_passw_2");
	});
})
document.onkeydown=keyListener;
function keyListener(e){
	 e = e ? e : event;
	if(e.keyCode == 13){
		if($("#username").val() && $("#password").val()){
			login();
		}
	}
}

	function login(){
		var username = $.trim($("#username").val());
		var password = $.trim($("#password").val());
		if(username == ""){
			dialog("请输入用户名！");
			return false;
		}
		if(password == ""){
			dialog("请输入密码！");
			return false;
		}
		var params = {};
		params.username = username;
		params.password = zhigu.encodeBase64(password);
		params.autoLogin = $("#autoLogin").val();
		ajaxSubmit("login/loginIn", params, function(msgBean){
			if(msgBean.code==zhigu.code.success){
				var bak = "${backUrl }";
				if(bak != ""){
					window.location.href = bak;
				}else{
					window.location.href = "user/home";
				}
			}else{
				layer.alert(msgBean.msg);
			}
		});
		return true;
	}
</script>
</body>
</html>