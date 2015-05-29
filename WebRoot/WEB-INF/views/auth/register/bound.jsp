<%@ page language="java" pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<link href="/css/default/user.css" rel="stylesheet"/>
<title>帐号绑定</title>
<style type="text/css">
	.bdzh2 {
	    align-self: center;
	    background-color: #f0f8ff;
	    border: 1px solid #d6d6d6;
	    text-align: center;
	    width: 200px;
	    cursor: default;
	    margin:0 auto;
	}
</style>
</head>
<body>
<div class="userRegPanel">
	<div class="urpInside">
		<div class="urpMiddleBox">
			<div class="urpBound">
				<div class="urpMethod1"><strong>绑定第三方账号：</strong><font style="font-size:12px;">(完成账号绑定后，即可直接使用您的第三方账号登录同城货源网)</font></div>
				<div class="urpPhoto">
					<div><img src="${avatar }" width="75" height="75" /></div>
					<div>用户昵称：<font color="#ff4444">${nike } </font></div>
				</div>
			</div>
			<div class="urpBound">
				<div>
					<div class="urpMethod1"><strong>同城账号 ： </strong><a href="/register" target="_blank" style="color:#ff5500" class="fr">还没有同城账号？去注册 >></a></div>
						<ul class="urpUl">
							<li><span class="fl w60 tl">&nbsp;</span><font color="#ff4444" id="e_msg">${e_msg }</font></li>
							<li><span class="fl w60 tl">登录名：</span><input name="username" id="username" type="text" class="urpInput" /></li>  
							<li><span class="fl w60 tl">登录密码：</span><input name="password" type="password" id="password" class="urpInput" /></li>
							<li><span class="fl w60 tl">&nbsp;</span><button class="button white bdzh2" onclick="submit()" type="button">绑定账号</button></li>
						</ul>	
				</div>
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
			$("#e_msg").html("请输入用户名");
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