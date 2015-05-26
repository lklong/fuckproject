<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/jinhuoche.css" rel="stylesheet" type="text/css" />
<title>订单确认</title>
</head>
<body>
<div style="height:54px;"></div>
<div class="webpage">
		<div class="shouhuoxinxi mt10" id="address">
			<jsp:include page="address.jsp"></jsp:include>
		</div>
		<div class="shouhuoxinxi mt10">
			<div class="xinxileft fl c666 fwbold f14 pt20 pl20">
				货品信息
				<span></span>
			</div>
			<div class="xinxiright fl mt10 c666">
				<form action="user/order/submit" method="post" id="orderSubmitForm">
					<table class="ml20" >
						<tr class="xinxirightth">
							<th width="500">货品</th>
							<th width="200">规格</th>
							<th width="120">价格(元)</th>
							<th width="100">数量</th>
							<th width="120">小计 </th>
						</tr>
						<!-- 购物车（每个商家一条） -->
						<c:forEach items="${shoppingCarts }" var="sc" varStatus="scStatus">
							<tr  class="orderNum" data-storeID="${sc.storeId }" data-weight="${sc.weight }" data-goodsmoney="${sc.storeTotal }">
								<td class="xinxiname pt10" colspan="5">
									<div class="fl pl20">
										<div class="c666 fl">店铺：<a class="c666" href="store/index?storeId=${sc.storeId }">${sc.storeName }</a></div>
										<div class="qqicons fl ml10">
											  <c:if test="${not empty sc.QQ }">
											  	<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${sc.QQ }&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${sc.QQ}:52" alt="点这里给我发消息" /></a>
											  </c:if>
											 	<c:if test="${not empty sc.aliWangWang }">
											  	<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${sc.aliWangWang}&site=cntaobao&s=2&charset=utf-8" ><img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid=${sc.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a>
											 	</c:if>
										</div>
										<div class="clear"></div>
									</div>
									<div class="clear"></div>
								</td>
							</tr>
							<c:forEach items="${sc.item }" var="item" varStatus="itemStatus">
								<tr class="dingdan1box">
									<td class="dingdan1">
										<div class="dingdanimg ml20 mr20 fl">
											<img src="${item.goods.image300}" />
										</div>
										<div class="dingdanmiaoshu fl">
											<a class="c666" title="${item.goods.name }" href="goods/detail?goodsId=${item.goods.id }" target="_blank">${item.goods.name }</a>
										</div>
										<div class="clear"></div>
									</td>
									<td>${empty item.goodsSku.propertyStrName?'-':item.goodsSku.propertyStrName }</td>
									<td class="cff5200">
										<fmt:formatNumber pattern="#0.00" value="${item.goodsSku.price }" />
									</td>
									<td class="quantity-${sc.storeId }">${item.quantity }</td>
									<td class="cff5200">
										¥ <fmt:formatNumber pattern="#0.00" value="${item.subTotal }" />
									</td>
								</tr>
							</c:forEach>
							<tr class="tablefooter">
								<td colspan="6">
									<div class="xline">
										<span>给卖家留言：</span>
										<input type="text" placeholder="可以告诉卖家您的特殊要求" name="orders[${scStatus.index }].leavelMessage" maxlength="200"/>
									</div>
										<div class="xline">
											<span>代发商：</span>
											<select name="orders[${scStatus.index }].agentSellerID" onchange="countMoney()" id="oagent${scStatus.index }" style="min-width: 80px;">
												<c:forEach items="${agentUsers}" var="agentUser">
													<option value="${agentUser.userId}" data-agentmoney="${agentUser.agentMoney}">${agentUser.agentName}</option>
												</c:forEach>
											</select>
										</div>
										<div class="xline" >
											<span>配送方式：</span>
											<select name="orders[${scStatus.index }].logistics" id="logistics${scStatus.index }" onchange="countMoney()" class="js-logistics">
												<option value=''>-请选择-</option>
												<c:forEach items="${logistics }" var="l" >
													  <option value="${l.id }" data-fweight="${l.fweight }" data-fmoney="${l.fmoney }" data-cmoney="${l.cmoney }">${l.name }</option>
												</c:forEach>
											</select>
											<input type="hidden" name="orders[${scStatus.index }].storeID" value="${sc.storeId }">
										</div>
										<div  class="xline fr"><font class="fr" >￥<fmt:formatNumber pattern="#0.00" value="${sc.storeTotal }" /></font></div>
										<div class="yunfei fr mr20">
											<ul>
												<li class="fl dafali">
													<div>待发详情</div>
													<div class="xiangqingbox1 p10">
														代发费:<span class="cff5200">￥</span><span class="cff5200 waitSendMoney${scStatus.index }"></span>
													</div>
												</li>
												<li class="yunfeixiangqing fl">
													<div>运费详情<span></span></div>
													<div class="xiangqingbox p10" id="logisticsDiv${scStatus.index }">
														
													</div>
												</li>
											</ul>
											<div class="clear"></div>
										</div>
									<div class="clear"></div>
									<div class="dingdanjine">
										<div class="fr">
											<span>订单金额：</span>
											<strong>¥</strong>
											<strong class="mr20 ordermoney ordermoney${scStatus.index }" style="color:#ff4400">0.00</strong>
										</div>
										<div class="clear"></div>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
					<div class="dingdanfooter fr pr10 mt20">
						<div class="dingdanfooter1 fr mt10">
								<h4 class="fl c999">应付总计：</h4>
								<strong >¥</strong>
								<strong  id="totalMoney" style="color:#ff4400">${totalMoney }</strong> ( 元 )
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
						<div>
						
						</div>
						<div class="fr">
							<p class="fl c999">配送至：</p>
							<p class="fl">
								<span id="addressLabel"></span>
							</p>
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
						<div class="fr">
							<p class="fl c999">收货人：</p>
							<p class="fl">
								<span id="consigneeLabel"></span>
							</p>
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
					<div class="dingdansub fr mr20 mt10">
						<p class="fl"><a href="user/cart">返回进货车</a></p>
						<input class="fl ml10 cp" type="button" onclick="return _submit()" value="提交订单" />
						<div class="clear"></div>
					</div>
					<input type="hidden" name="addressID" id="addressID">
				</form>
			</div>
			<div class="clear"></div>
		</div>
		<div class="xintiandizhibg" id="xinaddr"></div>
	</div>
<script type="text/javascript">
	$().ready(function(){
		countMoney();
	});
	function _submit(){
		var address = $("#addressID").val();
		if(!address){
			layer.msg('请填写收获地址！', 1, -1);
			return false;
		}
		var errorMsg = "";
		$(".js-logistics").each(function(){
			if(!$(this).val()){
				errorMsg = "请选择配送方式";
				return false;
			}
		});
		if(errorMsg){
			layer.alert(errorMsg);
			return false;
		}
		$.layer({
		    shade: [0.5,'#000'],
		    area: ['auto','auto'],
		    dialog: {
		        msg: '确认提交订单？',
		        btns: 2,                    
		        type: 4,
		        btn: ['确认','取消'],
		        yes: function(){
		        	_sub();
		        }
		    }
		});
		function _sub(){
			ajaxSubmit($("#orderSubmitForm").attr("action"),$("#orderSubmitForm").serialize(), function(msgBean){
				if(msgBean.code==zhigu.code.success){
					var orderNos = msgBean.data; 
					var params = "";
					for(var i = 0 ;i < orderNos.length;i++){
						if(i>0)params+="&";
						params+="orderNo="+orderNos[i];
					}
					window.location.href="/user/order/pay?"+params;
				}else{
					layer.alert(msgBean.msg);
				}
			}, "json");
		}
	}
	//统计金额（运费+代发费）
	function countMoney(){
		var totalMoney = 0;
		$(".orderNum").each(function(index){
			var storeID = $(this).attr("data-storeID");
			// =======运费 start============
			var logisticsMoney = 0;
			//首重价格
			var $logistics = $("#logistics" + index + " option:selected");
			var logisticsShowHtml ='<font color="red">请选择配送方式</font>';
			
			var logisticsId = $logistics.val();
			if(logisticsId){
				if(logisticsId==1){
					logisticsShowHtml = '<font color="red">物流运输费拿货时支付</font>';
				}else{
					var fMoney = $logistics.attr("data-fmoney");
					$("#fMoney" + index).html(fMoney);
					//续重价格
					var cMoney = $logistics.attr("data-cmoney");
					$("#cMoney" + index).html(cMoney);
					//重量
					var weight = parseFloat($(this).data("weight"));
					zhigu.log("重量",weight);
					weight = isNaN(weight) ? 0 : weight;
					var fweight = $logistics.data("fweight");
					if(weight>0){
// 						if(weight > fweight){
// 							logisticsMoney = zhigu.cmn.arith(fMoney ,'+', zhigu.cmn.arith(Math.ceil(zhigu.cmn.arith(weight,'-',fweight)) ,'*', cMoney));
// 						}else{
// 							logisticsMoney = fMoney;
// 						}
						$.ajax({
							url:"/user/order/getLogisticsMoney",
							data:{addressId:$("#addressID").val(),logisticsId:logisticsId,weight:weight},
							dataType:"json",
							async:false,
							success:function(msgBean){
								if(msgBean.code==zhigu.code.success){
									var logisticsDto = msgBean.data;
									logisticsMoney = logisticsDto.logisticsMoney;
									logisticsShowHtml = "<div class='fl'>运费： <span class='cff5200'>￥</span><span class='cff5200'>"+logisticsMoney+"元</span></div>";
									logisticsShowHtml += "--------------------";
									logisticsShowHtml += "<div class='fl'>重量： "+weight+" kg</div>";
									logisticsShowHtml += "<h4 class='fl c333'>运费费率：</h4>";
									logisticsShowHtml += "<div class='fl'>首重 "+logisticsDto.fmoney+"元/"+logisticsDto.fweight+"kg</div>";
									logisticsShowHtml += "<div class='fl'>续重 "+logisticsDto.cmoney+"元/"+logisticsDto.cweight+"kg</div>";
								}
							}
						});
					}
					
				}
			}else{
				
			}
			$("#logisticsDiv"+index).html(logisticsShowHtml);
			// =======运费 end============
				
			//代发费
			var $proxy = $("#oagent" + index + " option:selected");
			var amountTotal = 0;
			$(".quantity-"+storeID).each(function(){
				amountTotal =zhigu.cmn.arith(amountTotal, "+", $(this).html());
			});
			var oneProxyMoney = $proxy.data("agentmoney");
			var proxymoney = zhigu.cmn.arith(oneProxyMoney, "*", amountTotal);
			$(".waitSendMoney" + index).html(proxymoney);
			
			//商品价格、优惠
			var orderGoodsMoney = $(this).data("goodsmoney");
			var discount = 1;
			var offsetMoney = 0;
			orderGoodsMoney = zhigu.cmn.arith(zhigu.cmn.arith(orderGoodsMoney,'-',offsetMoney),'*',discount);
			//订单价格
			var orderMoney = zhigu.cmn.arith(zhigu.cmn.arith(proxymoney ,'+', logisticsMoney) ,'+', orderGoodsMoney);
			$(".ordermoney"+index).html(orderMoney);
			totalMoney = zhigu.cmn.arith(totalMoney,'+',orderMoney);
		});
		$("#totalMoney").html(totalMoney);
	}
</script>
</body>
</html>