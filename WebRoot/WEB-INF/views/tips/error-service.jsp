<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>业务错误</title>
<link href="/css/default/goods.css" rel="stylesheet">
<link href="/css/default/user.css" rel="stylesheet">
<jsp:include page="/decorate/include/header-head.jsp" />
</head>
<body>
<body>
<jsp:include page="/decorate/include/header-body.jsp" />
	<div class="urpMiddleBox">
		<div class="urpTopTip">
			<div>
				<h1>出现错误!</h1>
			</div>
		</div>
		<div class="fwb txt-center color-red fz16" style="padding: 20px;">
			${exception.message }
		</div>
	</div>
	<jsp:include page="../../../decorate/include/footer.jsp" />
</body>
</html>
