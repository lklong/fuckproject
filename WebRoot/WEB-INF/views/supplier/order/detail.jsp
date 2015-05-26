<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/wangshang.css" rel="stylesheet" type="text/css" />
<title></title>
</head>
<body>
<div class="body_center2 fl p10 ml10 f12"  id="alldd">
<!-----------------------------------------------订单信息---------------------------------------------------->
		<div class="jinsan f12 lh25 pl20">
        	<ul>
            	<li class="dingdanselect fl mr5"><a href="#">订单详情</a></li>
            </ul>
            <div class="clear"></div>
        </div>
        <c:if test="${sessionUser.userType == 3 || sessionUser.userType == 4}">
        <div class="ddxxbox pt10 lh25 c666">
        	<div class="ddxxboxl">
            	<h4 class="f14">买家信息</h4>
                <div>
                	<p class="ddxxtt">订单号：</p>
                    <p>${order.orderNO }</p>
                    <div class="clear"></div>
                </div>
                <div>
                	<p class="ddxxtt">收货人：</p>
                    <p>${order.consignee }</p>
                    <div class="clear"></div>
                </div>
                <div>
                	<p class="ddxxtt">收货地址：</p>
                    <p><span>${order.address }</span></p>
                    <div class="clear"></div>
                </div>
                <div>
                	<p class="ddxxtt">手机：</p>
                    <p>${order.phone }</p>
                    <div class="clear"></div>
                </div>
                <div>
                	<p class="ddxxtt">备注：</p>
                    <p>${order.comment }</p>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="ddxxboxl">
            	<h4 class="f14">卖家信息</h4>
                <div>
                	<p class="ddxxtt">供应商：</p>
                    <p><a href="store/index?storeId=${order.storeID}" target="_blank">${order.storeName }</a></p>
                    <div class="clear"></div>
                </div>
            </div>
            
            <div class="clear"></div>
        </div>
        </c:if>
        
        <div class="clear"></div>
        <table class="ddxxtable tc lh30">
        	<tr class="ddxxth c333">
            	<th width="500">货品</th>
                <th width="150">单价(元)</th>
                <th width="100">数量</th>
                <th width="150">货品状态</th>
                <th width="100">货品总价(元)</th>
            </tr>
            <c:forEach items="${order.details }" var="od">
	            <tr>
	            	<td>
	                	<div class="ddxximg fl ml10 mt10">
		                	<a href="goods/detail?goodsId=${od.goodsID}" target="_blank"><img src="${od.goodsPic}" /></a>
	                	</div>
	                    <div class="ddxximgmiao fl tl ml10 mt10">
		                	<a href="goods/detail?goodsId=${od.goodsID}" target="_blank">${od.goodsName }</a>
	                    </div>
	                </td>
	                <td>${od.unitPrice }</td>
	                <td>${od.quantity }</td>
	                <td>${order.statusLabel }</td>
	                <td><fmt:formatNumber pattern="#0.00" value="${od.unitPrice * od.quantity}"/></td>
	            </tr>
            </c:forEach>
        </table>
        <div class="ddxxfukuan fr mt10 mr20 lh30 c666">
        	<div>代发费+物流费：<strong class="ddxxdaifafei">￥<fmt:formatNumber pattern="#0.00" value="${order.agentMoney}"/>+<fmt:formatNumber pattern="#0.00" value="${order.logisticsMoney}"/></strong></div>
            <div>实付款 ：<strong class="cff5200 f16">￥<fmt:formatNumber pattern="#0.00" value="${order.actuallyPayMenyoy}"/> </strong></div>
        </div>
        <div class="clear"></div>
        <c:if test="${sessionUser.userType == 3 || sessionUser.userType == 4 }">
	        <div class="ddxxliuyan pl10">
	        	<h4 class="lh30 f16 c333">买家留言</h4>
	            <p class="c666">${order.leavelMessage }</p>
	        </div>
        </c:if>
    </div>
    <div class="clear"></div>
</body>
</html>