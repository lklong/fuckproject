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
<div class="sysContBar">
		<ul class="xiangqing_ul">
			<li class="xiangqing_seclted" onclick="showdis(this,'xianqinidd2')">基本资料</li>
			<li  onclick="showdis(this,'xianqinidd1')">买家订单</li>
			<c:if test="${not empty store }">
				<li onclick="showdis(this,'xianqinidd5')">卖家订单</li>
				<li onclick="showdis(this,'xianqinidd3')">店铺资料</li>
			</c:if>
			<li onclick="showdis(this,'xianqinidd4'),acc();">账户信息</li>
			<li onclick="showdis(this,'xianqinidd6')">认证信息</li>
		</ul>
	<input type="hidden" id="memberID" value="${memberID }">
</div>

<div class="xianqinidd disnone" id="xianqinidd1">
	<div class="tableActBar">
		<div class="fwbold">
			已买商品：<font color="#119911" size="+1">${stat.yetBuy + 0 }</font>件&nbsp;&nbsp;&nbsp;&nbsp;已消费：<font color="#ff5500" size="+1">${stat.yetBuyMoney +0}</font>元  
			&nbsp;&nbsp;&nbsp;&nbsp;已卖商品：<font color="#119911" size="+1">${stat.yetSale + 0 }</font>件&nbsp;&nbsp;&nbsp;&nbsp;已入款：<font color="#ff5500" size="+1">${stat.yetSaleMoney + 0 }</font>元
		</div>
		<div class="fwbold">今日需发货：<font color="#119911" size="+1">${stat.waitSend + 0 }</font>件&nbsp;&nbsp;&nbsp;&nbsp;金额：<font color="#ff5500" size="+1">${stat.waitSendMoney + 0 }</font>元</div>
	</div>
	<div id="xianqinidd11"></div>
</div>
	
	<div class="hyglbox2 lh30 mt30 xianqinidd " id="xianqinidd2">
		<table class="sysCommonTable" cellspacing="0" cellpadding="0">
			<tr>
				<th width="7%">用户名：</th>
				<td width="93%">${auth.username }</td>
			</tr>
			<tr>
				<th width="7%">注册时间：</th>
				<td width="93%"><fmt:formatDate value="${info.registerTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr>
				<th width="7%">真实姓名：</th>
				<td width="93%">${info.realName }</td>
			</tr>
			<tr>
				<th width="7%">电话：</th>
				<td width="93%">${auth.phone }</td>
			</tr>
			<tr>
				<th width="7%">邮箱：</th>
				<td width="93%">${auth.email }</td>
			</tr>
			<tr>
				<th width="7%">性别：</th>
				<td width="93%">${info.genderLabel }</td>
			</tr>
			<tr>
				<th width="7%">所在地区：</th>
				<td width="93%">${info.province } ${info.city } ${info.district }</td>
			</tr>
			<tr>
				<th width="7%">街道：</th>
				<td width="93%">${info.street }</td>
			</tr>
			<tr>
				<th width="7%">邮编：</th>
				<td width="93%">${info.postCode }</td>
			</tr>
			<tr>
				<th width="7%">固定电话：</th>
				<td width="93%">${info.tel }</td>
			</tr>
			<tr>
				<th width="7%">QQ号码：</th>
				<td width="93%">${info.QQ }</td>
			</tr>
			<tr>
				<th width="7%">阿里旺旺：</th>
				<td width="93%">${info.aliWangWang }</td>
			</tr>
			<tr>
				<th width="7%">默认收货地址：</th>
				<td width="93%">${defAdd.province }-${defAdd.city }-${defAdd.district }-${defAdd.street }</td>
			</tr>
		</table>
	</div>
		<div class="hyglbox2 lh30 mt30 xianqinidd disnone" id="xianqinidd6">
			<table class="sysCommonTable" cellspacing="0" cellpadding="0">
				<tr>
					<th width="7%">真实姓名：</th>
					<td width="93%">${realUserAuth.realName }</td>
				</tr>
				<tr>
					<th width="7%">身份证号码：</th>
					<td width="93%">${realUserAuth.idCard}</td>
				</tr>
				<tr>
					<th width="7%">身份证到期时间：</th>
					<td width="93%"><c:choose>
						<c:when test="${realUserAuth.perpetualFlag ==true}">长期</c:when>
						<c:otherwise><fmt:formatDate value="${realUserAuth.cardValidity}" pattern="yyyy-MM-dd"/> </c:otherwise>
						</c:choose> </td>
			</tr>
			<tr>
				<th width="7%">身份证正面图</th>
				<td width="93%"><img  src="${realUserAuth.cardFrontImg}"></td>
			</tr>
			<tr>
				<th width="7%">业务员：</th>
				<td width="93%">${addRealUser.realName }</td>
			</tr>
			<tr>
				<th width="7%">上传时间：</th>
				<td width="93%"><fmt:formatDate value="${realUserAuth.addTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
			</tr>
			<tr>
				<th width="7%">审核人：</th>
				<td width="93%">${approve.realName }</td>
			</tr>
			<tr>
				<th width="7%">审核时间：</th>
				<td width="93%"><fmt:formatDate value="${realUserAuth.approveTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
			</tr>
			<c:if test="${realUserAuth.status == 2 }">
				<tr>
				<th width="7%">驳回原因：</th>
				<td width="93%">${realUserAuth.rejectReason }</td>
			</tr>
			</c:if>
		</table>
		</div>
<div class="hyglbox2 lh30 mt30 xianqinidd disnone" id="xianqinidd3">
	<table class="sysCommonTable" cellspacing="0" cellpadding="0">
		<tr>
			<th width="7%">网站直达域名：</th>
			<td width="93%"><a href="http://${store.domain }.zhiguw.com" target="_blank">http://${store.domain }.zhiguw.com</a></td>
		</tr>
		<tr>
			<th width="7%">商铺名称：</th>
			<td width="93%">${store.storeName }</td>
		</tr>
		<tr>
			<th width="7%">商家地址：</th>
			<td width="93%">${store.province } ${store.city } ${store.district } ${store.street }</td>
		</tr>
		<tr>
			<th width="7%">所在商圈：</th>
			<td width="93%">${store.businessAreaLabel }</td>
		</tr>
		<tr>
			<th width="7%">手机号码：</th>
			<td width="93%">${store.phone }</td>
		</tr>
		<tr>
			<th width="7%">联系QQ：</th>
			<td width="93%">${store.QQ }</td>
		</tr>
		<tr>
			<th width="7%">联系旺旺：</th>
			<td width="93%">${store.aliWangWang }</td>
		</tr>
	</table>
</div>
		
	<div class="hyglbox2 lh30 mt30 xianqinidd disnone" id="xianqinidd4"></div>
	<form action="admin/member/detail/acc" id="accPageForm">
		<input type="hidden" value="${memberID }" name="memberID">
	</form>
	<form action="admin/member/detail/order" id="orderPageForm">
		<input type="hidden" value="${memberID }" name="memberID">
		<input type="hidden"  name="userType" id="memberOrderType">
	</form>
	
<script type="text/javascript" language="javascript" src="js/3rdparty/easyui/jquery.easyui.min.js"></script>
<script src="js/admin/shipments.js" type="text/javascript"></script>
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
	var zhigu = {};
}
var flag = 1;
function acc(){
	flag = 4;
	ajaxSubmit("admin/member/detail/acc", "memberID=" +$('#memberID').val(), function(data){
		$("#xianqinidd4").html(data);
	}, "text");
};
function showdis(li,id){
	$(".xiangqing_ul").find('li').removeClass("xiangqing_seclted");
	$(li).addClass("xiangqing_seclted");
	$(".xianqinidd").hide();
	$("#" + id).show();
	if(id=="xianqinidd1"){
		zhigu.memberOrder(1);
		$("#memberOrderType").val(1);
	}else if(id=="xianqinidd5"){
		zhigu.memberOrder(2);
		$("#memberOrderType").val(2);
		$("#xianqinidd1").show();
	}
};
zhigu.memberOrder = function(userType){
	flag = 1;
	ajaxSubmit("admin/member/detail/order", {"memberID":$('#memberID').val(),"userType":userType}, function(data){
		$("#xianqinidd11").html(data);
	}, "text",false);
};
zhigu.pageAjaxSuccess = function(data){
	if(flag == 1)
		$("#xianqinidd1").html(data);
	else if(flag == 4)
		$("#xianqinidd4").html(data);
	init();
};
</script>
</body>
</html>