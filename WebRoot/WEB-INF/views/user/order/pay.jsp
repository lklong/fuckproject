<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>订单支付</title>
<link href="css/default/user.css" rel="stylesheet">
</head>
<body>
<div class="webpage">
    	<div class="zfcenter0 mt10 p10">
        	<p class="zztcshouyin pl10 c666">您正在使用同城货源平台付款</p>
            <div class="zfcenter0table p10">
	                    <table class="zfcentertableduo">
	                        <tr class="zfcenterth">
	                            <th width="200">订单号</th>
	                            <th width="200">商家</th>
	                            <th width="200">金额</th>
	                        </tr>
	                        <c:forEach items="${orders }" var="od">
		                        <tr>
		                            <td>${od.orderNO }</td>
		                            <td>${od.storeName }</td>
		                            <td><fmt:formatNumber pattern="#0.00" value="${od.payableMenoy}"/>元</td>
		                        </tr>
	                        </c:forEach>
	                    </table>
                    <p class="zfc0tablefoot c666">
                        <span>收货地址：</span><span>${orders[0].address }</span><span>${orders[0].consignee }</span><span>收</span><span>${orders[0].phone }</span>
                        <span class="rl">应付金额：<strong class="red">${totalPayMoney}</strong> 元</span>
                    </p>
            </div>
            <div class="zfcenterbottom mt10">
                <div class="zfcenteryue lh30 c666 mt10 ml50 mt20">
                    <div class="zfcenteryuetitle mb10 f16 fwbold">
                        <div class="fl">您的账户余额：<span class="cff5200 ml5 mr5"><fmt:formatNumber pattern="#0.00" value="${acc.normalMoney }"/></span>元</div>
                        <input type="hidden" id="accountMoney" value="${acc.normalMoney }">
                        <input type="hidden" id="totalPayMoney" value="${totalPayMoney }">
                        
                        <a href="user/recharge" target="_blank">
	                        <input type="button"  value="充值" class="fl ml50 cp" />
                        </a>
                        <div class="clear"></div>
                        <div class="zfcenteryuer fl">　支付:<span class="cff5200 mr5 red">￥<fmt:formatNumber pattern="#0.00" value="${totalPayMoney }"/> 元</span></div>
                    </div>
                    <div class="mb20 mt40">
                    	<form action="user/order/pay/submit" method="post" id="paySubmintForm">
                            <p class="zfcenterchong fl fwbold mr10">支付密码:</p>
                            <input class="zfchongtext fl" type="password" name="payPasswd" id="payPasswd" autocomplete="off" />
                            <a class="nomima fl ml10" href="user/security/paymentpwd" target="_blank">没有支付密码？</a>
                            <div class="clear"></div>
                            <c:forEach items="${orders }" var="o">
                            	<input type="hidden" name="orderNo" value="${o.orderNO}">
                            </c:forEach>
                           	<input type="hidden" name="key" value="${key}">
                            <input class="centerchongb mt40 fwbold cp" onclick="_submit()" type="button" value="确认支付" />
                            <input type="text" style="display:none" value="此处的input删掉然后回车按钮就会触发提交" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    	$().ready(function(){
    		var msg = "${msg}";
    		if(msg != ""){
    			layer.alert(msg,-1);
    		}
    	});
    	function _submit(){
    		var payPasswd = $("#payPasswd").val();
    		var totalMoney = $("#accountMoney").val();
    		var orderMoney = $("#totalPayMoney").val();
    		if(!payPasswd){
    			layer.alert("请输入支付密码",-1);
    			return false;
    		}
    		if(parseFloat(orderMoney) > parseFloat(totalMoney)){
    			layer.alert("帐户余额不足，请充值",-1);
    			return false;
    		}
    		$("#payPasswd").val(zhigu.encodeBase64(payPasswd));
    		$("#paySubmintForm").submit();
    	}
    </script>
</body>
</html>