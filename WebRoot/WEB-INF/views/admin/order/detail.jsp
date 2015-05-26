<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<h3 class="sysIndH3">订单信息</h3>
<table cellpadding="0" cellspacing="0" class="sysInfoTextTable">
        	<tr>
            	<td class="bft" width="6%">订单号：</td>
                <td width="94%">${order.orderNO }</td>
            </tr>
            <tr>
            	<td class="bft" width="6%">收货人：</td>
                <td width="94%">${order.consignee }</td>
            </tr>
            <tr>
            	<td class="bft" width="6%">收货地址：</td>
                <td width="94%">${order.address }</td>
            </tr>
            <tr>
            	<td class="bft" width="6%">手机：</td>
                <td width="94%">${order.phone }</td>
            </tr>
            <tr>
            	<td class="bft" width="6%">备注：</td>
                <td width="94%">${order.comment }</td>
            </tr>
        </table>

<h3 class="sysIndH3">卖家信息</h3>
<table cellpadding="0" cellspacing="0" class="sysInfoTextTable">
	<tr>
    	<td width="6%">供应商：</td>
        <td width="94%"><a href="store/index?storeId=${order.storeID}" target="_blank">${order.storeName }</a></td>
    </tr>
</table>
<h3 class="sysIndH3">商品清单</h3>
<table class="sysCommonTable" cellspacing="0" cellpadding="0">
	<tr class="ddxxth c333">
    	<th width="400">货品</th>
    	<th width="100">规格</th>
        <th width="150">单价(元)</th>
        <th width="100">数量</th>
        <th width="150">货品状态</th>
        <th width="100">货品总价(元)</th>
    </tr>
    <c:forEach items="${order.details }" var="od">
     <tr>
     	<td>
   				<div class="ddxximg fl ml10 mt10">
         		<a href="goods/detail?goodsId=${od.goodsID}" target="_blank">
         			<img src="${od.goodsPic}" width="70" height="70" />
         		</a>
         	</div>
             <div class="ddxximgmiao fl tl">
             	<a class="ml10 mt10 ellipsis" href="goods/detail?goodsId=${od.goodsID}" target="_blank" style="width: 250px;" title="${od.goodsName }" >${od.goodsName }</a>
             </div>
         </td>
         <td>${od.propertystrname }</td>
         <td>${od.unitPrice }</td>
         <td>${od.quantity }</td>
         <td>${order.statusLabel }</td>
         <td><fmt:formatNumber pattern="#0.00" value="${od.unitPrice * od.quantity}"/></td>
     </tr>
    </c:forEach>
</table>

<div class="sysTotalBar">
	<div>代发费+物流费：<font color="#ff3300">￥${ order.agentMoney}+${ order.logisticsMoney}</font></div>
    <div>应付款 ：<font color="#ff3300"><strong>￥<fmt:formatNumber pattern="#0.00" value="${order.payableMenoy}"/> </strong></font></div>
    <div>实付款 ：<font color="#ff3300"><strong>￥<fmt:formatNumber pattern="#0.00" value="${order.payableMenoy}"/> </strong></font></div>
    <br style="clear:both;" />
</div>

<h3 class="sysIndH3">买家留言</h3>
<table class="sysMsgTextTable" cellspacing="0" cellpadding="0">
	<tr>
		<td>${order.leavelMessage }</td>
	</tr>
</table>

<h3 class="sysIndH3">物流信息</h3>
<table class="sysMsgTextTable" cellspacing="0" cellpadding="0">
	<tr>
	    <td>
	    <p>物流公司：${order.logisticsName } &nbsp;&nbsp;&nbsp;&nbsp;运单号码：${order.logisticsNO }</p>
	    <div id="progress"></div>
	    </td>
    </tr>
</table>


    <script type="text/javascript">
    	$(function(){
    		var data = "${order.logisticsProgress}";
    		if(data.length == 0){
    			ajaxSubmit("logistics/query", "orderID=${order.ID}", function(r){
    				data = r;
    			},null,false);
    		}
    		var html = "";
    		if(data.length != 0){
				html += "<table class='lh20 tl'>";
				for(var i = 0 ;i < data.length;i++){
					var obj = data[i];
					if(data.length -1 == i)
						html +="<tr style='color:#1b730c'><td width='130'>" + obj.time + "</td><td width='250'>" + obj.context + "</td></tr>";
					else
						html +="<tr><td width='130'>" + obj.time + "</td><td width='250'>" + obj.context + "</td></tr>";
				}
				html +="</table>";
			}
			if(html == ""){
				$("#progress").html("暂无记录....");
			}else{
				$("#progress").html(html);
			}
    	});
    </script>
</body>
</html>