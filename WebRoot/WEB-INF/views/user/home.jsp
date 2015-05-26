<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人个中心</title>
<style>
.word-overflow{
	overflow: hidden;
	white-space: nowrap;
	text-overflow:ellipsis;
}
</style>
</head>
<body>
<div class="rightContainer">
		<!--// 标题 //-->
		<h3 class="rc_title">
			个人中心<a href="user/home">我的主页</a>
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<!--// tab切换条 //-->
			<div id="userCommTab" class="userCommTab">
				<ul>
					<li><a href="javascript:void(0);" class="uctSelected">个人中心</a></li>
				</ul>
			</div>
			<div id="userContents" class="userContents">
			  <div class="dengjibox pt10">
			<div class="center_top">
				<div class="touxianggai fl"><img src="${info.avatar}" title="头像" alt="头像" width="80" height="80" /></div>
				<div class="fl ml15">
					<div class="welcome">
						欢迎您，<a class="username ce81268">${sessionUser.username }</a> 
						<c:if test="${info.realUserAuthFlg==1 }">
							<img src="img/sfz.jpg" title="已实名认证"/>
						</c:if>
						今天：${today}
						<span class="usertime ml10">
							上次登录：<fmt:formatDate value="${loginLog.loginDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
						</span>
					</div>
					<c:if test="${ sessionUser.getUserType() == 2 || sessionUser.getUserType() == 3 || sessionUser.getUserType() == 4}">
					<div class="jine clear f14">
					   	   店铺名称：<span class="c666">${store.storeName }</span>
					</div>
					</c:if>
					<div class="jine clear f14">
						<span class="yue">可用金额：<strong class="username ce81268 fwryh mr10">￥${acc.normalMoney }</strong>元</span>
						<span class="yue">冻结金额：<strong class="username ce81268 fwryh mr10">￥${acc.freezeMoney }</strong>元</span>
						<a href="user/recharge" class="ce81268 mr20 ml30">充值</a>
					</div>
					<div><span id="userPoint" class="f14"></span></div>
					<div class="contact">
						<c:if test="${empty userAuth.phone}">
							<img src="img/tel.png" title="电话未绑定" alt="电话未绑定" />
						</c:if>
						<c:if test="${!empty userAuth.phone}">
							<img src="img/telhong.png" title="${userAuth.phone}" alt="电话已绑定" />
						</c:if>

						<c:if test="${empty userAuth.email}">
							<img src="img/mail.png" title="邮箱未绑定" alt="邮箱未绑定" />
						</c:if>
						<c:if test="${!empty userAuth.email}">
							<img src="img/mailhong.png" title="${userAuth.email}" alt="邮箱已绑定" />
						</c:if>
						<div class="clear"></div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<div class="dingdan">
				<div class="dingdanheader p10">
					<h4 class="ddtitle">购买订单</h4>
					<p>
						<a href="user/order?status=1">待付款<strong>(${statusCount.waitPay + 0})</strong></a>
						<a href="user/order?status=2">待发货<strong>(${statusCount.waitSend + 0})</strong></a>
						<a href="user/order?status=3">待收货<strong>(${statusCount.waitConfirm + 0})</strong></a>
<!--						 <a>待评价<strong>(0)</strong></a> -->
					</p>
					<div class="clear"></div>
				</div>
				<ul class="dingdantxt">
					<c:forEach items="${orders }" var="o">
						<li>
						<div class="w350">
							<div class="dingdanimg">
								<img width="80" height="80" title="商品" alt="商品" src="${o.details[0].goodsPic}" />
							</div>
							<div class="dingdanneirong1">
								<p class="ellipsis">${o.details[0].goodsName}</p>
								<p>
									<strong class="fwryh liulanguoprice">￥<fmt:formatNumber value="${o.payableMenoy }" pattern="#0.00"/> 
									</strong>(含代发、运费<strong class="ff5200 fwryh">￥<fmt:formatNumber value="${o.agentMoney + o.logisticsMoney }" pattern="#0.00"/></strong>)
								</p>
								<p class="ml10">共${o.styleNum }款，合计${o.quantity }件</p>
							</div>
							</div>
							<div class="dingdanneirong2">
								<%-- <p>${o.statusLabel }</p> --%>
								<p>
									<span class="hui"><fmt:formatDate value="${o.orderTime }" pattern="yyyy-MM-dd HH:mm:ss" /> </span>
									<a class="chakan" style="color: blue" href="user/order/detail?orderID=${o.ID}">查看详情</a>
								</p>
							</div> 
							<div class="ml40">
							<c:choose>
								<c:when test="${o.status == 1 }">
									<a href="javascript:void(0)" onclick="orderPayment(${o.ID})">立即付款</a>	
								</c:when>
								<c:otherwise>
									<span>${o.statusLabel }</span>
								</c:otherwise>
							</c:choose>
							</div>
							
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="sc_sp">
				<h4 class="sc_title fl">收藏的商品</h4>
				<a class="kangengduo fwbold fl mt10 ml20" href="user/favourite/favouriteGoods">查看更多</a>
				<div class="clear"></div>
				<ul>
					<c:forEach var = "goods" items="${favouritegoods }">
						<li>
							<a target="_blank" href="goods/detail?goodsId=${goods.id}"><img src="${goods.image300 }"  title="${goods.name }" /></a>
							<p title="${goods.name }" class="word-overflow">${goods.name }</p>
							<p>￥${goods.minPrice }-${goods.maxPrice }</p>
						</li>
					</c:forEach>
				</ul>
			</div>
			 <div class="clear"></div>
			<div class="scdp">
				<h4 class="scdptitle fl">收藏的店铺</h4>
					<a class="kangengduo fwbold fl mt10 ml20" href="user/favourite/favouritestore">查看更多</a>
				<div class="sxdongtai fwbold fl ml20">
				</div>
				<div class="clear"></div>
				<ul>
					<c:forEach var="store" items="${favouriteStores}" >
						<li>
							<a href="store/index?storeId=${store.ID}"><img class="sximg" title="进入店铺" alt="收藏的店铺" src="${store.logoPath}" /></a>
							<div class="dpimg2">
								<a href="store/index?storeId=${store.ID}"><img src="img/sc_dp.jpg" title="进入店铺"/> ${store.storeName }</a>
							</div>
						</li>
					</c:forEach>
				</ul>
				<div class="clear"></div>
			</div>
		</div>
	 </div>
			<br style="clear:both;" />
		</div>
	</div>


<!-----------------------------------------------center中间部分---------------------------------------------------->
		
	<div class="clear"></div>
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