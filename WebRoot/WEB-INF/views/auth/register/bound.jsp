<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="/css/default/user.css" rel="stylesheet"/>
<script type="text/javascript" src="/js/3rdparty/layer1.9/layer.js"></script>
<title>帐号绑定</title>
</head>
<body>
<div class="userRegPanel">
	<div class="urpInside">
		<div class="urpMiddleBox">
			<div class="urpTopTip">
	          <div id="step1">
	            <h2>绑定第三方账号</h2>
	          </div>
	        </div>
	        <div class="urpMiddleDiv">
	        	<div class="msg-alert">
	        		完成账号绑定后，即可直接使用您的第三方账号登录同城货源网。
	        	</div>
	        </div>
	        <div class="urpMiddleDiv txt-center">
	        	<img src="${avatar }" width="75" height="75" />
	        	<p>用户昵称：<span class="color-red fwb">${nike } </span></p>
	        </div>
	        <div class="urpMiddleDiv txt-center">
	        	<a href="/register">还没有同城账号？去注册 ></a>
	        </div>
	        <div class="urpMiddleDiv">
	        	<table cellpadding="0" cellspacing="0" class="user-form-table" style="width:420px;margin:0 auto;">
					<tr>
						<td style="width:20%">登录名:</td>
						<td style="width:80%"><input name="username" id="username" type="text" class="input-txt" /><span class="color-red" id="e_msg">${e_msg }</span></td>
					</tr>
					<tr>
						<td>登录密码:</td>
						<td><input name="password" type="password" id="password" class="input-txt" /></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><input type="button" class="input-button" onclick="submit()" value="绑定账号"/></td>
					</tr>
				</table>
	        </div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function submit(){
		var params = {};
		params.username = $("#username").val();
		params.password = $("#password").val();
		if(!params.username){
			$("#e_msg").html("请输入登录名");
			return false;
		}
		if(!params.password){
			$("#e_msg").html("请输入密码");
			return false;
		}
		params.password = zhigu.encodeBase64(params.password);
		$.post("/login/bound",params,function(msgBean){
			if(msgBean.code==zhigu.code.success){
				window.location.href = "/user/home";
			}else{
				layer.alert(msgBean.msg);
			}
		})
	}
</script>
</body>
</html>