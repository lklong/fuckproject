<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/default/goods.css">
<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
<title>供应商首页</title>
</head>
<body>
<div class="rightContainer fr">
		<h4 class="ddtitle">供应商中心</h4>
		<div class="gy-userbar">
			<div class="gy-baseinfo fl side-border">
				<a href="javascript:void(0);" class="gy-photo fl mr10 ml10"><img src="${userInfo.avatar}" title="头像" alt="头像" width="65" height="65" /></a>
				<span class="fwb color-red">${store.storeName }</span>
				<p class="mt10">
				<c:if test="${empty userAuth.email}">
					<em class="gy-bind email-no" title="邮箱未绑定"></em>
				</c:if>
				<c:if test="${!empty userAuth.email}">
					<em class="gy-bind email-yes" title="邮箱已绑定"></em>
				</c:if>
				<c:if test="${empty userAuth.phone}">
					<em class="gy-bind phone-no" title="电话未绑定"></em>
				</c:if>
				<c:if test="${!empty userAuth.phone}">
					<em class="gy-bind phone-yes" title="电话已绑定"></em>
				</c:if>	
				</p>
			</div>
			<div class="gy-baseinfo fl side-border">
				<p class="clear"><a href="javascript:void(0)" onclick="refresh()" title="刷新店铺，提升店铺搜索排名" class="default-a">刷新店铺</a></p>
			</div>
			<div class="gy-baseinfo fl color-78">
				<p>今天： ${today } </p>
				<p>上次登录：<fmt:formatDate value="${loginLog.loginDate }" pattern="yyyy-MM-dd HH:mm:ss"/></p>
			</div>
			<div class="gy-userinfo">
				<span>欢迎您，<strong class="color-red">${sessionUser.username }</strong></span>
				<span>
					<c:if test="${userInfo.realUserAuthFlg==1 }">
						<img src="img/user/sfz.jpg" title="已实名认证"/>
					</c:if>
				</span>
				<span class="ml20">可用金额：<strong class="color-red">${account.normalMoney }</strong> 元</span>
				<span class="ml20">冻结金额：<strong class="color-red">${account.freezeMoney }</strong> 元</span>
				<span class="ml20"><a href="user/recharge" class="chongzhi-input-btn">充值</a></span>
			</div>
		</div>
			<h4 class="ddtitle">已卖出商品</h4>
			<div class="dingdan">
					<p>
						<a href="supplier/order?status=1">待付款<strong>(${statusCount.waitPay +0 })</strong></a>
						<a href="supplier/order?status=2">待发货<strong>(${statusCount.waitSend +0 })</strong></a>
						<a href="supplier/order?status=3">待收货<strong>(${statusCount.waitConfirm +0 })</strong></a>
					</p>
			</div>
			<table cellpadding="0" cellspacing="0" class="user-list-table txt-center">
				<tr>
					<th>商品</th>
					<th>价格</th>
					<th>数量</th>
					<th>时间</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${orders }" var="o">
				<tr>
					<td><img width="50" height="50" title="商品" alt="商品" src="${o.details[0].goodsPic}" /></td>
					<td>
						<span>￥<fmt:formatNumber value="${o.payableMenoy }" pattern="#0.00"/> </span>
						<span>(含代发、运费<strong class="ff5200 fwryh">￥<fmt:formatNumber value="${o.agentMoney + o.logisticsMoney }" pattern="#0.00"/></span>
					</td>
					<td>共${o.styleNum }款，合计${o.quantity }件</td>
					<td><fmt:formatDate value="${o.orderTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${o.statusLabel }</td>
					<td><a class="edit-user-photo" href="supplier/order/detail?orderID=${o.ID}">查看详情</a></td>
				</tr>
				</c:forEach>
			</table>
</div>
<script type="text/javascript">
function refresh(storeId){
	ajaxSubmit("supplier/store/refresh", {}, function(msgBean){
		if(msgBean.code==zhigu.code.success){
			layer.alert(msgBean.msg);
		}else{
			layer.alert(msgBean.msg);
		}
	});
}
</script>
</body>
</html>
