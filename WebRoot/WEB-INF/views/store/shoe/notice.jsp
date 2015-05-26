<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>动态公告</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="shangJiaDongTai">
	<h3>商家公告</h3>
	<div class="notice">
		<c:forEach items="${notice }" var="storeNotice">
			${storeNotice.content }
		</c:forEach>
	</div>
		
<!--     <ul> -->
<%--     	<c:forEach items="${page.datas }" var="sn"> --%>
<%-- 	    	<li><span><fmt:formatDate value="${sn.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </span>▪ ${sn.content }</li> --%>
<%--     	</c:forEach> --%>
<!--     </ul> -->
<!--     <div class="ddpage fr mt20"> -->
<%-- 		<jsp:include page="../../include/page.jsp"> --%>
<%-- 			<jsp:param name="request" value="url"/> --%>
<%-- 			<jsp:param name="requestUrl" value="store/notice?storeId=${store.ID }"/> --%>
<%-- 		</jsp:include> --%>
<!-- 	</div> -->
</div>
</body>
</html>