<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>

<title></title>
<link href="css/jcDate.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/page.css" rel="stylesheet" type="text/css" />
<script src="js/admin/admin.js" type="text/javascript"></script>

</head>

<body>
	<!--------------------------------------------------center首页--------------------------------------------------->
	<div class="admincenter">
		<div class="admincenterleft">
			<div class="sutjbj fwbold">认证审核</div>
			<ul class="tjulbj" id="sujuid">
				<li onclick="" ><img src="img/admin/heisgx.jpg" width="4" height="7" /><span class="ml10">商品审核</span></li>
				<li onclick="" class="secltedtj"><img src="img/admin/heisgx.jpg" width="4" height="7" /><span class="ml10">企业认证审核</span></li>
				<li onclick=""><img src="img/admin/heisgx.jpg" width="4" height="7" /><span class="ml10">实体认证审核</span></li>
			</ul>
		</div>
		<div class="admincenterright"></div>
	</div>

	<div id="realUserAuthInfo" class="easyui-window" closed="true" modal="true" title="认证信息" style="width: 500px; height: 600px;">

	</div>

	<script type="text/javascript">
		
	</script>
</body>
</html>
