<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<h3 style="line-height:30px;text-align:left;">填写的被推荐人（有效期15天）：</h3>
<table id="userWriteRecommend" class="sysCommonTable" cellspacing="0" cellpadding="0" border="0">
	<tr><th>姓名</th><th>手机</th><th>添加时间</th><th>是否注册</th></tr>
	<c:forEach items="${page.datas }" var="userRecommend">
		<tr id="tip_no_data1">
			<td >${userRecommend.recommendName }</td>
			<td>${userRecommend.recommendPhone }</td>
			<td><fmt:formatDate value="${userRecommend.addTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>${userRecommend.isRegister==1?"已注册":"未注册" }</td>
		</tr>
	</c:forEach>
</table>
<div class="dataPager">
	<div class="ddpage">
		<jsp:include page="../../include/page-mini.jsp">
			<jsp:param name="request" value="ajax"/>
			<jsp:param name="requestUrl" value="admin/member/queryUserWriteRecommend?userID=${userID }"/>
		</jsp:include>
	</div>
</div>