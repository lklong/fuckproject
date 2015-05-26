<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${applicationScope.basePath}" />
<c:choose>
	<c:when test="${index=='index' }">
		<title>货源网【智谷同城货源网】最专业，最方便，最快捷的同城货源平台</title>
	</c:when>
	<c:otherwise>
		<title>智谷同城货源网 －<sitemesh:write property='title' /></title>
	</c:otherwise>
</c:choose>

<jsp:include page="/decorate/include/header-head.jsp" />
<sitemesh:write property='head' />
</head>

<body>
	<jsp:include page="/decorate/include/header-body.jsp" />
	<!-----------------------------------------------userbar----------------------------------------------------------->

	<!--cmstop end-->
	<sitemesh:write property='body' />
	<!--------------------------------------------------------footer-------------------------------------------------------->
	<jsp:include page="include/footer.jsp" />
</body>
</html>
