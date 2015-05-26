<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
@media ( max-height:640px) {
	#float_nav a {
		position: relative;
		display: block;
		top: 100px;
	}
.tshop-psm-shop-qq-hover{
  position: fixed;
  bottom:280px;
  z-index: 999999;
  right: 40px;
  width: 53px;
}
#qq_services{
	background-color:#fff;  border: 1px solid #efefef;
	height: 227px;display: none;width:120px;  position: absolute;right: 52px; top:-43px; z-index: 99999;
	}
}
</style>
<!--// 右侧浮动导航 //-->
<div id="float_nav">
	<ul>
		<a href="/user/cart">
			<li class="shopping_cart float_nav_img"></li>
			<li class="float_nav_text">购物车</li>
			<li class="float-nav-tab-sup-bg" hidden><span id="cartCount"></span></li>
			<li class="float-nav-tab-sup-bor"></li>
		</a>
		<a href="/user/order">
			<li class="shopping_order float_nav_img"></li>
			<li class="float_nav_text text_30">订单</li>
			<li class="float-nav-tab-sup-bg" hidden><span id="orderCount"></span></li>
			<li class="float-nav-tab-sup-bor"></li>
		</a>
		<a href="/user/favourite/favouriteGoods">
			<li class="nav_collect float_nav_img"></li>
			<li class="float_nav_text text_30">收藏</li>
			<li class="float-nav-tab-sup-bor"></li>
		</a>
		<a href="/user/home" id="user_personal_center">
			<li class="personal_center  float_nav_img"></li>
			<li class="float_nav_text">个人中心</li>
		</a>
		<a style="display: none;" class="top" href="#top" title="回到顶部">
			<li class="nav_gotop float_nav_img"></li>
		</a>
	</ul>
</div>
<!--右侧浮动客服消息 -->
<div class="tshop-psm-shop-qq-hover">
	<div class="skin-box-content">
		<div class="skin-box-hd">
			<a id="qq_hover" class="qq img" href="javascript:void(0);" title="点击在线交谈"><img alt="点击在线交谈" src="/img/qq/qq_50.gif"></a>
			<a style="display: none;" class="img top"  href="#top" title="回到顶部"><img alt="回顶部" src="/img/qq/gotop.png"></a>
		<div id="qq_services" >
			<p id="qq_text">在线客服</p>
			<div class="qq_hao">
				<div class="qq_img">
					<a target="_blank"
						href="http://wpa.qq.com/msgrd?v=3&uin=2880670728&site=qq&menu=yes"><img
						src="/img/qq/qq.png" border="0" alt="点击咨询" title="点击咨询"></a>
				</div>
				<div class="qq_img">
					<a target="_blank"
						href="http://wpa.qq.com/msgrd?v=3&uin=2880670726&site=qq&menu=yes"><img
						src="/img/qq/qq.png" border="0" alt="点击咨询" title="点击咨询"></a>
				</div>
				</div>
				<p id="tel">咨询热线：<br/><strong>028-65336799</strong></p>
			</div>
		</div>
	</div>
</div>
	<!--// 顶部功能条 //-->
	<div class="top_fun_bar">
		<div class="inner">

			<div class="login_register">
				<ul>
					<c:choose>
						<c:when test="${!empty sessionScope.sessionUser}">
							<li><a href="/user/message/message.html">消息<span
									id="head_msg_num"></span></a></li>
							<li><em>┆</em></li>
							<li>您好：<a href="/user/home" target="_blank">${sessionUser.username }</a>！
							</li>
							<li><a href="/login/logout">退出</a></li>
							<li><em>┆</em></li>
							<li><a href="/user/home">用户中心</a></li>
							<c:if test="${sessionScope.sessionUser.userType==1 }">
								<li><a href="/supplier/store/registerInit">我有货源</a></li>
							</c:if>
						</c:when>
						<c:otherwise>
							<li><a href="/login">登录</a></li>
							<li><em>|</em></li>
							<li><a href="/login/qq">QQ登录</a></li>
							<li><em>|</em></li>
							<li><a href="register">注册</a></li>
							<li><em>|</em></li>
							<li><a href="/login">我有货源</a></li>
						</c:otherwise>
					</c:choose>
					<li><em>|</em></li>
					<li><a href="help/cemment?id=41" target="_blank">帮助中心</a></li>
				</ul>
			</div>
		</div>
	</div>
	<!--// bannner&searchbar&shoppingcar //-->
	<div class="banner_searchbar" id="banner" style="display: block;">
		<div class="inner">
		<!-- 网站logo-->
			<div class="logo_box" id="logo" style="display: block;">
				<a href="/"><img src="img/index_logo.png" /></a>
			</div>
			
			<!--切换城市  -->
			<div class="city_change" id="city" style="display:block;">
			<div class="cuty_change_selected">
				<span class="cityName selectedCity">成都站</span><span class="changeico"></span>
				</div>
				<div class="city_change_list">
				<p class="cityItem">成都站</p>
				<!-- <p class="cityItem">天津站</p>
				<p class="cityItem">安徽站</p>
				<p class="cityItem">湖北站</p> -->
				</div>
			</div>
			<!--搜索框  -->
			<div class="searchbox" id="search">
				<form id="head_search_form" action="/home/search" method="post">
					<input name="goodsName" id="keyword" type="text"
						style="width: 228px" placeholder="分类搜索" />
				</form>
				<div id="searchsort" style="width:0px;">
					<div class="selectedsort">
						<span class="goodsName showselected">宝贝</span> <span
							class="sortico"></span>
					</div>
					<div class="searchsortlist">
						<div class="searchItem on" data-name="goodsName">宝贝</div>
						<div class="searchItem" data-name="propName">货号</div>
						<div class="searchItem" data-name="storeName">店铺</div>
					</div>
				</div>
				<input type="button" id="searchbtn" title="搜索" />
			</div>
		</div>
	</div>
<!--// 主导航条 //-->
<div class="nav_main_bar" id="nav_main_bar" style="display:block;">
	<div class="inner">
		<div class="nav_left_main">
			<ul>
			<li
				<c:if test="${cAction eq 'welcome' }">class="nav_main_selected"</c:if>><a
					href="/">首页</a></li>
				<li <c:if test="${cAction eq 'index' }">class="nav_main_selected"</c:if>>
				<a href="javascript:void(0);" onclick="zhigu.menu(3);">全部商品</a>
					<div class="nav_sub_box">
						<p class="sub_link_box_top">All Product Categories</p>
							<div class="sub_link_box_fl">
								<ul>
									<li><a href="/goods/list?categoryId=19"><h3>女装</h3></a></li>
									<li><a href="/goods/list?categoryId=21">连衣裙/半裙</a></li>
									<li><a href="/goods/list?categoryId=22">T恤</a></li>
									<li><a href="/goods/list?categoryId=23">衬衫</a></li>
									<li><a href="/goods/list?categoryId=25">牛仔裤</a></li>
								</ul>
								<ul>
									<li><a href="/goods/list?categoryId=20"><h3>男装</h3></a></li>
									<li><a href="/goods/list?categoryId=51">衬衫</a></li>
									<li><a href="/goods/list?categoryId=49">T恤</a></li>
									<li><a href="/goods/list?categoryId=53">牛仔裤</a></li>
								</ul>
								<ul>
									<li><a href="/goods/list?categoryId=107"><h3>童装</h3></a></li>
									<li><a href="/goods/list?categoryId=135">套装</a></li>
									<li><a href="/goods/list?categoryId=112">T恤</a></li>
									<li><a href="/goods/list?categoryId=111">裤子</a></li>
								</ul>
								<ul>
									<li><a href="/goods/list?categoryId=3"><h3>女鞋</h3></a></li>
									<li><a href="/goods/list?categoryId=8">凉鞋/拖鞋</a></li>
									<li><a href="/goods/list?categoryId=11">雨鞋</a></li>
									<li><a href="/goods/list?categoryId=10">帆布鞋</a></li>
									<li><a href="/goods/list?categoryId=7">靴子</a></li>
									<li><a href="/goods/list?categoryId=6">高帮鞋</a></li>
									<li><a href="/goods/list?categoryId=5">低帮鞋</a></li>
								</ul>
								<ul>
									<li><a href="/goods/list?categoryId=4"><h3>男鞋</h3></a></li>
									<li><a href="/goods/list?categoryId=12">凉鞋/拖鞋</a></li>
									<li><a href="/goods/list?categoryId=14">靴子</a></li>
									<li><a href="/goods/list?categoryId=15">帆布鞋</a></li>
									<li><a href="/goods/list?categoryId=17">高帮鞋</a></li>
								</ul>
								<ul>
									<li><a href="/goods/list?categoryId=178"><h3>童鞋</h3></a></li>
									<li><a href="/goods/list?categoryId=179">运动鞋</a></li>
									<li><a href="/goods/list?categoryId=180">亲子鞋</a></li>
								</ul>
							</div>
						</div>
					</li>

					<li
						<c:if test="${cAction eq 'index' }">class="nav_main_selected"</c:if>><a
						href="javascript:void(0);" onclick="zhigu.menu(3);">智谷鞋库</a>
						<div class="nav_sub_box">
							<p class="sub_link_box_top">Shoes Library</p>
							<div class="sub_link_box_fl">
								<ul>
									<li><a href="/goods/list?categoryId=3"><h3>女鞋</h3></a></li>
									<li><a href="/goods/list?categoryId=8">凉鞋/拖鞋</a></li>
									<li><a href="/goods/list?categoryId=11">雨鞋</a></li>
									<li><a href="/goods/list?categoryId=10">帆布鞋</a></li>
									<li><a href="/goods/list?categoryId=7">靴子</a></li>
									<li><a href="/goods/list?categoryId=6">高帮鞋</a></li>
									<li><a href="/goods/list?categoryId=5">低帮鞋</a></li>
								</ul>
								<ul>
									<li><a href="/goods/list?categoryId=4"><h3>男鞋</h3></a></li>
									<li><a href="/goods/list?categoryId=12">凉鞋/拖鞋</a></li>
									<li><a href="/goods/list?categoryId=14">靴子</a></li>
									<li><a href="/goods/list?categoryId=15">帆布鞋</a></li>
									<li><a href="/goods/list?categoryId=17">高帮鞋</a></li>
								</ul>
								<ul>
									<li><a href="/goods/list?categoryId=178"><h3>童鞋</h3></a></li>
									<li><a href="/goods/list?categoryId=179">运动鞋</a></li>
									<li><a href="/goods/list?categoryId=180">亲子鞋</a></li>
								</ul>
							</div>
						</div></li>
					<li
						<c:if test="${cAction eq 'dress/index' }">class="nav_main_selected"</c:if>><a
						href="javascript:void(0);" onclick="zhigu.menu(19);">智谷服饰</a>
						<div class="nav_sub_box">
							<p class="sub_link_box_top">Dress Library</p>
							<div class="sub_link_box_fl">
								<ul>
									<li><a href="/goods/list?categoryId=19"><h3>女装</h3></a></li>
									<li><a href="/goods/list?categoryId=21">连衣裙/半裙</a></li>
									<li><a href="/goods/list?categoryId=22">T恤</a></li>
									<li><a href="/goods/list?categoryId=23">衬衫</a></li>
									<li><a href="/goods/list?categoryId=25">牛仔裤</a></li>
								</ul>
								<ul>
									<li><a href="/goods/list?categoryId=20"><h3>男装</h3></a></li>
									<li><a href="/goods/list?categoryId=51">衬衫</a></li>
									<li><a href="/goods/list?categoryId=49">T恤</a></li>
									<li><a href="/goods/list?categoryId=53">牛仔裤</a></li>
								</ul>
								<ul>
									<li><a href="/goods/list?categoryId=107"><h3>童装</h3></a></li>
									<li><a href="/goods/list?categoryId=135">套装</a></li>
									<li><a href="/goods/list?categoryId=112">T恤</a></li>
									<li><a href="/goods/list?categoryId=111">裤子</a></li>
								</ul>
							</div>
						</div></li>
					<li><a href="/store/list">所有店铺</a></li>
					<li><a href="/store/list">所有商圈</a>
						<div class="nav_sub_box">
							<p class="sub_link_box_top">All Business Circle</p>
							<div class="sub_link_box_fl">
								<ul>
									<li><a href="/store/list?scope=1&orderBy=&searchStoreName="><h3>国际商贸城商圈</h3></a></li>
								</ul>
								<ul>
									<li><a href="/store/list?scope=2&orderBy=&searchStoreName="><h3>荷花池商圈</h3></a></li>
								</ul>
								<ul>
									<li><a href="/store/list?scope=3&orderBy=&searchStoreName="><h3>青龙市场</h3></a></li>
								</ul>
								<ul>
									<li><a href="/store/list?scope=4&orderBy=&searchStoreName="><h3>金花镇工业区</h3></a></li>
								</ul>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div class="nav_right_main">
				<ul>
					<li><a target="_blank"
						href="/static/sheyingfuwu/list.html">摄影服务</a></li>
					<!-- <li><a target="_blank" href="/goods/decorate">网店装修</a></li> -->
					<li><a target="_blank" href="/static/ad_proxy/index.html">一件代发</a></li>
					<!-- <li><a onclick="alert('正在开发中！');" href="javascript:void(0);">模特中心</a></li>  -->
					<!-- 				<li><a target="_blank" href="/static/zhaoshang/zhaoshang.html">招商代理</a></li> -->
				</ul>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		if (typeof zhigu == "undefined" || !zhigu) {
			var zhigu = {};
		}

		$(function() {

			// 搜索
			nipicIndexSearch();

			/*城市切换  */
		$('.cuty_change_selected').hover(function() {
			  $('.city_change_list').show();
			}, function() {
				$('.city_change_list').hide(); 
				$('.city_change_list').hover(function(){
					 $('.city_change_list').show();
				},function(){
					$('.city_change_list').hide(); 
				});
				
			});
			/* 设置下拉列表样式 */
		$(".cityItem").hover(function(){
			$(this).css({"background-color":"#bb1a02","color":"#fff","cursor":"pointer"}).siblings().css({"background-color":"#fff","color":"#333","cursor":"pointer"})
		});
		// 城市切换选择事件
		$(".cityItem").bind("mouseover", function() {
			/* var val = $(this).data("name"); */
			var text = $(this).text();
			$(".selectedCity").text(text);
			/* $("#keyword").attr("name", val); */
		}).click(function() {
			$(".city_change_list").hide();
		});
		
		
		
			/* QQ Service */
			$("#qq_hover").hover(function() {
				/* 	  var d_h = $(window).height();
					 		var d_w = $(window).width(); */
				$("#qq_services").fadeIn();
			}, function() {
				$("#qq_services").hide();
				$('#qq_services').hover(function() {
					$('#qq_services').fadeIn();
				}, function() {
					$("#qq_services").hide();
				});

			});

			// 关键字长度处理
			$("#keyword").on('input', function(e) {
				var val = this.value;
				if (val && val.length > 30) {
					dialog("搜索关键字不能大于30个字符！");
					this.value = val.substr(0, 29);
				}
			});

			// 搜索类型选择事件
			$(".searchItem").bind("mouseover", function() {
				var val = $(this).data("name");
				var text = $(this).text();
				$(".showselected").text(text);
				$("#keyword").attr("name", val);
			}).click(function() {
				$(".searchsortlist").hide();
			});

			// 搜索
			$("#searchbtn").click(function() {
				var keyvalue = $("#keyword").val();
				if ($.trim(keyvalue)) {
					$("#head_search_form").submit();
				}
			});

			//显示或隐藏下拉导航条
			$('.nav_left_main').find('li').hover(function() {
				//alert($(this).find('.sub_link_box_fl ul').length)
				var number = 100 / $(this).find('.sub_link_box_fl ul').length

				$(this).find('.sub_link_box_fl ul').css('width', number + '%');

				$(this).find('.nav_sub_box').fadeIn();

			}, function() {

				$(this).find('.nav_sub_box').hide();
				$(this).find('.nav_sub_box').hover(function() {

					$(this).find('.nav_sub_box').fadeIn();
				}, function() {
					$(this).find('.nav_sub_box').hide();
				});

			});

			//回到顶部
			$(window).scroll(function() {
				if ($(window).scrollTop() > 300) {
					$('.top').fadeIn(500);
				} else {
					$('.top').fadeOut(800);
				}
			});
			$(".top").click(function() {
				$('body,html').animate({
					scrollTop : 0
				}, 1000);
				return false;
			});

				// 轮询请求消息数
				//zhigu.getUserMsgNum();
				//setInterval(zhigu.getUserMsgNum, 30000);
				
			zhigu.refreshCartNum();
		});
zhigu.isLogin = "${not empty sessionScope.sessionUser}";
// 刷新右侧导航购物车数量
zhigu.refreshCartNum = function(){
	if (zhigu.isLogin=='true') {
		ajaxSubmit("/index/count", {}, function(msgBean) {
			if(msgBean.data.cartCount>0){
				$("#cartCount").parent().show();
				$("#cartCount").html(msgBean.data.cartCount);
			}
			if(msgBean.data.orderCount>0){
				$("#orderCount").parent().show()
				$("#orderCount").html(msgBean.data.orderCount);
			}
		});
	}
}
		zhigu.menu = function(categoryId) {
			window.location.href = "/goods/list?categoryId=" + categoryId;
		}

		zhigu.getUserMsgNum = function() {
			zhigu.request.usermessage("m00001", {}, function(msgBean) {
				if (msgBean.code == zhigu.code.success) {
					if (msgBean.data > 0) {
						$("#head_msg_num").html(
								"（<span style='color:red'>" + msgBean.data
										+ "未读</span>）");
					} else {
						$("#head_msg_num").html("");
					}
				}
			});
		}
	</script>