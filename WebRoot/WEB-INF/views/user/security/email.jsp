<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>邮箱设置</title>
<script type="text/javascript" src="js/3rdparty/layer/layer.min.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">邮箱设置</h4>
  <form method="post" action="#">
    <table cellpadding="0" cellspacing="0" class="user-form-table">
      <tr>
        <td style="width:10%">原邮箱：</td>
        <td style="width:90%">${email }</td>
      </tr>
      <tr>
        <td>新邮箱：</td>
        <td><input class="input-txt" name="email" id="email" type="text"/>
          <span class="color-red" id="mailhelp"></span></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><input type="button" class="input-button" width="100" onclick="_submit(this)" value="发送验证链接" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><span id="sendmsg"></span></td>
      </tr>
    </table>
  </form>
</div>
<script type="text/javascript">
		$().ready(function(){
			var msg = "${msg}";
			if(!isEmpty(msg))
				alert(msg);
		});
		function _submit(obj){
			$("#mailhelp").html("");
			var email = $("#email").val();
			if(!emailReg(email)){
				$("#mailhelp").html("请输入正确的邮箱地址");
				return false;
			}
			send_captcha_waiting(obj);
			$("#sendmsg").html("验证邮件已发送！");
			$.post("/user/security/sendemail", {"email":email}, function(msgBean){
				if(msgBean.code == zhigu.code.success){
					layer.alert(msgBean.msg,-1,function(){
						window.location.href = "/user/security/center";
					});
				}else{
					layer.alert(msgBean.msg);
				}
			});
		}
	</script>
</body>
</html>