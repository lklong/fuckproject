<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>邮箱设置</title>
</head>
<body>
<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	邮箱设置<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">邮箱设置</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="body_center2">
		<div class="bangdingmail mt20">
			<form method="post" action="#">
				<p class="mailtitle fl">原邮箱：</p>${email }
				<div class="clear mt10"></div>
				<p class="mailtitle fl">　邮箱：</p>
				<input class="mailtxt fl" name="email" id="email" type="text"  style="margin-top: 10px;"/> <span class="mailhelp" id="mailhelp"></span>
				<div class="clear"></div>
				<input type="button" class="shoujibut mt10 " width="100" onclick="_submit(this)" value="发送验证链接" />
				<div class="mailmiaobox mt10">
					<span id="sendmsg"></span>
				</div>
			</form>
		</div>
	</div>
            	
     </div>
            <br style="clear:both;" />
        </div>
    </div>
	<div class="clear"></div>
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