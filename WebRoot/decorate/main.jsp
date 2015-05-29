<%@ page language="java" pageEncoding="utf-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<base href="${applicationScope.basePath}" />
<c:choose><c:when test="${index=='index' }"><title>货源网【智谷同城货源网】最专业，最方便，最快捷的同城货源平台</title></c:when><c:otherwise><title><sitemesh:write property='title' />-智谷同城货源网</title></c:otherwise></c:choose><jsp:include page="/decorate/include/header-head.jsp" /><sitemesh:write property='head' />
</head>
<body>
<jsp:include page="/decorate/include/header-body.jsp" />
<sitemesh:write property='body' />
<jsp:include page="include/footer.jsp" />
</body>
</html>
