<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>设置登录密码</title>
<script type="text/javascript" src="js/3rdparty/layer/layer.min.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">修改登录密码</h4>
  <table cellpadding="0" cellspacing="0" class="user-form-table">
    <c:if test="${hasPwd == 1 }">
      <tr>
        <td style="width:10%">旧密码：</td>
        <td style="width:90%"><input class="input-txt fl" type="password" name="opwd" id="opwd" autocomplete="off" />
          <span id="e_opwd">${e_opwd }</span></td>
      </tr>
    </c:if>
    <tr>
      <td>新密码：</td>
      <td><input class="input-txt fl" type="password" name="npwd" id="npwd" />
        <span id="e_npwd">${e_npwd }</span></td>
    </tr>
    <tr>
      <td>确认密码：</td>
      <td><input class="input-txt fl" type="password" id="rnpwd" />
        <span id="e_rnpwd"></span></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input class="input-button" type="submit" onclick="return _submit()" value="保存设置" /></td>
    </tr>
  </table>
</div>
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