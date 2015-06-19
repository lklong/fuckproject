<%@ page language="java" pageEncoding="utf-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
<title>人个中心</title>
<link rel="stylesheet" href="/css/default/goods.css">
</head>
<body>
<div class="rightContainer fr"> 
    <h4 class="ddtitle">个人中心</h4>
    <div class="gy-userbar clear">
    	<div class="gy-baseinfo fl side-border">
    		<a href="javascript:void(0);" class="gy-photo fl mr10 ml10"><img src="${info.avatar}" title="头像" alt="头像" width="65" height="65" /></a>
    		<span class="fwb color-red">${sessionUser.username } 欢迎您！</span>
    		<p class="mt10">
    			  <c:if test="${empty userAuth.phone}">
						<em class="gy-bind phone-no" title="电话未绑定"></em>
				  </c:if>
	              <c:if test="${!empty userAuth.phone}">
						<em class="gy-bind phone-yes" title="电话已绑定"></em>
				  </c:if>
	              <c:if test="${empty userAuth.email}">
	              		<em class="gy-bind email-no" title="邮箱未绑定"></em>
	              </c:if>
	              <c:if test="${!empty userAuth.email}">
						<em class="gy-bind email-yes" title="邮箱已绑定"></em>
				  </c:if>
				  <c:if test="${info.realUserAuthFlg==1 }">已实名认证</c:if>
    		</p>
    	</div>
    	<div class="gy-baseinfo fl side-border">
    		<p>今天：${today}</p>
    		<p>上次登录：<fmt:formatDate value="${loginLog.loginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
    	</div>
    	<div class="gy-baseinfo fl side-border">
    		<p>可用金额：<strong class="color-red">${acc.normalMoney }</strong> 元 <a href="user/recharge" class="chongzhi-input-btn fr">充值</a></p>
    		<p>冻结金额：<strong class="color-red">${acc.freezeMoney }</strong> 元</p>
    	</div>
    	<br style="clear:both" />
    </div>
    <h4 class="ddtitle">订单概况</h4>
    <div class="fun-bar">
    	<ul class="fun-tabs">
    		<li><a href="user/order?status=1">待付款<strong>(${statusCount.waitPay + 0})</strong></a></li>
    		<li><a href="user/order?status=2">待发货<strong>(${statusCount.waitSend + 0})</strong></a></li>
    		<li><a href="user/order?status=3">待收货<strong>(${statusCount.waitConfirm + 0})</strong></a></li>
    	</ul>
    </div>
	<table cellpadding="0" cellspacing="0" class="user-list-table">
        		<tr>
        			<th>&nbsp;</th>
        			<th>商品</th>
        			<th>数量</th>
        			<th>价格</th>
        			<th>日期</th>
        			<th>操作</th>
        			<th style="border-right:none;">状态</th>
        		</tr>
        		<c:forEach items="${orders }" var="o">
        		<tr>
        			<td><img width="80" height="80" title="商品" alt="商品" src="${o.details[0].goodsPic}" /></td>
        			<td>${o.details[0].goodsName}</td>
        			<td>￥<strong><fmt:formatNumber value="${o.payableMenoy }" pattern="#0.00"/></strong>(含代发、运费￥
                      <fmt:formatNumber value="${o.agentMoney + o.logisticsMoney }" pattern="#0.00"/>)</td>
        			<td>共${o.styleNum }款，合计${o.quantity }件</td>
        			<td><fmt:formatDate value="${o.orderTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
        			<td><a class="chakan" href="user/order/detail?orderID=${o.ID}">查看详情</a></td>
        			<td><c:choose>
                    <c:when test="${o.status == 1 }"> <a href="javascript:void(0)" onclick="orderPayment(${o.ID})">立即付款</a> </c:when>
                    <c:otherwise> ${o.statusLabel }</c:otherwise>
                  </c:choose></td>
        		</tr>
        		</c:forEach>
        	</table>
    <h4 class="ddtitle">收藏的商品<a class="fr" href="user/favourite/favouriteGoods">查看更多</a></h4>
    <div class="fav-shop pt10">
    	<ul>
            <c:forEach var = "goods" items="${favouritegoods }">
              <li> <a target="_blank" href="goods/detail?goodsId=${goods.id}"><img width="150" height="150" src="${goods.image300 }"  title="${goods.name }" /></a>
                <p title="${goods.name }" class="word-overflow">${goods.name }</p>
                <p>￥<span class="color-red">${goods.minPrice }-${goods.maxPrice }</span></p>
              </li>
            </c:forEach>
          </ul>
    </div>
    <h4 class="ddtitle">收藏的店铺<a class="fr" href="user/favourite/favouritestore">查看更多</a></h4>
    <div class="fav-shop pt10" style="height:190px; width:100%; over-flow:hidden;">
    	<ul>
            <c:forEach var="store" items="${favouriteStores}" >
              <li> <a href="store/index?storeId=${store.ID}"><img height="100" width="100" title="进入店铺" alt="收藏的店铺" src="${store.logoPath}" /></a>
                <div class="dpimg2"> <a href="store/index?storeId=${store.ID}">${store.storeName }</a> </div>
              </li>
            </c:forEach>
          </ul>
    </div>
</div>
<form action="user/order/pay" target="_blank" method="post" id="payForm">
  <input type="hidden" name="orderID" id="orderID">
</form>
<script type="text/javascript">
function orderPayment(id){
	$("#orderID").val(id);
	$("#payForm").submit();
}
</script>
</body>
</html>