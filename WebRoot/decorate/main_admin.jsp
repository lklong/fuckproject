<%@ page language="java" pageEncoding="utf-8"%>
<% String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>智谷同城网站后台管理系统<sitemesh:write property='title' /></title>
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/global.js"></script>
<script type="text/javascript" src="/js/admin/bonegrid.js"></script>
<script src="/js/admin/admin.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript" src="/js/3rdparty/layer/layer.min.js"></script>
<script type="text/javascript" language="javascript" src="/js/3rdparty/easyui/jquery.easyui.min.js"></script>

<link href="/js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" media="all" href="/css/admin/manager.css" />
<script type="text/javascript">
		var ctx = "${ctx}";
		
		$(document).ready(function(){
			$("#menu").find("li").each(function(){
				$(this).mouseover(function(){
					$(this).find(".cmsnavnr").show();
				});
				$(this).mouseout(function(){
					$(this).find(".cmsnavnr").hide();
				});
			});
			
			/* 消息弹出框 */
			
			$("#userMsgSpan").hover(
				function(){$("#userMsgBox").show();},
				function(){$("#userMsgBox").hide();}
			);
			
			/* 设置菜单高度 */
			changeMenuHeight();
		});
		function changeMenu(url) {
			location.href = url;
		}
		function changeMenuHeight()
		{
			var win_h = $(document).height();
			win_h = win_h - 70 - 145;
			$("#sysCenterLeft").css("height",win_h);
		}
	</script>
<sitemesh:write property='head' />
</head>

<body>
	<!--// 顶部布局 //-->
	<div class="sysTopBox">
		<div class="sysTopLogo">
			<div class="sysLogo">
				<img src="../../img/admin/syslog.png" />
			</div>
			<div class="sysAdminInfo" style="width: 638px;">
				<span class="sysAdminName">${sessionScope.sessionAdminUser.name }，您好！</span>
				<ul class="sysAdminUl">
					<li><a href="#">消息</a></li>
					<li><a href="/" target="_blank">网站首页</a></li>
					<li><a href="Admanage/main" target="_blank">广告管理</a></li>
					<li><a href="javascript:void(0);" onclick="f5();">刷新</a></li>
					<li><a href="javascript:void(0)" onclick="updatePwdDialog();">修改密码</a></li>
					<li><a href="/admin/logout">退出</a></li>
				</ul>
			</div>
		</div>
		
		<div class="sysNavBar">
			<div class="sysNavInside">
				<ul class="sysTopNav">
					<c:forEach items="${mainMenus }" var="item">
						<li><a href="${item.resourceUrl}" <c:if test="${cMainmenu.resourceUrl == item.resourceUrl}">class="seclted"</c:if>>${item.resourceName }</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<!--// 中部布局 //-->
	<div class="sysCenterBox">
		<div class="sysCenterLeft" id="sysCenterLeft">
			<h1 class="sysMenuTitle">${cMainmenu.resourceName}</h1>
			<ul class="sysMenuUl">
				<c:forEach items="${subMenus }" var="item">
					<li><a href="${item.resourceUrl}" <c:if test="${item.resourceUrl==cSubmenu.resourceUrl}">class="sysMenuSelected"</c:if>>${item.resourceName}</a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="sysCenterRight">
			<sitemesh:write property='body' />
		</div>
	</div>
	<div id="updatePwdDiv" style="display: none; text-align: center;">
		<table>
			<tr><th>请输入原密码：</th><td><input type="password" name="oldPwd" id="oldPwd"/></td></tr>
			<tr><th>请输入新密码：</th><td><input type="password" name="newPwd" id="newPwd"/></td></tr>
			<tr><td colspan="2"><span class="pwdmsg" style="color:red;"></span></td></tr>
			<tr><td colspan="2"><input type="button" onclick="updatePwd()" value="修改"/></td></tr>
		</table>
	</div>
	<!--// 底部部布局 //-->
	<div class="sysFootBox">Copyright ZHIGUW.COM,All rights reserved.</div>
<script type="text/javascript" language="javascript" src="/js/adminDialog.js?v=20150203"></script>
<script type="text/javascript">
function updatePwdDialog(){
	$.layer({
	    type : 1,
	    title : '修改密码',
	    area : ['250px','200px'],
	    page : {dom : '#updatePwdDiv'}
	});
}
function updatePwd(){
	var oldpwd = $("#oldPwd").val();
	var newpwd = $("#newPwd").val();
	if(oldpwd == newpwd){
		$(".pwdmsg").html("新密码与原密码一致了！");
		return;
	}
	ajaxSubmit("/admin/updatePwd", {"oldPwd":oldpwd,"newPwd":newpwd}, function (msgBean){
		if(msgBean.code=zhigu.code.success){
			layer.msg(msgBean.msg);
			setTimeout("changePage()", 1000);
		}else{
			layer.alert(msgBean.msg);
		}
	});
}
function changePage(){
	window.location.href = "/admin";
}
</script>
</body>
</html>
