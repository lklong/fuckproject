<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>推广提成记录</title>
<script src="js/admin/admin.js" type="text/javascript"></script>

</head>

<body >
<!-- //功能条// -->
<div class="sysContBar">
	<div class="sysCBBox">
		<span class="red">* 提成是在用户确认收货的时候进行分配。</span>
	</div>
	<div class="sysCBBox">
		<form action="admin/promotion/showCommissionRecord" id="queryFrom">
			订单号：<input name="orderNO" class="sysCommonInput" />
			<input type="submit" value="查询" class="sysSubmit" />
		</form>
	</div>
</div> 

		<table class="sysCommonTable _memTable" cellspacing="0" cellpadding="0">
			 	<thead>
				<tr>
					<th width="150">用户账户</th>
					<th width="100">提成级别</th>
					<th width="200">提成比例(基础比例x级别比例)</th>
					<th width="300">提成订单号</th>
					<th width="200">获得提成金</th>
					<th width="300">记录时间</th>
				</tr>
				</thead>
				<tbody>
					<c:forEach items="${commissionRecords }" var="commissionRecord">
						<tr><td>${commissionRecord.userName }</td>
						<td>${commissionRecord.level }</td>
						<td>
						<c:choose>
							<c:when test="${commissionRecord.level==0 }">
								${commissionRecord.innerEmployeePorportion }% x 100% (公司员工)
							</c:when>
							<c:otherwise>
								${commissionRecord.basePorportion }% x ${commissionRecord.commissionPorportion }%
							</c:otherwise>
						</c:choose>
						</td>
						<td><a style="text-decoration:underline;" href="admin/order/detail?orderID=${commissionRecord.orderID }" target="_blank">${commissionRecord.orderNO }</a></td>
						<td><font color="#ff3300">${commissionRecord.commissionMoney }</font></td>
						<td><fmt:formatDate value="${commissionRecord.addDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
					</c:forEach>
				</tbody>
		</table>
<!--// 分页 //-->
<div class="dataPager">
	<div class="ddpage">
		<jsp:include page="../../include/page.jsp">
			<jsp:param name="request" value="form"/>
			<jsp:param name="requestForm" value="queryFrom"/>
		</jsp:include>
	</div>
</div>
</body>
</html>
