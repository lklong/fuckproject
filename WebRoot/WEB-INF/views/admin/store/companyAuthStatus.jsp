<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<link href="js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css">
<link href="css/jcDate.css" rel="stylesheet" type="text/css" media="all" />
<link href="js/3rdparty/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" language="javascript" src="js/3rdparty/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" language="javascript" src="js/3rdparty/easyui/jquery.easyui.min.js_bak"></script>
<script type="text/javascript" src="../js/admin/store.js"></script>
<script type="text/javascript" src="js/jquery-form.js"></script>
<title></title>
</head>
<body>

<div style="height:20px;"></div>
<table class="sysCommonTable" cellspacing="0" cellpadding="0">
	<tr><th width="10%">企业名称：</th><td width="90%">${companyAuth.companyName }</td></tr>
	<tr><th width="10%">企业类型：</th><td width="90%">${companyAuth.companyTypeLabel}</td></tr>
	<tr><th width="10%">工商注册号：</th><td width="90%">${companyAuth.regNumber}</td></tr>
	<tr><th width="10%">企业法人<br/>(个体工商户业主)：</th><td width="93%">${companyAuth.corporation}</td></tr>
	<tr><th width="10%">营业期限：</th><td width="90%"><c:choose>
						<c:when test="${companyAuth.perpetual==1}">长期</c:when>
						<c:otherwise><fmt:formatDate value="${companyAuth.businessTerm}" pattern="yyyy-MM-dd"/> </c:otherwise>
						</c:choose> </td></tr>
	<tr><th width="10%">注册资金：</th><td width="90%">${companyAuth.capital} 万元</td></tr>
	<tr><th width="10%">营业范围：</th><td width="90%">${companyAuth.businessScope}</td></tr>
	<tr><th width="10%">注册地址：</th><td width="90%">${companyAuth.regProvince}-${companyAuth.regCity}-${companyAuth.regDistrict}-${companyAuth.regStreet}</td></tr>
	<tr><th width="10%">经营地址：</th><td width="90%">${companyAuth.companyProvince}-${companyAuth.companyCity}-${companyAuth.companyDistrict}-${companyAuth.companyStreet}</td></tr>
	<tr><th width="10%">营业执照：</th><td width="90%"><img  src="${companyAuth.image}"></td></tr>
	<tr><th width="10%">业务员：</th><td width="90%">${salesman.realName }</td></tr>
	<tr><th width="10%">上传时间：</th><td width="90%"><fmt:formatDate value="${companyAuth.applyTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </td></tr>
</table>
<form action="admin/store/updateCompanyAuthStatus" id="companyAuthStatusForm" method="post"> 
	<input name="storeID"  type="hidden" value="${storeID }"/>
	<input name="status" id="status"  type="hidden" value=""/>
	<table class="sysCommonTable" cellspacing="0" cellpadding="0">
		<tr><th width="10%">审核不通过原因：</th>
				<td width="90%">
					<textarea id="companyAuthRejectReason" class="dpname fl" name="rejectReason" rows="6" cols="10" style="height: 112px; width: 433px;"></textarea>
					<span style="color:red;"><br/>如果审核不通过，请填写不通过的原因！</span>
				</td>
		</tr>
	</table>
</form>
<div style="height:60px;background-color:#f0f0f0;padding-top:20px;">
	<div style="margin:0 auto; width:210px;">
	 	<a onclick="companyAuthStatus(1)" href="javascript:void(0)" class="sysButonA3"><em></em>通过</a>
	 	<a onclick="companyAuthStatus(2)" href="javascript:void(0)" class="sysButonA3"><em></em>不通过</a>
	</div>
</div>
</body>
</html>
	