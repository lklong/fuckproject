<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<link href="js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css">
<link href="css/default/jcDate.css" rel="stylesheet" type="text/css" media="all" />
<link href="js/3rdparty/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" language="javascript" src="js/3rdparty/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" language="javascript" src="js/3rdparty/easyui/jquery.easyui.min.js_bak"></script>
<script type="text/javascript" src="../js/admin/member.js"></script>
<title></title>
</head>
<body>

<div style="height:20px;"></div>
<table class="sysCommonTable" cellspacing="0" cellpadding="0">
	<tr><th width="10%">真实姓名：</th><td width="90%">${realUserAuth.realName }</td></tr>
	<tr><th width="10%">身份证号码：</th><td width="90%">${realUserAuth.idCard}</td></tr>
	<tr><th width="10%">身份证到期时间：</th><td width="90%"><c:choose>
						<c:when test="${realUserAuth.perpetualFlag ==true}">长期</c:when>
						<c:otherwise><fmt:formatDate value="${realUserAuth.cardValidity}" pattern="yyyy-MM-dd"/> </c:otherwise>
						</c:choose> </td></tr>
	<tr><th width="10%">身份证正面图</th><td width="93%"><img  src="${realUserAuth.cardFrontImg}"></td></tr>
	<tr><th width="10%">业务员：</th><td width="90%">${addAdmin.realName }</td></tr>
	<tr><th width="10%">上传时间：</th><td width="90%"><fmt:formatDate value="${realUserAuth.addTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </td></tr>
</table>
<form action="admin/store/updateCompanyAuthStatus" id="companyAuthStatusForm" method="post"> 
	<input name="userID" id="userID" type="hidden" value="${userID }"/>
	<input name="status" id="status"  type="hidden" value=""/>
	<table class="sysCommonTable" cellspacing="0" cellpadding="0">
		<tr><th width="10%">审核不通过原因：</th>
				<td width="90%">
					<textarea id="rejectReason" class="dpname fl" name="rejectReason" rows="6" cols="10" style="height: 112px; width: 433px;"></textarea>
					<span style="color:red;"><br/>如果审核不通过，请填写不通过的原因！</span>
				</td>
		</tr>
	</table>
</form>
<div style="height:60px;background-color:#f0f0f0;padding-top:20px;">
	<div style="margin:0 auto; width:210px;">
	 	<a onclick="realUersAuthStatus(1)" href="javascript:void(0)" class="sysButonA3"><em></em>通过</a>
	 	<a onclick="realUersAuthStatus(2)" href="javascript:void(0)" class="sysButonA3"><em></em>不通过</a>
	</div>
</div>
</body>
</html>
	