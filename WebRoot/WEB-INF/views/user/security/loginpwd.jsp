<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设置登录密码</title>
</head>
<body>

	<div class="rightContainer">
		<!--// 标题 //-->
		<h3 class="rc_title">
			修改登录密码<a href="user/home">我的主页</a>
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<!--// tab切换条 //-->
			<div id="userCommTab" class="userCommTab">
				<ul>
					<li><a href="javascript:void(0);" class="uctSelected">设置登录密码</a></li>
				</ul>
			</div>
			<div id="userContents" class="userContents">
				<!--// 内容1 //-->
				<div class="body_center2">
					<div class="dengluform">
						<c:if test="${hasPwd == 1 }">
							<div class="dlform1">
								<p class="fl">旧密码：</p>
								<input class="dlformtxt fl" type="password" name="opwd" id="opwd" autocomplete="off" /> <span class="mimahelp" id="e_opwd">${e_opwd }</span>
								<div class="dldj">
									<div class="dldj0"></div>
									<div class="dldj0"></div>
									<div class="dldj0"></div>
								</div>
								<div class="clear"></div>
							</div>
						</c:if>
						<div class="dlform1">
							<p class="fl">新密码：</p>
							<input class="dlformtxt fl" type="password" name="npwd" id="npwd" /> <span class="mimahelp" id="e_npwd">${e_npwd }</span>
							<div class="dldj">
								<div class="dldj0"></div>
								<div class="dldj0"></div>
								<div class="dldj0"></div>
							</div>
							<div class="clear"></div>
						</div>
						<div class="dlform1">
							<p class="fl">确认密码：</p>
							<input class="dlformtxt fl" type="password" id="rnpwd" /> <span class="mimahelp" id="e_rnpwd"></span>
							<div class="dldj">
								<div class="dldj0"></div>
								<div class="dldj0"></div>
								<div class="dldj0"></div>
							</div>
							<div class="clear"></div>
						</div>
						<input class="dlsub" type="submit" onclick="return _submit()" value="设置密码" />
					</div>
				</div>
			</div>
			<br style="clear: both;" />
		</div>
	</div>
	<div class="clear"></div>
	<script type="text/javascript">
		function _submit(){
			$("#e_opwd").html("");
			$("#e_npwd").html("");
			$("#e_rnpwd").html("");
			
			if("${hasPwd}" == 1){
				var opwd = $("#opwd").val();
				if(isEmpty(opwd)){
					layer.alert("请输入密码");
					return false;
				}
			}
			var npwd = $("#npwd").val();
			var rnpwd = $("#rnpwd").val();
			
			if(isEmpty(npwd)){
				layer.alert("请输入密码");
				return false;
			}else{
				if(!passwordReg(npwd)){
					layer.alert("密码为6-16个字符，必须包含数字、字母");
					return false;
				}
			}
			
			if(npwd != rnpwd){
				layer.alert("两次密码输入不一致");
				return false;
			}
			
			$.post("/user/security/updateLoginpwd",{'opwd':opwd,'npwd':npwd},function(msgBean){
				if(msgBean.code == zhigu.code.success){
					layer.msg(msgBean.msg,2,function(){
						window.location.href = "/user/home";
					});
				}else{
					layer.alert(msgBean.msg);
				}
			})
		}
	</script>
</body>
</html>