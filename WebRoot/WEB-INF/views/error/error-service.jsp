<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>业务错误</title>
<jsp:include page="/decorate/include/header-head.jsp" />
</head>
<body>
<body>
<jsp:include page="/decorate/include/header-body.jsp" />
	<div class="userRegPanel disnonex">
		<div class="urpInside">
			<div class="urpTopBox"></div>
			<div class="urpMiddleBox">
				<div class="urpTopTip">
					<div id="step1">
						<h1 style="color: red">Error！</h1>
					</div>
				</div>
				<div style="text-align: center;word-wrap:break-word; word-break:normal;min-height: 300px;" align="center">
					<p class="okMsg">
						<font size="6" color="#000000">${exception.message }</font>
					</p>
				</div>
			</div>
			<div class="urpFootBox"></div>
		</div>
	</div>
	<jsp:include page="../../../decorate/include/footer.jsp" />
</body>
</html>
