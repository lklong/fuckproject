<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>订单支付</title>
<link href="css/default/user.css" rel="stylesheet">
<link href="css/default/goods.css" rel="stylesheet">
<script type="text/javascript" src="/js/3rdparty/layer1.9/layer.js"></script>
</head>
<body>
	<div class="urpMiddleBox">
		<div class="urpTopTip">
			<div>
				<h1>您正在使用同城货源平台付款</h1>
			</div>
		</div>
		<div style="padding: 20px;">
			<table cellpadding="0" cellspacing="0" class="user-list-table txt-center">
				<tr>
					<th>订单号</th>
					<th>商家</th>
					<th class="no-right-border">金额</th>
				</tr>
				<c:forEach items="${orders }" var="od">
					<tr>
						<td>${od.orderNO }</td>
						<td>${od.storeName }</td>
						<td><fmt:formatNumber pattern="#0.00" value="${od.payableMenoy}" />元</td>
					</tr>
				</c:forEach>
			</table>
			<form action="user/order/pay/submit" method="post" id="paySubmintForm">
			<table cellpadding="0" cellspacing="0" class="user-form-table">
				<tr>
					<td style="width: 10%">收货地址：</td>
					<td style="width: 90%">${orders[0].address }&nbsp;&nbsp;&nbsp;<strong class="color-red">${orders[0].consignee }</strong>
						收&nbsp;&nbsp;&nbsp;${orders[0].phone }
					</td>
				</tr>
				<tr>
					<td>应付金额：</td>
					<td><strong class="color-red">${totalPayMoney}</strong> 元</td>
				</tr>
				<tr>
					<td>您的账户余额：</td>
					<td><strong class="color-red"><fmt:formatNumber pattern="#0.00" value="${acc.normalMoney }" /></strong> 元 <input type="hidden"
						id="accountMoney" value="${acc.normalMoney }"> <input type="hidden" id="totalPayMoney" value="${totalPayMoney }"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><a href="user/recharge" target="_blank" class="default-a">充值</a></td>
				</tr>
				<tr>
					<td>支付:</td>
					<td><strong class="color-red fz14"><fmt:formatNumber pattern="#0.00" value="${totalPayMoney }" /></strong> 元</td>
				</tr>
				<tr>
					<td>支付密码:</td>
					<td><input class="input-txt" type="password" name="payPasswd" id="payPasswd" autocomplete="off" /> <a class="color-red"
						href="user/security/paymentpwd" target="_blank">没有支付密码？</a> <c:forEach items="${orders }" var="o">
							<input type="hidden" name="orderNo" value="${o.orderNO}">
						</c:forEach></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="hidden" name="key" value="${key}"> <input class="input-button" onclick="_submit()" type="button" value="确认支付" /> <input
						type="text" style="display: none" value="此处的input删掉然后回车按钮就会触发提交" /></td>
				</tr>
			</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">
	$().ready(function() {
		var msg = "${msg}";
		if (msg != "") {
			layer.alert(msg);
		}
	});
	function _submit() {
		var payPasswd = $("#payPasswd").val();
		var totalMoney = $("#accountMoney").val();
		var orderMoney = $("#totalPayMoney").val();
		if (!payPasswd) {
			layer.alert("请输入支付密码", -1);
			return false;
		}
		if (parseFloat(orderMoney) > parseFloat(totalMoney)) {
			layer.alert("帐户余额不足，请充值", -1);
			return false;
		}
		$("#payPasswd").val(zhigu.encodeBase64(payPasswd));
		layer.load(2);
		$("#paySubmintForm").submit();
	}
	</script>
</body>
</html>