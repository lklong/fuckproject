<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>重置密码</title>
<link href="/css/default/user.css" rel="stylesheet"/>
<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
</head>
<body>
<!--** Step.3 重置密码 **-->
<div class="userRegPanel">
  <div class="urpInside">
    <div class="urpMiddleBox">
      <div class="urpTopTip">
        <div id="step1">
          <h2>重置密码 </h2>
        </div>
      </div>
      <div class="urpMiddleDiv">
        <table cellpadding="0" cellspacing="0" class="user-form-table">
          <tr>
            <td style="width:20%">新密码</td>
            <td style="width:80%"><input type="password" class="input-txt" id="password" name="password" />
              <div class="color-red" id="msg_password"></div></td>
          </tr>
          <tr>
            <td>再次输入密码</td>
            <td><input type="password" class="input-txt" id="repassword" />
              <div class="color-red" id="msg_repassword"></div></td>
          </tr>
          <tr>
            <td></td>
            <td><input type="button" class="input-button" value="修改密码" title="修改密码" onclick="_submit()" /></td>
          </tr>
        </table>
      </div>
    </div>
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