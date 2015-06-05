<%@ page language="java" pageEncoding="utf-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<base href="${applicationScope.basePath}" />
<title><sitemesh:write property='title' />-智谷同城货源网</title>
<jsp:include page="/decorate/include/header-head.jsp" />
<sitemesh:write property='head' />
<link rel="stylesheet" type="text/css" href="/css/default/user.css" />
<script type="text/javascript" src="/js/user.js"></script>
</head>
<body>
<jsp:include page="/decorate/include/header-body.jsp" />
<div class="center_body"> 
  <!--// 左侧导航 //-->
  <div class="left_hover fl">
    <div class="left_bt"><a href="/user/home" class="color-white">我的智谷</a></span>
      <c:if test="${sessionScope.sessionUser.userType==1 }">
        <p><a href="supplier/store/registerInit" class="woyouhuoyuan"></a></p>
      </c:if>
    </div>
    <!--栏目开始-->
    <div class="tit"> <span>账号信息</span> </div>
    <div class="space"></div>
    <ul class="tit_hover">
      <li><a href="/user/info">基本资料</a></li>
      <li><a href="/user/security/center">安全设置</a></li>
      <li><a href="/user/address">收货地址</a></li>
<!--       <li><a href="/user/realauth">实名认证</a></li> -->
      <%-- 				<c:if test="${sessionScope.sessionUser.userType>1 }"> --%>
      <!-- 					<li><a href="/supplier/store/companyAuth">企业认证</a></li> --> 
      <!-- 					<li><a href="/supplier/store/realStoreAuth">实体认证</a></li> -->
      <%-- 				</c:if> --%>
    </ul>
    <div class="space"></div>
    <!--栏目结束--> 
    <!--栏目开始-->
    <div class="tit"> <span>资金管理</span> </div>
    <div class="space"></div>
    <ul class="tit_hover">
      <li><a href="/user/acc">账户信息</a></li>
      <li><a href="/user/acc/detail">收支明细</a></li>
      <li><a href="/user/recharge">网上充值</a></li>
      <li><a href="/user/acc/rechargelist">充值明细</a></li>
      <li><a href="/user/withdraw">余额提现</a></li>
    </ul>
    <div class="space"></div>
    <!--栏目结束--> 
    
    <!--栏目开始-->
    <div class="tit"> <span>采购</span> </div>
    <div class="space"></div>
    <ul class="tit_hover">
      <li><a href="/user/cart" target="_blank">我的购物车</a></li>
      <li><a href="/user/order">买家订单</a></li>
      <li><a href="/user/favourite/favouriteGoods">收藏管理</a></li>
      <li><a href="/user/downloadHistory/goods">下载管理</a></li>
    </ul>
    <div class="space"></div>
    <!--栏目结束--> 
    <!--栏目开始-->
    <c:if test="${sessionScope.sessionUser.userType>1 }">
      <div class="tit"> <span>销售</span> </div>
      <div class="space"></div>
      <ul class="tit_hover">
        <li><a href="/supplier/order">卖家订单</a></li>
        <li><a href="/supplier/goods/add">发布商品</a></li>
        <li><a href="/supplier/goods/list?status=1">商品管理</a></li>
        <li><a href="/supplier/store/lookStore" target="_blank">我的店铺</a></li>
        <li><a href="/supplier/store/baseInfoInit">店铺基本信息</a></li>
        <li><a href="/supplier/store/decorateInit">店铺装饰 </a></li>
        <li><a href="/supplier/storeNotice/storeNoticeList">店铺公告 </a></li>
      </ul>
      <div class="space"></div>
    </c:if>
    <!--栏目结束--> 
  </div>
  <sitemesh:write property='body' />
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>
