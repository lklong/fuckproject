<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html >
<html >
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>优惠券</title>
</head>
<body>
<div class="rightContainer">
	<!--// 标题 //-->
		<h3 class="rc_title">
			我现有的优惠券
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<table cellpadding="0" cellspacing="0" class="userCommTable">
				<tr>
					<th>名字</th>
					<th>获得日期</th>
					<th>有效期</th>
					<th>状态</th>
					<th>来源</th>
				</tr>
				<c:forEach items="${page.datas }" var="coupon">
					<tr>
						<td>${coupon.name }</td>
						<td><fmt:formatDate value="${coupon.addTime }" pattern="yyyy-MM-dd"/></td>
						<td><fmt:formatDate value="${coupon.endTime }" pattern="yyyy-MM-dd"/></td>
						<td><font color="#0f8824"><strong>${coupon.statusLabel }</strong></font></td>
						<td>${coupon.source }</td>
					</tr>
				</c:forEach>
			</table>
			<!--// 分页 //-->
			<div class="ddpage">
				<jsp:include page="../include/page.jsp">
					<jsp:param name="request" value="url"/>
					<jsp:param name="requestUrl" value="/user/coupon/queryCouponPage"/>
				</jsp:include>
			</div>
		</div>
</div>
</body>
</html>