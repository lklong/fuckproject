<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
<link href="/css/default/goods.css" rel="stylesheet"/>
<link href="/css/default/shop.css" rel="stylesheet"/>
<title>动态公告</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="shangJiaDongTai">
  <h3>商家公告</h3>
  <div class="notice">
    <c:forEach items="${notice }" var="storeNotice"> ${storeNotice.content } </c:forEach>
  </div>
</div>
<script type="text/javascript">
//隐藏主导航和搜索框
$('.nav').hide();
$('.search').hide();
</script>
</body>
</html>