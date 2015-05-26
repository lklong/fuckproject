<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>供应商首页</title>
</head>

<body>
<div class="rightContainer">
		<!--// 标题 //-->
		<h3 class="rc_title">
			供货商中心<a href="user/home">我的主页</a>
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<div id="userContents" class="userContents">
							<div class="center_top">
				<div class="touxianggai fl">
					<img src="${userInfo.avatar}" title="头像" alt="头像"
						width="80" height="80" />
				</div>
				<div class="fl ml15">
					<div class="f14 mt5">
						店铺名称：<span class="c666">${store.storeName }</span>  <a href="javascript:void(0)" onclick="refresh()" title="刷新店铺，提升店铺搜索排名" style="color: red;margin-left: 10px;">刷新店铺</a>
					</div>
					<div class="welcome">
						欢迎您，<a class="username"><font color="#ff4400">${sessionUser.username }</font></a> 
						<span>
							<c:if test="${userInfo.realUserAuthFlg==1 }">
								<img src="img/sfz.jpg" title="已实名认证"/>
							</c:if>
						</span>
						今天： ${today }  <span class="usertime ml10"> 上次登录：<fmt:formatDate value="${loginLog.loginDate }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
					</div>
					<div class="jine clear f14 mt5">
						<span class="yue">可用金额：<strong class="username mr10"><font color="#ff4400">￥${account.normalMoney }</font></strong>元
						</span> <span class="yue">冻结金额：<strong class="username mr10"><font color="#ff4400">￥${account.freezeMoney }</font></strong>元
						</span> 
						 <a href="user/recharge" class="mr20 ml30">充值</a>
					</div>
					<div class="jine clear f14 mt5">
						<div class="fl"><span id="userPoint" class="f14"></span></div>
					</div>
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
					<h4 class="ddtitle ml10">已卖出商品</h4>
					<p>
						<a href="supplier/order?status=1">待付款<strong>(${statusCount.waitPay +0 })</strong></a>
						<a href="supplier/order?status=2">待发货<strong>(${statusCount.waitSend +0 })</strong></a>
						<a href="supplier/order?status=3">待收货<strong>(${statusCount.waitConfirm +0 })</strong></a>
					</p>
					<div class="clear"></div>
				</div>
				<ul class="dingdantxt">
					<c:forEach items="${orders }" var="o">
						<li>
							<div class="dingdanimg">
								<img width="80" height="80" title="商品" alt="商品" src="${o.details[0].goodsPic}" />
							</div>
							<div class="dingdanneirong1">
								<p>
									<strong class="fwryh liulanguoprice">￥<fmt:formatNumber value="${o.payableMenoy }" pattern="#0.00"/> 
									</strong>(含代发、运费<strong class="ff5200 fwryh">￥<fmt:formatNumber value="${o.agentMoney + o.logisticsMoney }" pattern="#0.00"/></strong>)
								</p>
								<p class="ml10">共${o.styleNum }款，合计${o.quantity }件</p>
							</div>
							<div class="dingdanneirong2">
								<p>
									<span class="hui"><fmt:formatDate value="${o.orderTime }" pattern="yyyy-MM-dd HH:mm:ss" /> </span>
									<a class="chakan" style="color: blue" href="supplier/order/detail?orderID=${o.ID}">查看详情</a>
								</p>
							</div> 
							<div class="ml40">
								<span>${o.statusLabel }</span>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			 </div>
			<br style="clear:both;" />
		</div>
	</div>
	<div class="clear"></div>
	<script type="text/javascript">
function refresh(storeId){
	ajaxSubmit("supplier/store/refresh", {}, function(msgBean){
		if(msgBean.code==zhigu.code.success){
			layer.msg(msgBean.msg);
		}else{
			layer.alert(msgBean.msg);
		}
	});
}
</script>
</body>
</html>
