<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
  <form action="user/order/submit" method="post" id="orderSubmitForm">
    <table cellpadding="0" cellspacing="0" class="shopping-cart-table">
      <tr>
        <th style="width:50%">商品</th>
        <th style="width:15%">规格</th>
        <th style="width:15%">价格(元)</th>
        <th style="width:10%">数量</th>
        <th style="width:10%">小计 </th>
      </tr>
      
      <!-- 购物车（每个商家一条） -->
      <c:forEach items="${shoppingCarts }" var="sc" varStatus="scStatus">
        <tr data-storeID="${sc.storeId }" data-weight="${sc.weight }" data-goodsmoney="${sc.storeTotal }">
          <td colspan="5"><div class="shop-list-head"> <span class="fl">店铺：<a class="c666" href="store/index?storeId=${sc.storeId }">${sc.storeName }</a></span> <span class="fl ml30">
              <c:if test="${not empty sc.QQ }"> <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${sc.QQ }&site=qq&menu=yes"> <img style="margin-bottom:-6px;margin-left:5px;" border="0" src="http://wpa.qq.com/pa?p=2:${sc.QQ}:52" alt="点这里给我发消息" /></a> </c:if>
              <c:if test="${not empty sc.aliWangWang }"> <a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${sc.aliWangWang}&site=cntaobao&s=2&charset=utf-8" > <img style="margin-bottom:-2px;margin-left:5px;" border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid=${sc.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a> </c:if>
              </span> </div>
            <c:forEach items="${sc.item }" var="item" varStatus="itemStatus">
              <table cellpadding="0" cellspacing="0" class="shopping-list-table">
                <tr>
                  <td style="width:50%"><span class="fl ml20"> <img height="50" height="50" src="${item.goods.image300}" /> </span> <span class="fl ml10 mt15"> <a class="c666" title="${item.goods.name }" href="goods/detail?goodsId=${item.goods.id }" target="_blank">${item.goods.name }</a> </span></td>
                  <td style="width:15%">${empty item.goodsSku.propertyStrName?'-':item.goodsSku.propertyStrName }</td>
                  <td style="width:15%"><fmt:formatNumber pattern="#0.00" value="${item.goodsSku.price }" /></td>
                  <td style="width:10%" class="quantity-${sc.storeId }">${item.quantity }</td>
                  <td style="width:10%"> ¥
                    <fmt:formatNumber pattern="#0.00" value="${item.subTotal }" /></td>
                </tr>
              </table>
            </c:forEach></td>
        </tr>
        <tr class="tablefooter">
          <td colspan="6"><div class="xline"> <span>给卖家留言：</span>
              <input class="input-txt" type="text" placeholder="可以告诉卖家您的特殊要求" name="orders[${scStatus.index }].leavelMessage" maxlength="200"/>
            </div>
            <div class="xline"> <span>代发商：</span>
              <select name="orders[${scStatus.index }].agentSellerID" onchange="countMoney()" id="oagent${scStatus.index }" class="select-txt">
                <c:forEach items="${agentUsers}" var="agentUser">
                  <option value="${agentUser.userId}" data-agentmoney="${agentUser.agentMoney}">${agentUser.agentName}</option>
                </c:forEach>
              </select>
            </div>
            <div class="xline" > <span>配送方式：</span>
              <select name="orders[${scStatus.index }].logistics" id="logistics${scStatus.index }" onchange="countMoney()" class="select-txt">
                <option value=''>-请选择-</option>
                <c:forEach items="${logistics }" var="l" >
                  <option value="${l.id }" data-fweight="${l.fweight }" data-fmoney="${l.fmoney }" data-cmoney="${l.cmoney }">${l.name }</option>
                </c:forEach>
              </select>
              <input type="hidden" name="orders[${scStatus.index }].storeID" value="${sc.storeId }">
            </div>
            <div  class="xline fr ml30"><font class="fr" >￥
              <fmt:formatNumber pattern="#0.00" value="${sc.storeTotal }" />
              </font></div>
            <div class="xline fr ml30">
              <ul>
                <li class="fl dafali">
                  <div>待发详情</div>
                  <div class="xiangqingbox1 p10"> 代发费:<span class="cff5200">￥</span><span class="cff5200 waitSendMoney${scStatus.index }"></span> </div>
                </li>
                <li class="yunfeixiangqing fl">
                  <div>运费详情<span></span></div>
                  <div class="xiangqingbox p10" id="logisticsDiv${scStatus.index }"> </div>
                </li>
              </ul>
            </div>
            <div class="xline fr ml30">
              <div class="fr"> <span>订单金额：</span> <strong>¥</strong> <strong class="mr20 ordermoney ordermoney${scStatus.index }" style="color:#ff4400">0.00</strong> </div>
            </div></td>
        </tr>
      </c:forEach>
    </table>
    <div class="msg-alert" style="padding:30px 0;"><span class="gantanhao"></span>
      <div class="fr ml30"> <span>应付总计：</span> <strong>¥</strong> <strong id="totalMoney" class="color-red fz16">${totalMoney }</strong> ( 元 ) </div>
      <div class="fr ml30"> <span>配送至：</span> <span id="addressLabel"></span> </div>
      <div class="fr ml30"> <span>收货人：</span> <span id="consigneeLabel"></span> </div>
    </div>
    <div class="shop-list-head">
      <div class="fr ml30"> <a href="user/cart" class="default-a">返回进货车</a>
        <input class="input-button" type="button" onclick="return _submit()" value="提交订单" />
      </div>
    </div>
    <input type="hidden" name="addressID" id="addressID" />
  </form>
</div>
<div class="xintiandizhibg" id="xinaddr"></div>
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
			var addressId = $("#addressID").val();
			if(!addressId){
				logisticsShowHtml = '<font color="red">请选择收货地址</font>';
			}
			var logisticsId = $logistics.val();
			if(logisticsId && addressId){
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