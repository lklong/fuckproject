<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link href="css/default/user.css" rel="stylesheet">
<script type="text/javascript" src="/js/3rdparty/layer1.9/layer.js"></script>
<script type="text/javascript" src="/js/pca.js"></script>
<title>订单确认</title>
</head>
<body>
	<div class="shopping-cart-body">
		<!-- 收货地址 start-->
		<h4 class="ddtitle">
			<span class="">收货信息</span> <a class="default-a fr" href="javascript:void(0)" onclick="newAddress()"> + 添加新地址 </a> 
			<a class="default-a fr" href="javascript:void(0)" onclick="addrShow(this)" data-flag="false" id="addrShowBtn">显示全部收货地址</a>
		</h4>
		<table cellpadding="0" cellspacing="0" class="user-form-table fz12" id="addressTable">
<%-- 			<c:forEach items="${addresses }" var="addr" > --%>
<%-- 				<tr data-address-id="${addr.id}"  class="user-form-table <c:if test="${addr.defaultFlag}"> js-addr-default</c:if> <c:if test="${!addr.defaultFlag}"> hidden</c:if>"> --%>
<%-- 					<td style="width: 10%" class="js-addr-consignee">${addr.name }</td> --%>
<%-- 					<td style="width: 20%" class="js-addr-phone">${addr.phone }</td> --%>
<%-- 					<td style="width: 40%" class="js-addr-detail">${addr.province } ${addr.city } ${addr.district } ${addr.street }</td> --%>
<!-- 					<td style="width: 30%"> -->
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${addr.defaultFlag }"> --%>
<!-- 								<span>默认地址</span> -->
<%-- 								<span><a class="default-a" href="javascript:void(0);" onclick="addrUpdate(${addr.id})">修改 </a></span> --%>
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<%-- 								<a class="default-a" href="javascript:void(0);" onclick="setAddrDefault(${addr.id})">设为默认地址</a>  --%>
<%-- 								<a class="default-a" href="javascript:void(0);" onclick="addrUpdate(${addr.id})">修改</a> <a class="default-a" href="javascript:void(0);" onclick="deleteAddr(${addr.id})">删除</a> --%>
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
<!-- 					</td> -->
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
		</table>
		<!-- 收货地址 end-->

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
									<span class="fl mr10">
										<select name="agentSellerId" onchange="countMoney()" class="select-txt">
											<c:forEach items="${agentUsers}" var="agentUser">
												<option value="${agentUser.userId}" data-agent-money="${agentUser.agentMoney}">${agentUser.agentName}</option>
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
										<div>
											<strong  class="color-red js-agent-money fz14"> 0.00 </strong><span> 元</span>
										</div>
									</div>
									<div class="fl order-money ml20">
										<h4>运费详情</h4>
										<div>
											<strong  class="js-logistics-money"> 0.00 </strong>
										</div>
									</div>
									<div class="fl order-money ml20">
										<h4>订单金额：</h4>
										<div>
											<strong  class="color-red fz14 js-order-money"> 0.00 </strong><span> 元</span>
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
	if (typeof zhigu == "undefined" || !zhigu) {
		var zhigu = {};
	}
	function loadAddress(){
		var showClass = $("#addrShowBtn").data("flag")?"":" hidden";
		$.get("/user/address/userAllAddress",function(msgBean){
			if(msgBean.code==zhigu.code.success){
				var addrs = msgBean.data;
				var html = "";
				for(var i=0;i<addrs.length;i++){
					var addr = addrs[i];
					html +="<tr data-address-id='"+addr.id+"'  class='user-form-table "+ (addr.defaultFlag?" js-addr-default":showClass)+"'>";
					html +="<td style='width: 10%' class='js-addr-consignee'>"+addr.name +"</td>";
					html +="<td style='width: 20%' class='js-addr-phone'>"+addr.phone+"</td>";
					html +="<td style='width: 40%' class='js-addr-detail'>"+addr.province + addr.city+addr.district+addr.street+"</td>";
					html +="<td style='width: 30%'>";
					if(addr.defaultFlag){
						html += "<span>默认地址</span><span><a class='default-a' href='javascript:void(0);' onclick='addrUpdate("+addr.id+")'>修改 </a></span>";
					}else{
						html += "<a class='default-a' href='javascript:void(0);' onclick='setAddrDefault("+addr.id+")'>设为默认地址</a>";
						html += "<a class='default-a' href='javascript:void(0);' onclick='addrUpdate("+addr.id+")'>修改</a> <a class='default-a' href='javascript:void(0);' onclick='deleteAddr("+addr.id+")'>删除</a>";
					}
					html +="</td></tr>";
				}
				$("#addressTable").html(html);
				var $chooseAddr = $("#addressTable .js-addr-default");
				if($chooseAddr.length>0){
					$("#addressLabel").html($chooseAddr.find(".js-addr-detail").html());
					$("#consigneeLabel").html($chooseAddr.find(".js-addr-consignee").html()+"  "+$chooseAddr.find(".js-addr-phone").html());
				}
				countMoney();
			}else{
				layer.alert(msgBean.msg);
			}
		})
	}
	// 收货地址 START
	//添加收获地址
	function newAddress(){
		$.get("/user/address/dialog", function(data){
			layer.open({
				type:1,
				title: '添加收货地址',
				area: ['600px', '500px'],
				content:data
			});
		}, "text");
	}
	//修改地址
	function addrUpdate(addressId){
		$.post("user/address/dialog", {"addressId":addressId}, function(data){
			layer.open({
				type:1,
				title: '修改收货地址',
				area: ['600px', '500px'],
				content:data
			});
		}, "text")
	}
	//设置默认
	function setAddrDefault(addressId){
		$.post("user/address/default", {"addressId" : addressId}, function(msgBean){
			if(msgBean.code == zhigu.code.success){
				loadAddress();
				layer.msg(msgBean.msg);
			}else{
				layer.alert(msgBean.msg);
			}
		},"json");
	}
	//删除收货地址
	function deleteAddr(addressId){
		layer.confirm('确认要删除收货地址？',function(index){
			$.post("user/address/del", {"addressId" : addressId}, function(msgBean){
				if(msgBean.code == zhigu.code.success){
					loadAddress();
					layer.msg(msgBean.msg);
				}else{
					layer.alert(msgBean.msg);
				}
			});
		});
	}
	//显示、隐藏
	function addrShow(obj){
		var flag = $(obj).data("flag");
		if(!flag){//展开
			$(obj).data("flag",true);
			$(obj).html("隐藏");
			$("#addressTable tr").show();
		}else{
			$(obj).data("flag",false);
			$(obj).html("显示全部收货地址");
			$("#addressTable tr").hide();
			$("#addressTable .js-addr-default").show();
		}
	}
	// 收货地址 END
	
	$(function(){
		loadAddress();
	});
	
	function _submit() {
		var okFlag = true;
		var orderParam = {};
		orderParam.addressId = $("#addressTable .js-addr-default").data("address-id");
		if (!orderParam.addressId) {
			layer.msg("请填写收获地址！");
			return false;
		}
		var i=0;
		var orderArray = new Array();
		$(".js-store-order").each(function(index) {
			var $storeOrder = $(this);
			var order  = {};
			order.storeID = $storeOrder.data("store-id");
			order.leavelMessage = $storeOrder.find("input[name='leavelMessage']").val();
			order.logistics = $storeOrder.find("select[name='logisticsId']").val();
			if(!order.logistics){
				layer.alert("请选择配送方式");
				okFlag = false;
				return false;
			}
			order.agentSellerID = $storeOrder.find("select[name='agentSellerId']").val();
			orderArray.push(order);
			i++;
		});
		orderParam.ordersJson = zhigu.objToJson(orderArray);
		if(!okFlag)return;
		layer.confirm('确认提交订单？',{
				btn: ['确认', '取消'],
			}, function() {
				_sub();
			}
		);
		function _sub() {
			var loadIndex = layer.load(2,{time: 10*1000});
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
					layer.close(loadIndex);
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
			var $logisticsSelect = $storeOrder.find("select[name='logisticsId']");
			var logisticsShowHtml = '<font class="color-red">请选择配送方式</font>';
			var addressId = $("#addressTable .js-addr-default").data("address-id");
			if (!addressId) {
				logisticsShowHtml = '<font class="color-red">请选择收货地址</font>';
			}
			var logisticsId = $logisticsSelect.val();
			if (logisticsId && addressId) {
				if (logisticsId == 1) {
					logisticsShowHtml = '<font class="color-red">物流运输费拿货时支付</font>';
				} else {
					if (weight > 0) {
						$.ajax({
							url:"/user/order/getLogisticsMoney", 
							data:{
								"addressId": addressId,
								"logisticsId": logisticsId,
								"weight": weight
							},
							dataType: "json",
							async:false,
							success:function(msgBean) {
								if (msgBean.code == zhigu.code.success) {
									var logisticsDto = msgBean.data;
									logisticsMoney = logisticsDto.logisticsMoney;
									logisticsShowHtml = "<div><span class='color-78'>运费：</span><span class='color-red fz14'>" + logisticsMoney + "</span><span> 元</span></div>";
									logisticsShowHtml += "<div><span class='color-78'>重量： </span><span class='color-red'>" + weight + " kg</span></div>";
									logisticsShowHtml += "<br />";
									logisticsShowHtml += "<h4>运费费率：</h4>";
									logisticsShowHtml += "<div><span class='color-78'>首重： </span> " + logisticsDto.fmoney + "元/" + logisticsDto.fweight + "kg</div>";
									logisticsShowHtml += "<div><span class='color-78'>续重 ： </span>" + logisticsDto.cmoney + "元/" + logisticsDto.cweight + "kg</div>";
								}else{
									logisticsShowHtml = msgBean.msg;
								}
							}
						});
					}
				}
			} 
			$storeOrder.find(".js-logistics-money").html(logisticsShowHtml);
			// =======运费 end============
			//代发费
			var $proxy = $storeOrder.find("select[name='agentSellerId'] option:selected");
			var amountTotal = 0;
			$storeOrder.find(".js-quantity").each(function() {
				amountTotal = zhigu.cmn.arith(amountTotal, "+", $(this).html());
			});
			var oneProxyMoney = $proxy.data("agent-money");
			var proxymoney = zhigu.cmn.arith(oneProxyMoney, "*", amountTotal);
			$storeOrder.find(".js-agent-money").html(proxymoney);
			// 店铺订单费
			storeOrderMoney = zhigu.cmn.arith(storeOrderMoney, '+', zhigu.cmn.arith(logisticsMoney, '+', proxymoney));
			$storeOrder.find(".js-order-money").html(storeOrderMoney);
			
			
			allMoney = zhigu.cmn.arith(allMoney, '+', storeOrderMoney);
		});
		$("#allMoney").html(allMoney);
	}
	</script>
</body>
</html>