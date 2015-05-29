<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 顶部功能条 -->
<div class="header">
  <div class="wrapper">
    <div class="pos-drop fl">您所在的位置：
      <div class="pos-select-list">
        <p id="pos-cur"><span id="pos-span">成都</span><i></i></p>
        <ul id="pos-ul">
          <li>成都</li>
          <li>武汉</li>
          <li>南京</li>
          <li>长沙</li>
        </ul>
      </div>
    </div>
    <div class="loginbar fr">
      <ul>
        <c:choose>
          <c:when test="${!empty sessionScope.sessionUser}">
            <li><a href="/user/home">您好：${sessionUser.username }！</a> <a href="/user/message/message.html" class="ml10">消息<span id="head_msg_num"></span></a></li>
            <li><em>|</em></li>
            <li><a href="/login/logout">退出</a></li>
            <c:if test="${sessionScope.sessionUser.userType==1 }">
              <li><em>|</em></li>
              <li><a href="/supplier/store/registerInit">我有货源</a></li>
            </c:if>
          </c:when>
          <c:otherwise>
            <li><a href="/login">登录</a></li>
            <li><em>|</em></li>
            <li><a href="/login/qq" class="qq_login">QQ登录</a></li>
            <li><em>|</em></li>
            <li><a href="register">注册</a></li>
            <li><em>|</em></li>
            <li><a href="/login">我有货源</a></li>
          </c:otherwise>
        </c:choose>
        <li><em>|</em></li>
        <li><a href="help/cemment?id=41">帮助中心</a></li>
      </ul>
    </div>
  </div>
</div>
<!-- 主导航 -->
<div class="nav">
  <div class="wrapper">
    <div class="logo fl"><a href="/"><img src="/img/default/logo.gif" title="智谷首页" alt="智谷首页"></a></div>
    <div class="menu fr">
      <ul id="menu_ul">
        <li><a href="/">首页</a></li>
        <li><a href="/welcome">全部商品</a>
          <div class="submenu-div hidden">
            <h3><a href="/goods/list?categoryId=19">女装</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=21">连衣裙/半裙</a></li>
              <li><a href="/goods/list?categoryId=22">T恤</a></li>
              <li><a href="/goods/list?categoryId=23">衬衫</a></li>
              <li><a href="/goods/list?categoryId=25">牛仔裤</a></li>
            </ul>
            <h3><a href="/goods/list?categoryId=20">男装</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=51">衬衫</a></li>
              <li><a href="/goods/list?categoryId=49">T恤</a></li>
              <li><a href="/goods/list?categoryId=53">牛仔裤</a></li>
            </ul>
            <h3><a href="/goods/list?categoryId=107">童装</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=135">套装</a></li>
              <li><a href="/goods/list?categoryId=112">T恤</a></li>
              <li><a href="/goods/list?categoryId=111">裤子</a></li>
            </ul>
            <h3><a href="/goods/list?categoryId=3">女鞋</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=8">凉鞋/拖鞋</a></li>
              <li><a href="/goods/list?categoryId=11">雨鞋</a></li>
              <li><a href="/goods/list?categoryId=10">帆布鞋</a></li>
              <li><a href="/goods/list?categoryId=7">靴子</a></li>
              <li><a href="/goods/list?categoryId=6">高帮鞋</a></li>
              <li><a href="/goods/list?categoryId=5">低帮鞋</a></li>
            </ul>
            <h3><a href="/goods/list?categoryId=4">男鞋</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=12">凉鞋/拖鞋</a></li>
              <li><a href="/goods/list?categoryId=14">靴子</a></li>
              <li><a href="/goods/list?categoryId=15">帆布鞋</a></li>
              <li><a href="/goods/list?categoryId=17">高帮鞋</a></li>
            </ul>
            <h3><a href="/goods/list?categoryId=178">童鞋</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=179">运动鞋</a></li>
              <li><a href="/goods/list?categoryId=180">亲子鞋</a></li>
            </ul>
          </div>
        </li>
        <li><a href="/goods/list?categoryId=3">智谷鞋库</a>
          <div class="submenu-div hidden">
            <h3><a href="/goods/list?categoryId=3">女鞋</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=8">凉鞋/拖鞋</a></li>
              <li><a href="/goods/list?categoryId=11">雨鞋</a></li>
              <li><a href="/goods/list?categoryId=10">帆布鞋</a></li>
              <li><a href="/goods/list?categoryId=7">靴子</a></li>
              <li><a href="/goods/list?categoryId=6">高帮鞋</a></li>
              <li><a href="/goods/list?categoryId=5">低帮鞋</a></li>
            </ul>
            <h3><a href="/goods/list?categoryId=4">男鞋</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=12">凉鞋/拖鞋</a></li>
              <li><a href="/goods/list?categoryId=14">靴子</a></li>
              <li><a href="/goods/list?categoryId=15">帆布鞋</a></li>
              <li><a href="/goods/list?categoryId=17">高帮鞋</a></li>
            </ul>
            <h3><a href="#">童鞋</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=179">运动鞋</a></li>
              <li><a href="/goods/list?categoryId=180">亲子鞋</a></li>
            </ul>
          </div>
        </li>
        <li><a href="/goods/list?categoryId=19">智谷服饰</a>
          <div class="submenu-div hidden">
            <h3><a href="/goods/list?categoryId=19">女装</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=21">连衣裙/半裙</a></li>
              <li><a href="/goods/list?categoryId=22">T恤</a></li>
              <li><a href="/goods/list?categoryId=23">衬衫</a></li>
              <li><a href="/goods/list?categoryId=25">牛仔裤</a></li>
            </ul>
            <h3><a href="/goods/list?categoryId=20">男装</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=51">衬衫</a></li>
              <li><a href="/goods/list?categoryId=49">T恤</a></li>
              <li><a href="/goods/list?categoryId=53">牛仔裤</a></li>
            </ul>
            <h3><a href="/goods/list?categoryId=107">童装</a></h3>
            <ul class="submenu">
              <li><a href="/goods/list?categoryId=135">套装</a></li>
              <li><a href="/goods/list?categoryId=112">T恤</a></li>
              <li><a href="/goods/list?categoryId=111">裤子</a></li>
            </ul>
          </div>
        </li>
        <li><a href="/store/list">所有店铺</a>
          <div class="submenu-div hidden">
            <h3><a href="/store/list?scope=1&orderBy=&searchStoreName=">国际商贸城商圈</a></h3>
            <ul class="submenu">
              <li><a href="#"></a></li>
            </ul>
            <h3><a href="/store/list?scope=2&orderBy=&searchStoreName=">荷花池商圈</a></h3>
            <ul class="submenu">
              <li><a href="#"></a></li>
            </ul>
            <h3><a href="/store/list?scope=3&orderBy=&searchStoreName=">青龙市场</a></h3>
            <ul class="submenu">
              <li><a href="#"></a></li>
            </ul>
            <h3><a href="/store/list?scope=4&orderBy=&searchStoreName=">金花镇工业区</a></h3>
            <ul class="submenu">
              <li><a href="#"></a></li>
            </ul>
          </div>
        </li>
        <li><a href="/static/sheyingfuwu/list.html">摄影服务</a></li>
        <li><a href="/static/ad_proxy/index.html">一件代发</a></li>
      </ul>
    </div>
  </div>
</div>
<!-- 主搜索 -->
<div class="search">
  <div class="wrapper">
    <div class="search-bar fl" id="search">
      <div class="search-input-div fl">
        <form id="head_search_form" action="/home/search" method="post">
          <input name="goodsName" id="keyword" type="text" class="search-input" value="输入商品名或货号" maxlength="30">
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
        <input id="searchbtn" type="button" class="search-button">
      </div>
      <div class="search-keyword fl">
        <ul>
          <li><a href="#">连衣裙</a></li>
          <li><a href="#">短裙</a></li>
          <li><a href="#">衬衫</a></li>
          <li><a href="#">T恤</a></li>
          <li><a href="#">针织衫</a></li>
          <li><a href="#">情侣装</a></li>
        </ul>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {var zhigu = {};}
$(function() {
	
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
});
</script>
