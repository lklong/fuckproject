<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>收藏的店铺</title>
<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
</head>
<body onload="haha()">
	<div class="rightContainer fr">
		<h4 class="ddtitle">收藏的店铺</h4>
		<div class="fun-bar">
			<ul class="fun-tabs">
				<li><a href="/user/favourite/favouriteGoods">收藏的商品</a></li>
				<li><a href="javascript:void(0);">收藏的店铺</a></li>
			</ul>
		</div>
		<h4 class="ddtitle">全部店铺</h4>
		<c:forEach var="store" items="${stores }">
			<div class="fav-shop-list">
				<c:if test="${empty stores }">
					<strong>暂无收藏！</strong>
				</c:if>
				<div class="fav-shop-left fl">
					<ul>
						<li>
							<h3>
								<a href="store/index?storeId=${store.ID}"><span
									class="color-red">${store.storeName }</span></a>
							</h3>
						</li>
						<li><span class="color-gray">店铺信誉：</span><span
							class="color-red">${store.levelPoint }</span></li>
						<li><span class="color-gray">进货咨询：</span> <c:if
								test="${!empty store.QQ}">
								<a target="_blank"
									href="http://wpa.qq.com/msgrd?v=3&uin=${store.QQ }&site=qq&menu=yes"><em
									class="qq-kefu-icon"></em></a>
							</c:if> <c:if test="${!empty store.aliWangWang}">
								<a target="_blank"
									href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${store.aliWangWang}&site=cntaobao&s=2&charset=utf-8"><em
									class="wangwang-kefu-icon"></em></a>
							</c:if></li>
					</ul>
					<div>
						<a href="javascript:delfavouritestore(${store.ID });" class="">删除</a>
					</div>
				</div>
				<div class="fav-shop-right fr">
					<div class="clear">
						<span class="fr"><a href="store/index?storeId=${store.ID}"
							class="color-gray">更多&gt;</a></span>
					</div>
					<ul class="clear">
						<c:forEach var="goods" items="${store.goods }">
							<li>
								<p>
									<a href="goods/detail?goodsId=${goods.id}" target="_blank"><img
										height="115" width="115" src="${goods.image300}"
										title="${goods.name}" /></a>
								</p>
								<p class="word-overflow">
									<a href="goods/detail?goodsId=${goods.id}">${goods.name}</a>
								</p>
								<p>
									<strong class="color-red">￥${goods.minPrice}-￥${goods.maxPrice}</strong>
								</p>
								<p>
									<jsp:useBean id="nowDate" class="java.util.Date" />

									<c:set var="someDate" value="${goods.time}" />
									<c:set var="interval" value="${nowDate.time-goods.time.time}" />
									<span class="color-gray"> <fmt:formatNumber
											value="${interval/1000/60/60/24}" pattern="#0" /> 天前
									</span>
								</p>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:forEach>
	</div>
	<script type="text/javascript">
		/* 删除收藏的店铺 */
		function delfavouritestore(storeID) {
			layer.confirm('确定将该店铺从收藏中删除？',{
				btn: ['确定', '取消']
			},function(){
				$.ajax({
					url : "user/favourite/delFavouriteStore",
					data : {
						"storeID" : storeID
					},
					success : function() {
						f5();
					}
				});
			},function(){
				
			});
		}
	</script>
</body>
</html>