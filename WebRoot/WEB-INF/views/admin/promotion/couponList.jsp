<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>优惠券列表</title>
<script src="js/admin/admin.js" type="text/javascript"></script>

</head>

<body >
<!-- //列表// -->
<table cellpadding="0" cellspacing="0" class="sysCommonTable _memTable">
	<thead>
		<tr>
		   	<th>名字</th>
			<th>获得日期</th>
			<th>有效期</th>
			<th>状态</th>
			<th>来源</th>
		   </tr>
	</thead>
	<tbody>
	<c:forEach items="${page.datas }" var="coupon">
		<tr>
			<td>${coupon.name }</td>
			<td><fmt:formatDate value="${coupon.addTime }" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${coupon.endTime }" pattern="yyyy-MM-dd"/></td>
			<td><font color="<c:choose><c:when test="${coupon.status==0 }">#0f8824</c:when><c:otherwise>#9DA2A5</c:otherwise></c:choose>"><strong>${coupon.statusLabel }</strong></font></td>
			<td>${coupon.source }</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<!-- //分页// -->
<div class="dataPager">
	<div class="ddpage fr mr20">
		<jsp:include page="../../include/page.jsp">
			<jsp:param name="request" value="url"/>
			<jsp:param name="requestUrl" value="/admin/promotion/couponList"/>
		</jsp:include>
	</div>
</div>

</body>
</html>
