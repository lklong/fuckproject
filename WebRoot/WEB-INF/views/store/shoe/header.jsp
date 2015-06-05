<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="/css/default/goods.css" rel="stylesheet"/>
<link href="/css/default/shop.css" rel="stylesheet"/>
<!--** 顶部商家信息 **-->
<div class="shopInfoTop">
  <div class="intoTopInside">
    <div class="infoTopLeft">
      <div class="infoTopImg"> <a href="store/index?storeId=${store.ID}"><img src="${store.logoPath}" height="65" width="65" /></a> </div>
      <div id="JS-shop-panel" class="infoTopText side-border">
        <h2><a href="store/index?storeId=${store.ID}" class="color-red">${store.storeName }</a></h2>
		<div id="JS-shop-info" class="shop-info-panel">
			<p class="shop-p">
		     	<a id="wsc" class="add_shop" href="javascript:void(0)" onclick="javascript:favoStore(${store.ID});" >收藏店铺</a>
				<a id="ysc" class="add_shop" href="javascript:void(0)" >已收藏</a>
			</p>
			<ul>
				<!-- 实名认证 -->
				<c:if test="${userInfo.realUserAuthFlg == 1 }"><li><span class="rzspan shiming"></span></li></c:if>
				<!-- 实地认证 -->
				<c:if test="${store.realStoreAuth == 1 }"><li><span class="rzspan shidi"></span></li></c:if>
				<!-- 企业认证 -->
				<c:if test="${store.companyAuth == 1 }"><li><span class="rzspan qiye"></span></li></c:if>
				<!-- 买家保障 -->
				<li></li>
			</ul>
		</div>
      </div>
      <div class="infoTopText side-border">
      	<p>直达域名：${store.domain }.zhiguw.com</p>
<!--         <p><span class="fl">等级：</span><em class="levelPoint-x"></em><em class="levelPoint-x"></em><em class="levelPoint-x"></em><em class="levelPoint-x"></em><em class="levelPoint-x"></em></p> -->
      </div>
      <div class="infoTopText side-border">
      	<p class="clear"><c:if test="${not empty store.phone }">联系电话：${store.phone }</c:if></p>
      	<p class="clear">
	      	<span class="fl"><c:if test="${not empty store.QQ  }">QQ：${store.QQ }</c:if></span>
	      	<a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${store.QQ }&amp;site=qq&amp;menu=yes" target="_blank">
			<em class="qq-kefu-top"></em></a>
      	</p>
      	<p class="clear">
      	<c:if test="${not empty store.aliWangWang }">
			<span class="fl">旺旺：${store.aliWangWang }</span>
      		<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${store.aliWangWang}&site=cntaobao&s=2&charset=utf-8">
      		<em class="wangwang-kefu-top"></em></a>
      	</c:if>
      	</p>
      </div>
    </div>
    <div class="infoTopRight">
      <div id="search" class="search-bar fl">
      <div class="search-input-div fl">
        <form method="post" action="/home/search" id="head_search_form">
          <input type="text" maxlength="30" value="输入商品名或货号" class="search-input" id="keyword" name="goodsName">
        </form>
        <div class="search-selector">
          <div class="search-selector-cur"><span id="JS-cur">商品</span></div>
          <ul id="search-selector-list">
            <li data-name="goodsName">商品</li>
            <li data-name="propName">货号</li>
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
	// 关键字长度处理
	$("#keyword").on('input', function(e) {
		var val = this.value;
		if (val && val.length > 30) {
			dialog("搜索关键字不能大于30个字符！");
			this.value = val.substr(0, 29);
		}
	});

	// 搜索类型选择事件
	$("#search-selector-list li").bind("mouseover", function() {
		var val = $(this).data("name");
		var text = $(this).text();
		$(".search-selector-cur").text(text);
		$("#keyword").attr("name", val);
	}).click(function() {
		$(".search-selector-list").hide();
	});

	// 搜索
	$("#searchbtn").click(function() {
		var keyvalue = $("#keyword").val();
		if ($.trim(keyvalue)) {
			$("#head_search_form").submit();
		}
	});
	/* 显示或隐藏店铺认证信息板 */
	$('#JS-shop-panel').hover(
			function(){
				$('#JS-shop-info').show();
			},
			function(){
				$('#JS-shop-info').hide();
			});
	
/* 	$.get("/store/info",{"storeId":"${store.ID}"},function(msgBean){
		console.log(msgBean);
		if(msgBean.code==zhigu.code.success){
			if(msgBean.data.isRealUserAuth){
				$("#geren_renzheng_area").prepend("<span id='geren_renzheng'></span>");
			}
		}
	}); */
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