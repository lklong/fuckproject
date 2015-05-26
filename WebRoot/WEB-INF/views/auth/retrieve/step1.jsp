<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>密码找回</title>
</head>
<body>
<!--** 找回密码板块 **-->
<!--** Step.1 填写信息 **-->
<form action="/security/retrieve/step1" method="post" >
<div class="userRegPanel">
	<div class="urpInside">
    	<div class="urpTopBox"></div>
        <div class="urpMiddleBox">
        	<div class="urpTopTip"><div id="step1"><img src="img/backpass_1.jpg" /></div></div>
        	<div class="busyInfoBox">
            	<div class="bibTxt" style="padding:0;">
                    <select name="type" id="getBackType">
                    	<option value="1" >手机</option>
                        <option value="2">邮箱</option>
                    </select></div>
                <div class="bibinput">
                	<input type="text" class="busyInput" value="${username }" id="username" name="username"/>
                </div>
                <div class="bibAlert" id="msg_username"></div>
            </div>
            <div class="busyInfoBox">
            	<div class="bibTxt">验证码</div>
                <div class="bibinput">
                	<input type="text" class="busyInput" style="width:160px; clear:both"  name="captcha" id="captcha"/>
                    <img alt="验证码" title="点击换一个" src="captcha"  width="100" height="40" onclick="this.src=this.src+'?'+Math.random()" />
                </div>
                <div class="bibAlert" id="msg_captcha"></div>
            </div>
        
            <div class="urpMiddleDiv mt30">
            	<br /><br /><br />
            	<input type="button" class="urpSubMit" value="下一步" title="下一步" onclick="retrieveSubmit()"/>
                <br /><br /><br />
                <br /><br /><br />
            </div>
        </div>
        <div class="urpFootBox"></div>
    </div>
</div>
</form>


<script type="text/javascript">
	function retrieveSubmit(){
		var username = $("#username").val();
		var type = $("#getBackType").val();
		var captcha = $("#captcha").val();
		if(type == 1 && !phoneReg(username)){
			$("#msg_username").html("<p class='failMsg'><em></em>请输入正确的手机号码！</p>");
			return false;
		}
		if(type == 2 && !emailReg(username)){
			$("#msg_username").html("<p class='failMsg'><em></em>请输入正确的邮箱地址！</p>");
			return false;
		}
		if(!captcha){
			$("#msg_captcha").html("<p class='failMsg'><em></em>请输入验证码！</p>");
			return false;
		}
		var param = {};
		param.username = username;
		param.captcha = captcha;
		param.type = type;
		$.post("/security/retrieve/step1",param,function(msgBean){
			if(msgBean.code==zhigu.code.success){
				if(type==1){
					window.location.href = "/security/retrieve/step2phone";
				}else if(type==2){
					window.location.href = "/security/retrieve/step2EmailTips?msg="+msgBean.msg;
				}
			}else{
				layer.alert(msgBean.msg);
			}
		})
	}
</script>
</body>
</html>