<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" media="all" href="css/basic.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/secondCate.css" />
<title>服务详情</title>
<style type="text/css">
#description img {
	max-width: 940px;
}
</style>
</head>
<body>
	<!--** 装修商家主页导航 **-->
	<jsp:include page="../../store/service/menu.jsp"></jsp:include>
	<div class=""></div>
	<!--** 当前位置 **-->
	<!--** 详情页主体 **-->
	<div class="webpage pageMain">
		<jsp:include page="../../store/service/storeInfo.jsp"></jsp:include>
		<div class="pageRightBox">
			<div class="mt15 ml15 prbImg">
				<span><img src="${goods.images[0].image }" /></span>
			</div>
			<div class="mt15 ml20 prbTxt">
				<h3>${goods.name }</h3>
				<div class="prbInfo">
					<div class="prbKey">价 格：</div>
					<div class="prbValue">
						<span class="prbPrice">￥${goods.minPrice }-￥${goods.maxPrice }</span>
					</div>
				</div>
				<c:forEach items="${goods.properties }" var="p">
					<div class="prbInfo">
						<div class="prbKey">${p.propertyName }：</div>
						<div class="prbValue">${p.propertyValueName }</div>
					</div>
				</c:forEach>
				<c:choose>
					<c:when test="${goods.status == 1 }">
						<form action="/user/order/cart/add" id="cartForm" method="post">
							<input type="hidden" value="${goods.skus[0].id }"
								name="cartItems[0].skuID">

							<div class="prbInfo bton">
								<div class="prbKey">
									<a href="javascript:void(0)" onclick="zhigu.buyContact()"
										class="goBuyButton">联系店主</a>
								</div>
								<div class="prbValue"></div>
							</div>
						</form>
					</c:when>
					<c:otherwise>
						<h3>该商品已下架</h3>
					</c:otherwise>
				</c:choose>
				<div class="prbInfo">
					<div class="prbKey" style="width: 60px; padding-top: 7px;">
						<div id="bdshare" class="bdsharebuttonbox"
							data="{'url':'store/index?storeId=${store.ID}'}"
							data-tag="share_${store.ID }" style="float: left;">
							<a href="javascript:void(0);" class="bds_more" data-cmd="more"
								style="margin: 0px;">分享到</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form action="user/order/confirm" method="post" id="confirmForm"></form>
	<div class="clear"></div>
	<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}
function addCart(){
	var quantity = $("#quantity").val();
	if(parseInt(quantity,10) <= 0){
		dialog("请选择商品数量！");
		return false;
	}
	ajaxSubmit($("#cartForm").attr("action"), $("#cartForm").serialize(), function(msgBean){
		if(msgBean.code==zhigu.code.success){
			dialog(msgBean.msg);
		}else{
			dialog(msgBean.msg);
		}
	});
}
zhigu.buyContact = function(){
	var content = "<span style='font-size:25px;'>联系电话："+"<strong class='red' >${store.phone }</strong>";
	content+="<br/><br/>Q Q："+"${store.QQ }";
	content+="</span>";
	layer.alert(content,-1,'联系方式');
}

</script>
	<script type="text/javascript" id="bdshare_js" data="type=tools"></script>
	<script type="text/javascript" id="bdshell_js"></script>
	<script>
		
		// 分享补丁
		$(function(){
			$(".bdshare_dialog_box").on("mouseleave",function(){
				$(this).hide();
				$(".bdshare_dialog_bg").hide();
			});
			$(".bds_more").mouseenter(function(){
				$(".bdshare_popup_box").show();
			});
		})
	</script>

	<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"智谷同城货源网-${goods.name }","bdMini":"1","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>

</body>
</html>