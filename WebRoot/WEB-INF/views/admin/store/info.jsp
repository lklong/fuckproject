<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" >
<link href="css/default/jcDate.css" rel="stylesheet" type="text/css" media="all" />
<script src="js/admin/admin.js" type="text/javascript"></script>
<title></title>
</head>
<body>
	<div class="store" id="xianqinidd3">
		<div class="sysContBar">
			<h3>基本信息</h3>
		</div>
		<table class="sysCommonTable" cellspacing="0" cellpadding="0">
			<tr><th width="7%">网站直达域名：</th><td width="93%"><a href="http://${store.domain }.zhiguw.com" target="_blank">http://${store.domain }.zhiguw.com</a></td></tr>
			<tr><th width="7%">商铺名称：</th><td width="93%">${store.storeName }</td></tr>
			<tr><th width="7%">商家地址：</th><td width="93%">${store.province } ${store.city } ${store.district } ${store.street }</td></tr>
			<tr><th width="7%">所在商圈：</th><td width="93%">${store.businessAreaLabel }</td></tr>
			<tr><th width="7%">手机号码：</th><td width="93%">${store.phone }</td></tr>
			<tr><th width="7%">联系QQ：</th><td width="93%">${store.QQ }</td></tr>
			<tr><th width="7%">联系旺旺：</th><td width="93%">${store.aliWangWang }</td></tr>
		</table>
	</div>
	<c:if test="${not empty companyAuth }">
	<div class="companyAuth">
		<div class="sysContBar">
			<h3>企业认证信息</h3>
		</div>
		<table class="sysCommonTable" cellspacing="0" cellpadding="0">
				<tr><th width="7%">企业名称：</th><td width="93%">${companyAuth.companyName }</td></tr>
				<tr><th width="7%">企业类型：</th><td width="93%">${companyAuth.companyTypeLabel}</td></tr>
				<tr><th width="7%">工商注册号：</th><td width="93%">${companyAuth.regNumber}</td></tr>
				<tr><th width="7%">企业法人<br/>(个体工商户业主)：</th><td width="93%">${companyAuth.corporation}</td></tr>
				<tr><th width="7%">营业期限：</th><td width="93%"><c:choose>
									<c:when test="${companyAuth.perpetual==1}">长期</c:when>
									<c:otherwise><fmt:formatDate value="${companyAuth.businessTerm}" pattern="yyyy-MM-dd"/> </c:otherwise>
									</c:choose> </td></tr>
				<tr><th width="7%">注册资金：</th><td width="93%">${companyAuth.capital} 万元</td></tr>
				<tr><th width="7%">营业范围：</th><td width="93%">${companyAuth.businessScope}</td></tr>
				<tr><th width="7%">注册地址：</th><td width="93%">${companyAuth.regProvince}-${companyAuth.regCity}-${companyAuth.regDistrict}-${companyAuth.regStreet}</td></tr>
				<tr><th width="7%">经营地址：</th><td width="93%">${companyAuth.companyProvince}-${companyAuth.companyCity}-${companyAuth.companyDistrict}-${companyAuth.companyStreet}</td></tr>
				<tr><th width="7%">营业执照：</th><td width="93%"><img  src="${companyAuth.image}" width="244px" height="165px"></td></tr>
				<tr><th width="7%">业务员：</th><td width="93%">${caSaleSman.realName }</td></tr>
				<tr><th width="7%">申请时间：</th><td width="93%"><fmt:formatDate value="${companyAuth.applyTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
				<tr><th width="7%">审核者：</th><td width="93%">${caApproveUser.realName }</td></tr>
				<tr><th width="7%">审核时间：</th><td width="93%"><fmt:formatDate value="${companyAuth.authTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
				<tr><th width="7%">审核状态：</th><c:if test="${store.companyAuth == 0}"><td width="93%" style="color: red;">未认证</td></c:if>
																				  <c:if test="${store.companyAuth == 1}"><td width="93%">认证通过</td></c:if>
																				  <c:if test="${store.companyAuth == 2}"><td width="93%">认证不通过</td></c:if>
				</tr>
				<c:if test="${companyAuth.status==2 }">
					<tr><th width="7%">审核不通过原因：</th><td width="93%"><textarea id="rejectReason">${companyAuth.rejectReason}</textarea></td></tr>
				</c:if>
		</table>
	</div>
	</c:if>
	<c:if test="${not empty realStoreAuth }">
	<div class="storeAuth">
		<div class="sysContBar">
			<h3>实体认证信息</h3>
		</div>
		<table class="sysCommonTable" cellspacing="0" cellpadding="0">
				<tr><th width="7%">实体名称：</th><td width="93%">${realStoreAuth.realStoreName }</td></tr>
				<tr><th width="7%">经营人：</th><td width="93%">${realStoreAuth.master}</td></tr>
				<tr><th width="7%">联系电话：</th><td width="93%">${realStoreAuth.phone}</td></tr>
				<tr><th width="7%">实体地址：</th><td width="93%">${realStoreAuth.realStoreAddress}</td></tr>
				<tr><th width="7%">实体图1：</th><td width="93%"><img  src="${realStoreAuth.image1}" width="244px" height="165px"></td></tr>
				<tr><th width="7%">实体图2：</th><td width="93%"><img  src="${realStoreAuth.image2}" width="244px" height="165px"></td></tr>
				<tr><th width="7%">实体图3：</th><td width="93%"><img  src="${realStoreAuth.image3}" width="244px" height="165px"></td></tr>
				<tr><th width="7%">业务员：</th><td width="93%">${rsSaleSman.realName }</td></tr>
				<tr><th width="7%">申请时间：</th><td width="93%"><fmt:formatDate value="${realStoreAuth.applyTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
				<tr><th width="7%">审核者：</th><td width="93%">${rsApproveUser.realName }</td></tr>
				<tr><th width="7%">审核时间：</th><td width="93%"><fmt:formatDate value="${realStoreAuth.authTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
				<tr><th width="7%">审核状态：</th><c:if test="${store.realStoreAuth == 0}"><td width="93%" style="color: red;">未认证</td></c:if>
																				  <c:if test="${store.realStoreAuth == 1}"><td width="93%">认证通过</td></c:if>
																				  <c:if test="${store.realStoreAuth == 2}"><td width="93%">认证不通过</td></c:if>
				</tr>
				<c:if test="${realStoreAuth.status == 2 }">
					<tr><th width="7%">审核不通过原因：</th><td width="93%">${realStoreAuth.rejectReason}</td></tr>
				</c:if>
		</table>
	</div>
	</c:if>
</body>
</html>