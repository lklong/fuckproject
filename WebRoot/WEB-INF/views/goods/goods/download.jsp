<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table>
	<tr>
		<td class="bgTd">会员名</td>
		<td class="bgTd">下载时间</td>
	</tr>
	<c:forEach items="${page.datas }" var="d">
		<tr>
			<td>${d.userName }</td>
			<td><fmt:formatDate value="${d.downloadTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
		</tr>
	</c:forEach>
</table>

<div class="clear"></div>
<form action="/goods/ajax/download/history" method="post" id="downloadForm">
	<input type="hidden" name="goodsId" value="${goodsId }">
</form>
<div class="ddpage fr mt20">
	<jsp:include page="../../include/page.jsp">
		<jsp:param name="request" value="ajax"/>
		<jsp:param name="requestForm" value="downloadForm"/>
	</jsp:include>
</div>