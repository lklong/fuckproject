<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html >
<html >
<head><base href="${applicationScope.basePath}"/>

<title>智谷同城网站后台管理系统</title>
<link type="text/css" href="css/admin/manager.css"  rel="stylesheet" rev="stylesheet" />
<script type="text/javascript" language="javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="/js/global.js"></script>
<script type="text/javascript">
	function login(){
		$("#errormsg").html("");
		var params = {};
		params.username = $("#username").val();
		params.password = zhigu.encodeBase64($("#password").val());
		ajaxSubmit("admin/login",params,function(msgBean){
			if(msgBean.code==zhigu.code.success){
				location.href = "admin/index";
			}else{
				$("#errormsg").html(msgBean.msg);
			}
		});
	}
	$(document).ready(function(){
		setPos();
	}
	);
	$(window).resize(function(){
			setPos();
	});
	/* 设置登录div位置 */
	function setPos()
	{
	$("#loginPanelBox").hide();
	var win_h = $(document).height();	
	var win_w = $(document).width();
	win_h = win_h / 2 - 485 / 2;
	win_w = win_w / 2 - 573 / 2;
	$("#loginPanelBox").css({"left":win_w, "top":win_h});
	$("#loginPanelBox").fadeIn("fast");
	}
</script>
</head>
<body style="background-color:#E4FAFF !important;">

<form action="admin/login" method="post" id="loginform">
<div id="loginPanelBox" class="loginPanelBox">
	<div class="loginInsideBox">
    	<div class="loginLine">
        	<div><h3>帐号</h3></div>
            <div><input type="text" class="sysloginInput1" name="username" id="username"/></div>
        </div>
        <div class="loginLine">
        	<div><h3>密码</h3></div>
            <div><input type="password" class="sysloginInput2"  name="password" id="password"/></div>
        </div>
        <div class="loginLine_c">
		<p><a href="javascript:login()" class="loginButton">&nbsp;</a></p>
        </div>
        <div class="loginLine_c">
        	<!--   <li class="clear over_hid">
	                <div class="fl f14 w63 c666">验证码：</div>
	                <div class="ml10 fl"><input type="text"  class=" textregist130" name="checkcode"/></div>
	                <div class=" fl ml20"><div><img alt="换一个" src="captcha.jpg" class="cursor" width="130" height="40" onclick="this.src=this.src+'?'+Math.random()" /></div></div>
	              
	            </li> -->
        </div>
        <div class="loginLine" id="errormsg" style="text-align:center; color:#ff3300;">
			<font color="red" id="errorMessage"></font>
			<p id="errormsg" style="margin-top: 20px;color: red;">${errorMsg }</p>
		</div>
    </div>
</div>
</form>

</body>
</html>
