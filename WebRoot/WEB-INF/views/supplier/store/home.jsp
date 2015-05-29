<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>供应商首页</title>
</head>

<body>
<div class="rightContainer fr">
		<h4 class="ddtitle">供应商中心</h4>
		<table cellpadding="0" cellspacing="0" class="user-form-table">
				<tr>
					<td><img src="${userInfo.avatar}" title="头像" alt="头像" width="80" height="80" /></td>
					<td></td>
				</tr>
				<tr>
					<td>店铺名称：</td>
					<td>${store.storeName }
					<a href="javascript:void(0)" onclick="refresh()" title="刷新店铺，提升店铺搜索排名" class="default-a">刷新店铺</a></td>
				</tr>
				<tr>
					<td>欢迎您，${sessionUser.username }</td>
					<td><c:if test="${userInfo.realUserAuthFlg==1 }">
								<img src="img/sfz.jpg" title="已实名认证"/>
							</c:if></td>
				</tr>
				<tr>
					<td>今天： ${today } </td>
					<td>上次登录：<fmt:formatDate value="${loginLog.loginDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
				<tr>
					<td>可用金额：</td>
					<td><span>￥${account.normalMoney }元</span></td>
				</tr>
				<tr>
					<td>冻结金额：</td>
					<td><span>￥${account.freezeMoney }</span></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><a href="user/recharge" class="default-a">充值</a></td>
				</tr>
				<tr>
					<td colspan="2"><div class="contact">
					<div>
						<c:if test="${empty userAuth.phone}">
							<img src="img/tel.png" title="电话未绑定" alt="电话未绑定" />
						</c:if>
						<c:if test="${!empty userAuth.phone}">
							<img src="img/telhong.png" title="${userAuth.phone}" alt="电话已绑定" />
						</c:if>

						<c:if test="${empty userAuth.email}">
							<img src="img/mail.png" title="邮箱未绑定" alt="邮箱未绑定" />
						</c:if>
						<c:if test="${!empty userAuth.email}">
							<img src="img/mailhong.png" title="${userAuth.email}" alt="邮箱已绑定" />
						</c:if>
					</div>
				</div></td>
				</tr>
			</table>
			<h4 class="ddtitle">已卖出商品</h4>
			<div class="dingdan">

					
					<p>
						<a href="supplier/order?status=1">待付款<strong>(${statusCount.waitPay +0 })</strong></a>
						<a href="supplier/order?status=2">待发货<strong>(${statusCount.waitSend +0 })</strong></a>
						<a href="supplier/order?status=3">待收货<strong>(${statusCount.waitConfirm +0 })</strong></a>
					</p>

				</div>

			<table cellpadding="0" cellspacing="0" class="user-list-table">
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
					<td><a class="default-a" href="supplier/order/detail?orderID=${o.ID}">查看详情</a></td>
				</tr>
				</c:forEach>
			</table>
</div>
<script type="text/javascript">
function refresh(storeId){
	ajaxSubmit("supplier/store/refresh", {}, function(msgBean){
		if(msgBean.code==zhigu.code.success){
			layer.msg(msgBean.msg);
		}else{
			layer.alert(msgBean.msg);
		}
	});
}
</script>
</body>
</html>
