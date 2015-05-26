<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>密码找回</title>
<link href="css/reg.css" rel="stylesheet" type="text/css" />
</head>
<body>
<!--** Step.2 身份验证 **-->
<div class="userRegPanel disnonex">
	<div class="urpInside">
    	<div class="urpTopBox"></div>
        <div class="urpMiddleBox">
        	<div class="urpTopTip"><div id="step1"><img src="img/backpass_2.jpg" /></div></div>
	            <div class="urpMiddleDiv">
	            	<div class="urpAlert" style="width:410px;"></div><br />
	                <div class="urpAlert"> 你绑定的手机：<span class="cf86666">${phone }</span> </div>
	                <br /><br /><br />
	                
	                <div class="noEmail">
	                验证码：<br/>
							<input type="text" placeholder="填写6位手机验证码" id="captcha" class="gophone_txt fl mr10" />
							新密码：<input type="password"  id="password" class="gophone_txt fl mr10" />
							重复密码：<input type="password"  id="repassword" class="gophone_txt fl mr10" />
	                </div>
	                <div class="noEmail"><br/>
	            	没收到验证码短信？
	                <p>
	                    由于短信服务商原因，可能会有延迟，请耐心等待。
	                    如果您10分钟还没收到，可以再次发送验证码。
	                    如果以上不能解决，请联系客服。<br /><br />
	                </p>
	            	</div>
	            </div>
        </div>
        <div class="urpMiddleDiv mt30">
           	<input type="button" class="urpSubMit" value="修改密码" title="修改密码" onclick="resetPwd()" type="button" />
           </div>
        <div class="urpFootBox"></div>
    </div>
</div>

<script type="text/javascript">
function resetPwd(){
	var param = {};
	var pwd = $("#password").val();
	var repwd = $("#repassword").val();
	if(pwd != repwd){
		layer.alert("重复密码错误");
		return false;
	}
	$.post("/security/retrieve/step2_phone",param,function(msgBean){
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