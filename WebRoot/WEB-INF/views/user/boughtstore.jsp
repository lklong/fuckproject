<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>购买过的店铺</title>
<link href="css/wangshang.css" rel="stylesheet" type="text/css" />
<link href="css/shoucang.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/main.js"></script>
</head>

<body onload="haha()">
	<div class="body_center2 fl p10 ml10">
		<div class="chongzhititle">
			<h4>购买过的店铺</h4>
		</div>
		<div class="shouchangdian mt20 c333">
			<div class="shouciantitle">
				<p class="mr10">店铺信息</p>
				<p>店铺动态</p>
				<div class="clear"></div>
			</div>
			<c:if test="${empty stores }"><strong>暂无数据！</strong></c:if>
			<c:forEach var="store" items="${stores }">
				<ul>
					<li class="li1 pt10">

						<div class="shoudianleft mr10 fl">
							<p class="shoudianp1">
								<span class="mr10">${store.storeName }</span><a href="store/index?storeId=${store.userID}">逛店铺&gt;&gt;</a>
							</p>
							<p>
								<span class="ver_ali">店铺信誉：</span> <span class="levelPoint">${store.levelPoint }</span>
							</p>
							<!-- 
							<p>
								<span>好评率：</span> <span class="blue">99.93%</span> <span
									class="c666">|比同行</span> <span class="ce81268">高:0.37%</span>
							</p>
							<p>
								认证服务：<span class="renzhengicon ver_ali" id="renzhengicon1"
									title="包退包换"></span> <span class="renzhengicon ver_ali"
									id="renzhengicon2" title="实拍认证"></span>
							</p> -->
							<p>
								<span class="ver_ali">进货咨询：</span>
								<span >
									<c:if test="${!empty store.QQ}"><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${store.QQ }&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${store.QQ}:52" alt="点这里给我发消息" /></a> </c:if>
									<c:if test="${!empty store.aliWangWang}"><a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${store.aliWangWang}&site=cntaobao&s=2&charset=utf-8" ><img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid=${store.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a></c:if> 
								</span>
							</p>
							<p class="fenxiang mt20">
								<ul>
									<li class="share fl ml30" onmouseover="share()">分享到
										<div class="shareli pt10 pl10" id="shareli1">
											<ul>
												<li class="la1"><a href="#">QQ空间</a></li>
												<li class="la2"><a href="#">新浪微博</a></li>
												<li class="la3"><a href="#">腾讯微博</a></li>
												<li class="la4"><a href="#">人人网</a></li>
												<li class="la5"><a href="#">网易</a></li>
											</ul>
										</div>
									</li>
									<li class="fl mr10">|</li>
									<li class="del fl"><a href="javascript:delBoughtStoree(${store.ID });">删除</a></li>
								</ul>
							</p>
						</div>
						<div class="shoudianright fl">
							<p>
								<h4 class="xinpintitle fl">新上商品</h4>
								<a href="store/index?storeId=${store.ID}" class="chakanmore fr mr10">更多动态&gt;&gt;</a>
								<div class="clear"></div>
							</p>
							<ul>
								<c:forEach var = "goods" items="${store.goods }">
									<li>
										<div class="dongtaiimg">
											<a href="goods/detail?goodsId=${goods.id}"><img src="${goods.image300}" title="${goods.name}"/></a>
										</div>
										<p class="dongtaimiao">
											<a href="goods/detail?goodsId=${goods.id}">${goods.name}</a>
										</p>
										<div class="dongtaiimgbot">
											<strong class="fl">￥${goods.minPrice}-￥${goods.maxPrice}</strong>
											 <jsp:useBean id= "nowDate" class = "java.util.Date" /> 
											 <c:set var="someDate" value="${goods.time}"/>
											  <c:set var= "interval" value= "${nowDate.time-goods.time.time}" />
											<p class="fl c666"> <fmt:formatNumber value= "${interval/1000/60/60/24}" pattern= "#0" />天前</p>
											<div class="clear"></div>
										</div>
									</li>
								</c:forEach>
							</ul>
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
					</li>
				</ul>
			</c:forEach>
			
			
		</div>
	</div>
	<div class="clear"></div>
<script type="text/javascript">
	function delBoughtStoree(storeID){
		confirmDialog("确定删除？",function(){
			$.ajax({
				url:"user/favourite/delBoughtStoree",
				data:{"storeID":storeID},
				success:function(){
					f5();
				}
			});
		});
	}
</script>
</body>
</html>
