<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>错误提示</title>
</head>
<body>
<body>
	<div class="userRegPanel disnonex">
		<div class="urpInside">
			<div class="urpTopBox"></div>
			<div class="urpMiddleBox">
				<div class="urpTopTip">
					<div id="step1">
					</div>
				</div>
				<div style="text-align: center;word-wrap:break-word; word-break:normal;min-height: 300px;" align="center">
					<p class="okMsg">
						<font size="6" color="#000000">${msg }</font>
					</p>
				</div>
			</div>
			<div class="urpFootBox"></div>
		</div>
	</div>
</body>
</html>