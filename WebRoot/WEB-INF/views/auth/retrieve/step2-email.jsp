<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>密码找回</title>
<link href="css/reg.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<!--** Step.3 重置密码 **-->
	<div class="userRegPanel disnonex">
		<div class="urpInside">
			<div class="urpTopBox"></div>
			<div class="urpMiddleBox">
				<div class="urpTopTip">
					<div id="step1">
						<img src="img/backpass_3.jpg" />
					</div>
				</div>
				<div class="urpMiddleDiv">
					<div class="busyInfoBox">
						<div class="bibTxt">新密码</div>
						<div class="bibinput">
							<input type="password" class="busyInput" id="password" name="password" />
						</div>
						<div class="bibAlert" id="msg_password"></div>
					</div>
					<div class="busyInfoBox">
						<div class="bibTxt">再次输入密码</div>
						<div class="bibinput">
							<input type="password" class="busyInput" id="repassword" />
						</div>
						<div class="bibAlert" id="msg_repassword"></div>
					</div>
					<div class="urpMiddleDiv mt30">
						<br />
						<br /> <input type="button" class="urpSubMit" value="修改密码" title="修改密码" onclick="_submit()" /> <br />
						<br />
						<br /> <br />
						<br />
						<br />
					</div>
				</div>
			</div>
			<div class="urpFootBox"></div>
		</div>
	</div>
	<script type="text/javascript">
function _submit(){
	var pwd = $("#password").val();
	var pwd1 = $("#repassword").val();
	if(!pwd){
		$("#msg_password").html("<p class='failMsg'><em></em>密码不能为空！</p>");
		return false;
	}
	if(!passwordReg(pwd)){
		$("#msg_password").html("<p class='failMsg'><em></em>密码为6-16个字符，必须包含数字、字母！</p>");
		return false;
	}
	if(pwd != pwd1){
		$("#msg_repassword").html("<p class='failMsg'><em></em>两次密码输入不一致！</p>");
		return false;
	}
	var param = {};
	param.uid = "${uid}";
	param.newPwd = pwd;
	$.post("/security/retrieve/step2Email",param , function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.alert("密码修改成功，去登陆",-1,function(){
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