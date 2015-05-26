<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div style="height:20px;"></div>
	<table cellpadding="4" cellspacing="4" style="width:600px;margin:0 10px; ">
	<tr><td>企业名称：</td><td>${companyAuth.companyName }</td></tr>
	<tr><td>企业类型：</td><td>${companyAuth.companyTypeLabel}</td></tr>
	<tr><td>工商注册号：</td><td>${companyAuth.regNumber}</td></tr>
	<tr><td>企业法人/个体工商户业主：</td><td>${companyAuth.corporation}</td></tr>
	<tr><td>营业期限：</td><td><c:choose>
						<c:when test="${companyAuth.perpetual==1}">长期</c:when>
						<c:otherwise><fmt:formatDate value="${companyAuth.businessTerm}" pattern="yyyy-MM-dd"/> </c:otherwise>
						</c:choose> </td></tr>
	<tr><td>注册资金：</td><td>${companyAuth.capital} 万元</td></tr>
	<tr><td>营业范围：</td><td>${companyAuth.businessScope}</td></tr>
	<tr><td>注册地址：</td><td>${companyAuth.regProvince}-${companyAuth.regCity}-${companyAuth.regDistrict}-${companyAuth.regStreet}</td></tr>
	<tr><td>经营地址：</td><td>${companyAuth.companyProvince}-${companyAuth.companyCity}-${companyAuth.companyDistrict}-${companyAuth.companyStreet}</td></tr>
	<tr><td>营业执照：</td><td><img  src="${companyAuth.image}" width="244px" height="165px"></td></tr>
	<tr><td>审核不通过原因：</td><td><textarea id="rejectReason"></textarea></td></tr>
	</table>
<div style="height:60px;background-color:#f0f0f0;padding-top:20px;">
	<div style="margin:0 auto; width:180px;">
		 	<a onclick="companyAuthPass()" href="javascript:void(0)" class="sysButonA3"><em></em>&nbsp;&nbsp;&nbsp;通过&nbsp;&nbsp;&nbsp;</a>
	 		<a onclick="companyAuthFail()" href="javascript:void(0)" class="sysButonA2"><em></em>&nbsp;&nbsp;&nbsp;不通过&nbsp;&nbsp;&nbsp;</a>
	</div>
</div>