<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div style="height:20px;"></div>
	<table cellpadding="4" cellspacing="4" style="width:600px;margin:0 10px; ">
	<tr><td>真实姓名：</td><td>${realUserAuth.realName }</td></tr>
	<tr><td>身份证号码：</td><td>${realUserAuth.idCard}</td></tr>
	<tr><td>身份证到期时间：</td><td><c:choose>
						<c:when test="${realUserAuth.perpetual==1}">长期</c:when>
						<c:otherwise>${realUserAuth.cardValidity}</c:otherwise>
						</c:choose> </td></tr>
	<tr><td>身份证正面：</td><td><img  src="${realUserAuth.cardFrontImg}"  width="244px" height="165px"></td></tr>
<%-- 	<tr ><td>身份证反面：</td><td><img  src="${realUserAuth.cardBackImg}" width="244px" height="165px"></td></tr> --%>
	<tr><td>审核不通过原因：</td><td><textarea id="rejectReason"></textarea></td></tr>
	</table>
<div style="height:20px;"></div>
<div style="height:60px;background-color:#f0f0f0;padding-top:20px;">
	<div style="margin:0 auto; width:180px;">
		 	<a onclick="realUserAuthPass(${realUserAuth.userID})" href="javascript:void(0)" class="sysButonA3"><em></em>&nbsp;&nbsp;&nbsp;通过&nbsp;&nbsp;&nbsp;</a>
	 		<a onclick="realUserAuthFail(${realUserAuth.userID})" href="javascript:void(0)" class="sysButonA2"><em></em>&nbsp;&nbsp;&nbsp;不通过&nbsp;&nbsp;&nbsp;</a>
	</div>
</div>