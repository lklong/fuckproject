<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div style="height:20px;"></div>
	<table cellpadding="4" cellspacing="4" style="width:600px;margin:0 10px; ">
	<tr><td>实体名称：</td><td>${realStoreAuth.realStoreName }</td></tr>
	<tr><td>经营人：</td><td>${realStoreAuth.master}</td></tr>
	<tr><td>联系电话：</td><td>${realStoreAuth.phone}</td></tr>
	<tr><td>实体地址：</td><td>${realStoreAuth.realStoreAddress}</td></tr>
	<tr><td>实体图1：</td><td><img  src="${realStoreAuth.image1}" width="244px" height="165px"></td></tr>
	<tr><td>实体图2：</td><td><img  src="${realStoreAuth.image2}" width="244px" height="165px"></td></tr>
	<tr><td>实体图3：</td><td><img  src="${realStoreAuth.image3}" width="244px" height="165px"></td></tr>
	<tr><td>审核不通过原因：</td><td><textarea id="rejectReason"></textarea></td></tr>
	</table>
<div style="height:60px;background-color:#f0f0f0;padding-top:20px;">
	<div style="margin:0 auto; width:180px;">
		 	<a onclick="realStorePass()" href="javascript:void(0)" class="sysButonA3"><em></em>&nbsp;&nbsp;&nbsp;通过&nbsp;&nbsp;&nbsp;</a>
	 		<a onclick="realStoreFail()" href="javascript:void(0)" class="sysButonA2"><em></em>&nbsp;&nbsp;&nbsp;不通过&nbsp;&nbsp;&nbsp;</a>
	</div>
</div>