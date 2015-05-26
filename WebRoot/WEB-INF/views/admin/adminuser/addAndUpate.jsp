<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加/修改管理员</title>
</head>
<body>
	<div style="height: 20px;"></div>
	<table cellpadding="5" cellspacing="5" style="width: 400px; margin: 0 50px; height: 220px;">
		<tr>
			<td>管理员账号:</td>
			<td><input type="text" id="adminName" class="sysCommonInput"  value="${admin.name }"/></td>
		</tr>
		<tr>
			<td>密码:</td>
			<td><input type="password" id="password" class="sysCommonInput" value="${empty admin.password?'':'●●●●●●' }"/></td>
		</tr>
		<tr>
			<td>确认密码:</td>
			<td><input type="password" id="password2" class="sysCommonInput" value="${empty admin.password?'':'●●●●●●' }"/></td>
		</tr>
		<tr>
			<td>真实姓名:</td>
			<td><input type="text" id="realName" class="sysCommonInput" value="${admin.realName }"/></td>
		</tr>
		<tr>
			<td>级别权限:</td>
			<td><select id="roleID" class="sysComSelect">
					<option value="0">请选择</option>
					<c:forEach items="${roles }" var="item">
						<option value="${item.roleID }" <c:if test="${item.roleID == admin.roleId }">selected="selected"</c:if>>${item.roleName }</option>
					</c:forEach>
			</select></td>
		</tr>
	</table>
	<div style="height: 20px;"></div>
	<div style="height: 60px; background-color: #f0f0f0; padding-top: 20px;">
		<div style="margin: 0 auto; width: 180px;">
			<a id="saveCreate" href="javascript:save();" class="sysButonA3"><em></em>&nbsp;&nbsp;&nbsp;确认&nbsp;&nbsp;&nbsp;</a> <a id="cancelClose"
				href="javascript:void(0)" class="sysButonA2"><em></em>&nbsp;&nbsp;&nbsp;取消&nbsp;&nbsp;&nbsp;</a>
		</div>
	</div>

	<script type="text/javascript">
//更新/新增管理员
function save(){
	var adminUser = {};
	var adminId = "${admin.id}";
	adminUser.name = $("#adminName").val();
	adminUser.password = $("#password").val();
	adminUser.realName = $("#realName").val() ;
	adminUser.roleId = $("#roleID").val();
	if(adminUser.password!=$("#password2").val()){
		layer.msg('两次密码不一致！', 1, 5);
		return;
	}

	if(adminUser.password=="●●●●●●"){
		adminUser.password ="";
	}
	if(adminId){
		adminUser.id = adminId;
	}
	$.post("/admin/adminuser/addAndUpate", adminUser, function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.msg(msgBean.msg, 1, function(){
				window.location.href = "/admin/adminuser/index";
			});
		}else{
			layer.alert(msgBean.msg);
		}
	},"json");
}
</script>
</body>
</html>