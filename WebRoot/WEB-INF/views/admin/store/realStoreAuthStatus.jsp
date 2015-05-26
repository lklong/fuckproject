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
<table class="sysCommonTable" cellspacing="0" cellpadding="0">
		<tr><th width="10%">实体名称：</th><td width="90%">${realStoreAuth.realStoreName }</td></tr>
		<tr><th width="10%">经营人：</th><td width="90%">${realStoreAuth.master}</td></tr>
		<tr><th width="10%">联系电话：</th><td width="90%">${realStoreAuth.phone}</td></tr>
		<tr><th width="10%">实体地址：</th><td width="90%">${realStoreAuth.realStoreAddress}</td></tr>
		<tr><th width="10%">实体图1：</th><td width="90%"><img  src="${realStoreAuth.image1}" width="244px" height="165px"></td></tr>
		<tr><th width="10%">实体图2：</th><td width="90%"><img  src="${realStoreAuth.image2}" width="244px" height="165px"></td></tr>
		<tr><th width="10%">实体图3：</th><td width="90%"><img  src="${realStoreAuth.image3}" width="244px" height="165px"></td></tr>
		<tr><th width="10%">业务员：</th><td width="90%">${salesman.realName }</td></tr>
		<tr><th width="10%">上传时间：</th><td width="90%"><fmt:formatDate value="${realStoreAuth.applyTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </td></tr>
</table>
<form action="admin/store/updateRealStoreAuthStatus" id="realStoreAuthStatusForm" method="post"> 
	<input name="storeID"  type="hidden" value="${storeID }"/>
	<input name="status" id="status"  type="hidden" value=""/>
	<table class="sysCommonTable" cellspacing="0" cellpadding="0">
		<tr><th width="10%">审核不通过原因：</th>
				<td width="90%">
					<textarea id="rsaRejectReason" class="dpname fl" name="rejectReason" rows="6" cols="10" style="height: 112px; width: 433px;"></textarea>
					<span style="color:red;"><br/>如果审核不通过，请填写不通过的原因！</span>
				</td>
		</tr>
	</table>
</form>
<div style="height:60px;background-color:#f0f0f0;padding-top:20px;">
	<div style="margin:0 auto; width:210px;">
	 	<a onclick="realStoreAuthStatus(1)" href="javascript:void(0)" class="sysButonA3"><em></em>通过</a>
	 	<a onclick="realStoreAuthStatus(2)" href="javascript:void(0)" class="sysButonA3"><em></em>不通过</a>
	</div>
</div>
</body>
</html>
	