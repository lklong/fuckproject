<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--** 顶部商家信息 **-->
<div class="shopInfoTop">
  <div class="intoTopInside">
    <div class="infoTopLeft">
      <div class="infoTopImg"> <a href="store/index?storeId=${store.ID}"><img src="${store.logoPath}" height="65" width="65" /></a> </div>
      <div id="JS-shop-panel" class="infoTopText side-border">
        <h2><a href="store/index?storeId=${store.ID}" class="color-red">${store.storeName }</a></h2>
		<div id="JS-shop-info" class="shop-info-panel">
			<p class="shop-p">
		     	<a id="wsc" class="add_shop" href="javascript:void(0)" onclick="favoStore(${store.ID});" >收藏店铺</a>
				<a id="ysc" class="add_shop" href="javascript:void(0)" >已收藏</a>
			</p>
			<ul>
				<!-- 实名认证 -->
				<li><span class="rzspan shiming"></span></li>
				<!-- 实地认证 -->
				<li><span class="rzspan shidi"></span></li>
				<!-- 企业认证 -->
				<li><span class="rzspan qiye"></span></li>
				<!-- 买家保障 -->
				<li></li>
			</ul>
		</div>
      </div>
      <div class="infoTopText side-border">
      	<p>直达域名：${store.domain }.zhiguw.com</p>
        <p><span class="fl">等级：</span><em class="levelPoint-x"></em><em class="levelPoint-x"></em><em class="levelPoint-x"></em><em class="levelPoint-x"></em><em class="levelPoint-x"></em></p>
      </div>
      <div class="infoTopText side-border">
      	<p><c:if test="${not empty store.phone }">联系电话：${store.phone }</c:if></p>
      	<p>
	      	<c:if test="${not empty store.QQ  }">QQ：${store.QQ }</c:if>
	      	<a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${store.QQ }&amp;site=qq&amp;menu=yes" target="_blank"><img border="0" title="点击咨询" alt="点击咨询" src="../img/dangan/wp_3.gif"></a>
      	</p>
      	<p><c:if test="${not empty store.aliWangWang }"> 旺旺：${store.aliWangWang }
      	<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${store.aliWangWang}&site=cntaobao&s=2&charset=utf-8">
							<img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid=${store.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a>
      	</c:if></p>
      </div>
    </div>
    <div class="infoTopRight">
      <div id="search" class="search-bar fl">
      <div class="search-input-div fl">
        <form method="post" action="/home/search" id="head_search_form">
          <input type="text" maxlength="30" value="输入商品名或货号" class="search-input" id="keyword" name="goodsName">
        </form>
        <div class="search-selector">
          <div id="search-selector-cur">商品</div>
          <ul id="search-selector-list">
            <li data-name="goodsName">商品</li>
            <li data-name="propName">货号</li>
            <li data-name="storeName">店铺</li>
          </ul>
        </div>
      </div>
      <div class="search-button-div fl">
        <input type="button" class="search-button" id="searchbtn">
      </div>
    </div>
    </div>
  </div>
  <div class="shop-banner">
  	  <div class="shop-nav-inner">
	  	  <div class="shopNavInside">
		      <ul>
		        <li><a href="store/index?storeId=${store.ID}">店铺首页</a></li>
		        <li>|</li>
		        <li><a href="store/intro?storeId=${store.ID}">商家介绍</a></li>
		        <li>|</li>
		        <li><a href="store/notice?storeId=${store.ID }">商家公告</a></li>
		        <li>|</li>
		      </ul>
		  </div>
  	  </div>
  	  <!-- 半透明背景条 -->
  	  <div class="shopTopNav"></div>
  </div>
</div>
<script type="text/javascript">
$(function(){
	/* 显示或隐藏店铺认证信息板 */
	$('#JS-shop-panel').hover(
			function(){
				$('#JS-shop-info').show();
			},
			function(){
				$('#JS-shop-info').hide();
			});
	
	$.get("/store/info",{"storeId":"${store.ID}"},function(msgBean){
		if(msgBean.code==zhigu.code.success){
			if(msgBean.data.isRealUserAuth){
				$("#geren_renzheng_area").prepend("<span id='geren_renzheng'></span>");
			}
		}
	});
	if (zhigu.isLogin=='true') {
		ajaxSubmit("/user/favourite/query", {"fID":"${store.ID}","type":1}, function(msgBean){
			if(msgBean.code==zhigu.code.success){
				if(msgBean.data){
					$("#wsc").hide();
					$("#ysc").show();
				}else{
					$("#wsc").show();
					$("#ysc").hide();
				}
			}
		});
	}else{
		$("#wsc").show();
		$("#ysc").hide();
	}
})
</script>