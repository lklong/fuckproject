<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>订单支付</title>
<link href="/css/default/user.css" rel="stylesheet">
</head>
<body>
<div class="urpMiddleBox">
	<div class="urpTopTip"><div><h1>支付中心</h1></div></div>
	<div style="padding:20px;">
		<c:if test="${empty msg }">
		<h3 class="color-red">${msgBean.msg }</h3>
		<div>
			<a href="/user/order" class="default-a">我的订单</a>
			<a href="/user/home" class="default-a">个人中心</a>
		</div>
		</c:if>
	</div>
</div>
</body>
</html>