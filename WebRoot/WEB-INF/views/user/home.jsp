<%@ page language="java" pageEncoding="utf-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
<title>人个中心</title>
</head>
<body>
<div class="rightContainer fr"> 
  <!--// 内容框 //-->
  <div class="rc_body"> 
    <h4 class="ddtitle">个人中心</h4>
    <div id="userContents" class="userContents">
      <div class="dengjibox pt20">
        <div class="center_top">
          <div class="touxianggai fl"><img src="${info.avatar}" title="头像" alt="头像" width="80" height="80" /></div>
          <div class="welinfo fr">
            <div class="welcome"><a class="username">${sessionUser.username }</a>，　欢迎您！
              <c:if test="${info.realUserAuthFlg==1 }"> <img src="img/sfz.jpg" title="已实名认证"/> </c:if>
               <span class="usertime fr">今天：${today} 上次登录：
              <fmt:formatDate value="${loginLog.loginDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
              </span> </div>
            <c:if test="${ sessionUser.getUserType() == 2 || sessionUser.getUserType() == 3 || sessionUser.getUserType() == 4}">
              <div class=""> 店铺名称：<span class="c666">${store.storeName }</span> </div>
            </c:if>
            <div><span id="userPoint" class="f14"></span></div>
            <div class="contact">
              <c:if test="${empty userAuth.phone}"> <img src="img/tel.png" title="电话未绑定" alt="电话未绑定" /> </c:if>
              <c:if test="${!empty userAuth.phone}"> <img src="img/telhong.png" title="${userAuth.phone}" alt="电话已绑定" /> </c:if>
              <c:if test="${empty userAuth.email}"> <img src="img/mail.png" title="邮箱未绑定" alt="邮箱未绑定" /> </c:if>
              <c:if test="${!empty userAuth.email}"> <img src="img/mailhong.png" title="${userAuth.email}" alt="邮箱已绑定" /> </c:if>
            </div>
          </div>
        </div>
        <div class="money">
        	<div><span class="yue fl">可用金额：<strong class="username">￥${acc.normalMoney }</strong>元</span><a href="user/recharge" class="congzhi">充值</a></div>
        	<div><span class="yue fl">冻结金额：<strong class="username">￥${acc.freezeMoney }</strong>元</span></div>
        </div>
        <div class="dingdan">
          <div class="dingdanheader">
            <h4 class="ddtitle">订单概况</h4>
            <p> <a href="user/order?status=1">待付款<strong>(${statusCount.waitPay + 0})</strong></a> <a href="user/order?status=2">待发货<strong>(${statusCount.waitSend + 0})</strong></a> <a href="user/order?status=3">待收货<strong>(${statusCount.waitConfirm + 0})</strong></a> 
              <!--						 <a>待评价<strong>(0)</strong></a> --> 
            </p>
          </div>
        </div>
        <div class="dingdan-list">
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
        </div>
        <div class="sc_sp">
          <h4 class="ddtitle">收藏的商品<a class="fr" href="user/favourite/favouriteGoods">查看更多</a></h4>
          <ul>
            <c:forEach var = "goods" items="${favouritegoods }">
              <li> <a target="_blank" href="goods/detail?goodsId=${goods.id}"><img src="${goods.image300 }"  title="${goods.name }" /></a>
                <p title="${goods.name }" class="word-overflow">${goods.name }</p>
                <p>￥${goods.minPrice }-${goods.maxPrice }</p>
              </li>
            </c:forEach>
          </ul>
        </div>
        <div class="scdp">
          <h4 class="ddtitle">收藏的店铺<a class="fr" href="user/favourite/favouritestore">查看更多</a></h4>
          <ul>
            <c:forEach var="store" items="${favouriteStores}" >
              <li> <a href="store/index?storeId=${store.ID}"><img height="60" width="60" title="进入店铺" alt="收藏的店铺" src="${store.logoPath}" /></a>
                <div class="dpimg2"> <a href="store/index?storeId=${store.ID}">${store.storeName }</a> </div>
              </li>
            </c:forEach>
          </ul>
        </div>
      </div>
    </div>
    <br style="clear:both;" />
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