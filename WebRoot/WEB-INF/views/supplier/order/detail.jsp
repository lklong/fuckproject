<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>订单详情</title>
</head>
<body>
<div class="rightContainer fr"  id="alldd">
  <h4 class="ddtitle">订单详情</h4>
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
    </div>
  </c:if>
  <table cellpadding="0" cellspacing="0" class="user-list-table txt-center">
    <tr>
      <th>货品</th>
      <th>单价(元)</th>
      <th>数量</th>
      <th>货品状态</th>
      <th>货品总价(元)</th>
      <th>&nbsp;</th>
    </tr>
    <c:forEach items="${order.details }" var="od">
      <tr>
        <td>
        <span class="fl"><a href="goods/detail?goodsId=${od.goodsID}" target="_blank"><img src="${od.goodsPic}"  height="50" width="50"/></a></span>
        <span class="fl mt15 ml10"><a href="goods/detail?goodsId=${od.goodsID}" target="_blank">${od.goodsName }</a></span>
        </td>
        <td>${od.unitPrice }</td>
        <td>${od.quantity }</td>
        <td>${order.statusLabel }</td>
        <td><fmt:formatNumber pattern="#0.00" value="${od.unitPrice * od.quantity}"/></td>
      </tr>
    </c:forEach>
  </table>
  <div class="shop-list-head">
    <div>代发费+物流费：<span class="fwb color-red">￥
      <fmt:formatNumber pattern="#0.00" value="${order.agentMoney}"/>
      +
      <fmt:formatNumber pattern="#0.00" value="${order.logisticsMoney}"/>
      </span></div>
    <div>实付款 ：<span class="fwb color-red">￥
      <fmt:formatNumber pattern="#0.00" value="${order.actuallyPayMenyoy}"/>
      </span></div>
  </div>
  <div class="shop-list-head">
    <c:if test="${sessionUser.userType == 3 || sessionUser.userType == 4 }">
      <div> <span>买家留言</span> <span>${order.leavelMessage }</span> </div>
    </c:if>
  </div>
</div>
</body>
</html>