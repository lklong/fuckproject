<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>线下转账</title>
</head>
<body>

<table class="sysCommonTable" cellspacing="0" cellpadding="0">
	<tr>
		<th>发布用户名</th>
		<th>用户电话号码</th>
		<th>发布时间</th>
		<th>图片</th>
	</tr>
	<c:forEach var="shortcutgoods" items="${ offlinetransferaccountsList }">
		<tr>
			<td>${shortcutgoods.user.username }</td>
			<td>${shortcutgoods.user.phone }</td>
			<td><fmt:formatDate value="${shortcutgoods.createDate  }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td><img id="test11" src="../../${shortcutgoods.filePath}" style="max-width: 150px;"/></td>
		</tr>
	</c:forEach>
	
</table>
<div class="dataPager">
	<div class="ddpage">
		<jsp:include page="../../include/page.jsp">
			<jsp:param name="request" value="url"/>
			<jsp:param name="requestUrl" value="/admin/offlinePay/offlinePayLook"/>
		</jsp:include>
	</div>
</div>
</body>
</html>