<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link href="css/default/user.css" rel="stylesheet">
<script type="text/javascript" src="js/3rdparty/layer/layer.min.js"></script>
<title>订单确认</title>
</head>
<body>
	<div class="shopping-cart-body">
		<jsp:include page="address.jsp"></jsp:include>
		<h4 class="ddtitle">商品清单</h4>
			<table cellpadding="0" cellspacing="0" class="shopping-cart-table">
				<tr>
					<th style="width: 50%">商品</th>
					<th style="width: 15%">规格</th>
					<th style="width: 15%">价格(元)</th>
					<th style="width: 10%">数量</th>
					<th style="width: 10%">小计</th>
				</tr>

				<!-- 购物车（每个商家一条） -->
				<c:forEach items="${shoppingCarts }" var="sc" varStatus="scStatus">
					<tr class="js-store-order" data-store-id="${sc.storeId }" data-weight="${sc.weight }" data-store-goods-money="${sc.storeGoodsMoneyTotal }">
						<td colspan="5"><div class="shop-list-head">
								<span class="fl">店铺：<a class="c666" href="store/index?storeId=${sc.storeId }">${sc.storeName }</a></span> <span class="fl ml30"> <c:if
										test="${not empty sc.QQ }">
										<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${sc.QQ }&site=qq&menu=yes"> <img
											style="margin-bottom: -6px; margin-left: 5px;" border="0" src="http://wpa.qq.com/pa?p=2:${sc.QQ}:52" alt="点这里给我发消息" />
										</a>
									</c:if> <c:if test="${not empty sc.aliWangWang }">
										<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${sc.aliWangWang}&site=cntaobao&s=2&charset=utf-8"> <img
											style="margin-bottom: -2px; margin-left: 5px;" border="0"
											src="http://amos.im.alisoft.com/online.aw?v=2&uid=${sc.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" />
										</a>
									</c:if>
								</span>
							</div> <c:forEach items="${sc.item }" var="item" varStatus="itemStatus">
								<table cellpadding="0" cellspacing="0" class="shopping-list-table no-border-margin">
									<tr>
										<td style="width: 50%"><span class="fl ml20"> <img height="50" height="50" src="${item.goods.image300}" />
										</span> <span class="fl ml10 mt15"> <a class="c666" title="${item.goods.name }" href="goods/detail?goodsId=${item.goods.id }"
												target="_blank">${item.goods.name }</a>
										</span></td>
										<td style="width: 15%">${empty item.goodsSku.propertyStrName?'-':item.goodsSku.propertyStrName }</td>
										<td style="width: 15%"><fmt:formatNumber pattern="#0.00" value="${item.goodsSku.price }" /></td>
										<td style="width: 10%" class="js-quantity">${item.quantity }</td>
										<td style="width: 10%">¥ <fmt:formatNumber pattern="#0.00" value="${item.subTotal }" /></td>
									</tr>
								</table>
							</c:forEach>
							<!-- 订单费用计算 -->
							<div class="tablefooter no-border-margin">
								<div class="xline">
										<span class="fr">商品小计：<font class="fwb color-red fz14">￥ <fmt:formatNumber pattern="#0.00" value="${sc.storeGoodsMoneyTotal }" /></font></span>
								</div>
								<div class="xline">
									<span class="fl mt5 mr10">给卖家留言：</span>
									<span class="fl mr10"><input class="input-txt" type="text" placeholder="可以告诉卖家您的特殊要求" name="leavelMessage" maxlength="200" /></span>
									<span class="fl mt5 mr10">代发商：</span>
									<span class="fl mr10"><select name="agentSellerId" onchange="countMoney()" class="select-txt">
										<c:forEach items="${agentUsers}" var="agentUser">
											<option value="${agentUser.userId}" data-agentmoney="${agentUser.agentMoney}">${agentUser.agentName}</option>
										</c:forEach>
										</select>
									</span>
									<span class="fl mt5 mr10">配送方式：</span>
									<span class="fl mr10">
									<select name="logisticsId" onchange="countMoney()" class="select-txt">
										<option value=''>-请选择-</option>
										<c:forEach items="${logistics }" var="l">
											<option value="${l.id }" data-fweight="${l.fweight }" data-fmoney="${l.fmoney }" data-cmoney="${l.cmoney }">${l.name }</option>
										</c:forEach>
									</select>
									</span>
								</div>
								<div class="xline fr">
									<div class="fl order-money ml20">
										<h4>代发费:</h4>
										<div id="">
											<strong>￥</strong><strong id="" class="color-red"> 0.00 </strong>
										</div>
									</div>
									<div class="fl order-money ml20">
										<h4>运费详情</h4>
										<div id="">
											<strong>￥</strong><strong id="" class="color-red"> 0.00 </strong>
										</div>
									</div>
									<div class="fl order-money ml20">
										<h4>订单金额：</h4>
										<div id="">
											<strong>¥</strong><strong id="" class="color-red fz14"> 0.00 </strong>
										</div>
									</div>
								</div>
								<br style="clear:both"/>
							</div>
							</td>
					</tr>
				</c:forEach>
			</table>

			<div class="msg-alert" style="padding: 30px 0;">
				<span class="gantanhao"></span>
				<div class="fr ml30">
					<span>应付总计：</span> <strong>¥</strong> <strong id="allMoney" class="color-red fz16"></strong> ( 元 )
				</div>
				<div class="fr ml30">
					<span>配送至：</span> <span id="addressLabel"></span>
				</div>
				<div class="fr ml30">
					<span>收货人：</span> <span id="consigneeLabel"></span>
				</div>
			</div>
			<div class="shop-list-head">
				<div class="fr ml30">
					<a href="/user/cart" class="default-a">返回进货车</a> <input class="input-button" type="button" onclick="return _submit()" value="提交订单" />
				</div>
			</div>
	</div>
	<script type="text/javascript">
	$().ready(function() {
		countMoney();
	});
	function _submit() {
		var addressId = $("#addressID").val();
		if (!addressId) {
			layer.msg('请填写收获地址！', 1, -1);
			return false;
		}
		var orderParam = {};
		orderParam.addressId = addressId;
		var i=0;
		$(".js-store-order").each(function(index) {
			var order = {};
			orderParam["orders["+i+"]"]=order;
			
			var $storeOrder = $(this);
			order.leavelMessage = $storeOder.find("input[name='leavelMessage']").val();
			order.logistics = $storeOder.find("select[name='logisticsId']").val();
			order.agentSellerID = $storeOder.find("select[name='agentSellerId']").val();
			i++;
		});
		$.layer({
			shade: [0.5, '#000'],
			area: ['auto', 'auto'],
			dialog: {
				msg: '确认提交订单？',
				btns: 2,
				type: 4,
				btn: ['确认', '取消'],
				yes: function() {
					_sub();
				}
			}
		});
		function _sub() {
			$.post("/user/order/confirm", orderParam,
				function(msgBean) {
					if (msgBean.code == zhigu.code.success) {
						var orderNos = msgBean.data;
						var params = "";
						for (var i = 0; i < orderNos.length; i++) {
							if (i > 0) params += "&";
							params += "orderNo=" + orderNos[i];
						}
						window.location.href = "/user/order/pay?" + params;
					} else {
						layer.alert(msgBean.msg);
					}
				}
			)
		}
	}
	//统计金额（运费+代发费）
	function countMoney() {
		var allMoney = 0;
		$(".js-store-order").each(function(index) {
			var $storeOrder = $(this);
			var storeOrderMoney = $storeOrder.data("store-goods-money");
			var storeId = $storeOrder.data("store-id");
			var weight = $storeOrder.data("weight");
			// =======运费 start============
			var logisticsMoney = 0;
			//首重价格
			var $logistics = $storeOrder.find("select[name='logisticsId']");
			var logisticsShowHtml = '<font color="red">请选择配送方式</font>';
			var addressId = $("#addressID").val();
			if (!addressId) {
				logisticsShowHtml = '<font color="red">请选择收货地址</font>';
			}
			var logisticsId = $logistics.val();
			if (logisticsId && addressId) {
				if (logisticsId == 1) {
					logisticsShowHtml = '<font color="red">物流运输费拿货时支付</font>';
				} else {
					if (weight > 0) {
						$.post("/user/order/getLogisticsMoney", {
							"addressId": addressId,
							"logisticsId": logisticsId,
							"weight": weight
						},
						function(msgBean) {
							if (msgBean.code == zhigu.code.success) {
								var logisticsDto = msgBean.data;
								logisticsMoney = logisticsDto.logisticsMoney;
								logisticsShowHtml = "<div class='fl'>运费： <span class='cff5200'>￥</span><span class='cff5200'>" + logisticsMoney + "元</span></div>";
								logisticsShowHtml += "--------------------";
								logisticsShowHtml += "<div class='fl'>重量： " + weight + " kg</div>";
								logisticsShowHtml += "<h4 class='fl c333'>运费费率：</h4>";
								logisticsShowHtml += "<div class='fl'>首重 " + logisticsDto.fmoney + "元/" + logisticsDto.fweight + "kg</div>";
								logisticsShowHtml += "<div class='fl'>续重 " + logisticsDto.cmoney + "元/" + logisticsDto.cweight + "kg</div>";
							}else{
								logisticsShowHtml = msgBean.msg;
							}
						});
					}
				}
			} 
// 			$("#logisticsDiv" + index).html(logisticsShowHtml);
// 			// =======运费 end============
// 			//代发费
// 			var $proxy = $("#oagent" + index + " option:selected");
// 			var amountTotal = 0;
// 			$storeOrder.find(".js-quantity").each(function() {
// 				amountTotal = zhigu.cmn.arith(amountTotal, "+", $(this).html());
// 			});
// 			var oneProxyMoney = $proxy.data("agentmoney");
// 			var proxymoney = zhigu.cmn.arith(oneProxyMoney, "*", amountTotal);
// 			$(".waitSendMoney" + index).html(proxymoney);

// 			//商品价格、优惠
// 			var orderGoodsMoney = $(this).data("goodsmoney");
// 			//订单价格
// 			var orderMoney = zhigu.cmn.arith(zhigu.cmn.arith(proxymoney, '+', logisticsMoney), '+', orderGoodsMoney);
// 			$(".ordermoney" + index).html(storeOrderMoney);
// 			allMoney = zhigu.cmn.arith(allMoney, '+', storeOrderMoney);
		});
		$("#allMoney").html(allMoney);
	}
	</script>
</body>
</html>