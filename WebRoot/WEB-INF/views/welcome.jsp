<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name='keywords' content='同城，货源，批发市场，摄影，网店装修，一件代发' />
<meta name='description' content='智谷同城货源网是一家专业从事电子商务运营平台，提供最优质的"同城货源"、一件代发服务；专业服务、品质保障！欢迎访问 www.zhiguw.com' />
<title>智谷首页</title>

<link type="text/css" href="/css/welcome.css?v=20150505" rel="stylesheet" media="all" />
<script type="text/javascript" src="js/jquery.min.js"></script>
</head>

<body>

	<!--// 主flash //-->
<!--  	<div class="flash_main">
		<div id="full-screen-slider">
			<ul id="slides">
			</ul>
		</div>
	</div>  -->
	

	<div class="main_visual">
	<div class="flicking_con">
		<a href="#">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
	</div>
	<div class="main_image">
		<ul>
			<li><a href="/goods/list?categoryId=3" target="_blank"><img src="../img/02.jpg"/></a></li>
			<li><a href="/goods/list?categoryId=20" target="_blank"><img src="../img/03.jpg"/></a></li>
			<li><a href="/goods/list?categoryId=19" target="_blank"><img src="../img/p_6.jpg"/></a></li>
		</ul>
	</div>
	
	</div>
	<script type="text/javascript">

	 $(document).ready(function () {
        var $images = $(".main_image li");
        var $button = $(".flicking_con a");
        var index = 0;
        var time = 0;
        function action() {
            $images.eq(index).fadeIn().siblings().fadeOut();
            $button.eq(index).addClass("bian").siblings().removeClass("bian");
            index = index + 1;
            if (index == $images.size())
                index = 0;
            time= window.setTimeout(action,3000); 
        }
        $button.click(function () {
            clearTimeout(time);
                index = $(this).index();
                action();
        });

        action();
    });

	
/*   $(function(){  
		  $.getJSON("/Admanage/AdController/homePageShowAd?adColumnType=1",function(msgBean){
	     	 var html="";
	     	for(var i=0;i<msgBean.data.length;i++){
	     	   html+="<li style='background:url("+msgBean.data[i].adImg+") no-repeat center top'><a href='"+msgBean.data[i].adLink+"' ></a></li>"
	     	}
	     	$("#slides").html(html);
	     	zhigu.slidesStart();
	     })  

	})  
 */
	</script>
	
	<div class="brand_block">
		<div class="brand_inner">
			<div class="hot_brand">热门品牌<font color="#ff9900">HOT BRAND</font></div>
			<ul class="brand_list">
				<li><img src="../img/brand/brand_01.jpg"/></li>
				<li><img src="../img/brand/brand_02.jpg"/></li>
				<li><img src="../img/brand/brand_03.jpg"/></li>
				<li><img src="../img/brand/brand_04.jpg"/></li>
				<li><img src="../img/brand/brand_05.jpg"/></li>
				<li><img src="../img/brand/brand_06.jpg"/></li>
				<li><img src="../img/brand/brand_07.jpg"/></li>
				<li><img src="../img/brand/brand_08.jpg"/></li>
				<li><img src="../img/brand/brand_09.jpg"/></li>
				<li><img src="../img/brand/brand_010.jpg"/></li>
				<li><img src="../img/brand/brand_011.jpg"/></li>
				<li><img src="../img/brand/brand_012.jpg"/></li>
				<li><img src="../img/brand/brand_013.jpg"/></li>
				<li><img src="../img/brand/brand_014.jpg"/></li>
				<li><img src="../img/brand/brand_015.jpg"/></li>
				<li><img src="../img/brand/brand_016.jpg"/></li>
			</ul>
		</div>
	</div>

	<!-- 1F女装 -->
	<div class="goods_cate_block">
		<div class="goods_block_title">
			<div class="block_title nvzhuang"></div>
		</div>
		<div class="goods_block">
			<div class="inner_inside">
				<ul class="cate_block_ul">
						<c:forEach items="${womanDress }" var="g">
							<li>
								<div class="tuijian_ico"></div>
								<div class="goods_image">
										<a href="/goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300}_285x285.jpg"  width="285px" height="285px" alt="${g.name}" /></a>
								</div>
								<div class="goods_text_info">
									<p class="text_price">
										<font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font>
									</p>
									<div>
										<h3 class="text_name">
											<a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a>
										</h3>
									</div>
									<p class="text_down">
										<a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a>
									</p>
								</div>
							</li>
						</c:forEach>
					</ul>
			</div>
		</div>
	</div>
	
	<!-- 2F男装 -->
	<div class="goods_cate_block">
		<div class="goods_block_title">
			<div class="block_title nanzhuang"></div>
		</div>
		<div class="goods_block">
			<div class="inner_inside">
				<ul class="cate_block_ul">
						<c:forEach items="${manDress }" var="g">
							<li>
								<div class="tuijian_ico"></div>
								<div class="goods_image">
										<a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300 }_285x285.jpg" width="285px" height="285px" alt="${g.name}" /></a>
								</div>
								<div class="goods_text_info">
									<p class="text_price">
										<font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font>
									</p>
									<div>
										<h3 class="text_name">
											<a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a>
										</h3>
									</div>
									<p class="text_down">
										<a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a>
									</p>
								</div>
							</li>
						</c:forEach>
					</ul>
			</div>
		</div>
	</div>
	
	<!-- 3F童装 -->
	<div class="goods_cate_block">
		<div class="goods_block_title">
			<div class="block_title nantongzhuang"></div>
		</div>
		<div class="goods_block">
			<div class="inner_inside">
				<ul class="cate_block_ul">
						<c:forEach items="${childrenDress }" var="g">
							<li>
								<div class="tuijian_ico"></div>
								<div class="goods_image">
									<a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300 }_285x285.jpg" width="285px" height="285px" alt="${g.name}" /></a>
								</div>
								<div class="goods_text_info">
									<p class="text_price">
										<font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font>
									</p>
									<div>
										<h3 class="text_name">
											<a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a>
										</h3>
									</div>
									<p class="text_down">
										<a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a>
									</p>
								</div>
							</li>
						</c:forEach>
					</ul>
			</div>
		</div>
	</div>
	
	<!-- 4F女鞋 -->
	<div class="goods_cate_block">
		<div class="goods_block_title">
			<div class="block_title nvxie"></div>
		</div>
		<div class="goods_block">
			<div class="inner_inside">
				<ul class="cate_block_ul">
						<c:forEach items="${womanShoes }" var="g">
							<li>
								<div class="tuijian_ico"></div>
								<div class="goods_image">
									<a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300 }_285x285.jpg" width="285px" height="285px" alt="${g.name}" /></a>
								</div>
								<div class="goods_text_info">
									<p class="text_price">
										<font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font>
									</p>
									<div>
										<h3 class="text_name">
											<a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a>
										</h3>
									</div>
									<p class="text_down">
										<a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a>
									</p>
								</div>
							</li>
						</c:forEach>
					</ul>
			</div>
		</div>
	</div>
	
	<!-- 5F男鞋 -->
	<div class="goods_cate_block">
		<div class="goods_block_title">
			<div class="block_title nanxie"></div>
		</div>
		<div class="goods_block">
			<div class="inner_inside">
				<ul class="cate_block_ul">
						<c:forEach items="${manShoes }" var="g">
							<li>
								<div class="tuijian_ico"></div>
								<div class="goods_image">
									<div>
										<a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300 }_285x285.jpg" width="285px" height="285px" alt="${g.name}" /></a>
									</div>
								</div>
								<div class="goods_text_info">
									<p class="text_price">
										<font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font>
									</p>
									<div>
										<h3 class="text_name">
											<a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a>
										</h3>
									</div>
									<p class="text_down">
										<a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a>
									</p>
								</div>
							</li>
						</c:forEach>
					</ul>
			</div>
		</div>
	</div>
	
	<!-- 6F童鞋 -->
	<div class="goods_cate_block">
		<div class="goods_block_title">
			<div class="block_title tongxie"></div>
		</div>
		<div class="goods_block">
			<div class="inner_inside">
				<ul class="cate_block_ul">
						<c:forEach items="${childrenShoes }" var="g">
							<li>
								<div class="tuijian_ico"></div>
								<div class="goods_image">
									<a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300 }_285x285.jpg" width="285px" height="285px" alt="${g.name}" /></a>
								</div>
								<div class="goods_text_info">
									<p class="text_price">
										<font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font>
									</p>
									<div>
										<h3 class="text_name">
											<a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a>
										</h3>
									</div>
									<p class="text_down">
										<a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a>
									</p>
								</div>
							</li>
						</c:forEach>
					</ul>
			</div>
		</div>
	</div>

<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
	var zhigu = {};
}

//点击显示分享框
function fenXiangUl(_obj)
{
	$(_obj).find('.fenxiang_ul_box').show();
	$(_obj).find('.fenxiang_ul_box_bg').show();
}

//自定义效果
$(document).ready(function() {
	//买家入门-卖家入门-tab切换方法
	$('#new_tabs_ul').find('li').click(function(e) {
		if (e.target == this) {
			var tabs = $('#new_tabs_ul').find('li');
			var panels = $('#new_tabs_list').find('span');
			var index = $.inArray(this, tabs);
			if (panels.eq(index)[0]) {
				tabs.removeClass('news_tabs_selectd').eq(index).addClass('news_tabs_selectd');
				panels.addClass('disnone').eq(index).removeClass('disnone');
			}
		}
	});
	
	// 分享控制
	$(".fenxiang_ul_box_bg").css("height","0px");
	$(".fenxiang_ul").hide();
	
	$(".add_fen").click(function(){
		$(".fenxiang_ul_box").show();
		$(".fenxiang_ul").show();
		$(".fenxiang_ul_box_bg").css("height","107px");
	}).mouseover(function(){
		$(".fenxiang_ul_box_bg").css("height","0px");
	});
	
	$(".fenxiang_ul_box_bg,.goods_text_info").mouseover(function(){
		$(".fenxiang_ul_box_bg").css("height","0px");
		$(".fenxiang_ul_box").hide();
		$(".fenxiang_ul").hide();
	});
	
	$(".fenxiang_ul").mouseover(function(){
		$(".fenxiang_ul_box_bg").css("height","107px");
		$(".fenxiang_ul_box").show();
		$(".fenxiang_ul").show();
	});
	
	// 收藏
	$(".add_fav").click(function(){
		var goodsId = $(this).attr("data");
		favoGoods(goodsId);
	});
	
	//移除隐藏分享框
	$('.goods_image').hover(
			function(){},
			function(){
					$(this).find('.fenxiang_ul_box').hide();
					$(this).find('.fenxiang_ul_box_bg').hide();
				}
			);

	//热销排行聚焦切换
	$('#hotpaihang_list').find('li').mouseover(function(){
			$('#hotpaihang_list').find('li').removeClass('rexiao_selectd_line').addClass('rexiao_gen_line');
			$(this).addClass('rexiao_selectd_line').removeClass('rexiao_gen_line');
		});
		
	
			
	//初始化每个产品分享链接和标题
	$(".goodsListBoxes").each(function(){
		$(this).mouseenter(function(){
			var share =  $(this).find(".fengXiangButtonDiv");
			jiathis_config={ 
					url: "http://www.zhiguw.com/"+share.attr("shareurl"), 
					title: share.attr("sharetitle"), 
					summary:share.attr("sharetitle"),
				} 
		});
	});
	

	
	// 分享代码
	var shareid = "fenxiang";
	var shareURL = "";
	var shareTitle = "";
	var shareContent = "";
	// jiathis分享
	var jiathis_config ={};
	(function() {
		var a = {
			url:function() {
				return encodeURIComponent(shareURL)
			},title:function() {
				return encodeURIComponent(shareTitle)
			},content:function(d) {
					if(shareContent){
						return encodeURIComponent(shareContent)
					}
					return encodeURIComponent(shareTitle)
			},setid:function() {
				if (typeof(shareid) == "undefined") {
					return null
				} else {
					return shareid
				}
			},kaixin:function() {
				window.open("http://www.kaixin001.com/repaste/share.php?rtitle=" + this.title() + "&rurl=" + this.url() + "&rcontent=" + this.content(this.setid()))
			},renren:function() {
				window.open("http://share.renren.com/share/buttonshare.do?link=" + this.url() + "&title=" + this.title())
			},sinaminiblog:function() {
				window.open("http://v.t.sina.com.cn/share/share.php?url=" + this.url() + "&title=" + this.title() + "&content=utf-8&source=&sourceUrl=&pic=")
			},baidusoucang:function() {
				window.open("http://cang.baidu.com/do/add?it=" + this.title() + "&iu=" + this.url() + "&dc=" + this.content(this.setid()) + "&fr=ien#nw=1")
			},taojianghu:function() {
				window.open("http://share.jianghu.taobao.com/share/addShare.htm?title=" + this.title() + "&url=" + this.url() + "&content=" + this.content(this.setid()))
			},wangyi:function() {
				window.open("http://t.163.com/article/user/checkLogin.do?source=%E7%BD%91%E6%98%93%E6%96%B0%E9%97%BB%20%20%20&link=" + this.url() + "&info=" + this.content(this.setid()))
			},qqzone:function() {
				window.open('http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=' + this.url() + '&title=' + this.title())
			},pengyou:function() {
				window.open('http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?to=pengyou&url=' + this.url() + '&title=' + this.title())
			},douban:function() {
				window.open("http://www.douban.com/recommend/?url=" + this.url() + "&title=" + this.title() + "&v=1")
			},qqweibo:function(){
				 var _t = encodeURI(shareTitle);
					var _url = encodeURI(shareURL);
					var _appkey = encodeURI("appkey");
					var _u = 'http://v.t.qq.com/share/share.php?title=' + _t + '&url=' + _url + '&appkey=' + _appkey;
					window.open(_u);
			}};
		window.share = a
	})();
	
	$(function() {
		$(".renren").click(function() {
			setShare(this);
			share.renren();
		});
		$(".xinlang").click(function() {
			setShare(this);
			share.sinaminiblog();
		});
		$(".douban").click(function() {
			setShare(this);
			share.douban();
		});
		$(".kaixin").click(function() {
			setShare(this);
			share.kaixin();
		});
		$(".taojianghu").click(function() {
			setShare(this);
			share.taojianghu();
		});
		$(".wangyi").click(function() {
			setShare(this);
			share.wangyi();
		});
		$(".qqzone").click(function() {
			setShare(this);
			share.qqzone();
		});
		$(".baidusoucang").click(function() {
			setShare(this);
			share.baidusoucang();
		});
		$(".tengxunweibo").click(function() {
			setShare(this);
			share.qqweibo();
		});
		$(".qqpengyou").click(function() {
			setShare(this);
			share.pengyou();
		});
	});
	function setShare(obj){
		shareURL =  "http://www.zhiguw.com/"+$(obj).parent().parent().parent().attr("shareurl");
		shareTitle ="【智谷同城货源网】"+ $(obj).parent().parent().parent().attr("sharetitle");
	}
});
// 主flash图
zhigu.slidesStart = function(){
	var numpic = $('#slides li').size()-1;
	var nownow = 0;
	var inout = 0;
	var TT = 0;
	var SPEED = 3000;

	$('#slides li').eq(0).siblings('li').css({'display':'none'});

	var ulstart = '<ul id="pagination">',
		ulcontent = '',
		ulend = '</ul>';
	ADDLI();
	var pagination = $('#pagination li');
	var paginationwidth = $('#pagination').width();
	//$('#pagination').css('margin-left',(470-paginationwidth))
	pagination.eq(0).addClass('current')
	function ADDLI(){
		//var lilicount = numpic + 1;
		for(var i = 0; i <= numpic; i++){
			ulcontent += '<li>' + '<a href="javascript:void(0);">' + (i+1) + '</a>' + '</li>';
		}
		$('#slides').after(ulstart + ulcontent + ulend);	
	}
	pagination.on('click',DOTCHANGE)
	function DOTCHANGE(){
		var changenow = $(this).index();
		$('#slides li').eq(nownow).css('z-index','900');
		$('#slides li').eq(changenow).css({'z-index':'800'}).show();
		pagination.eq(changenow).addClass('current').siblings('li').removeClass('current');
		$('#slides li').eq(nownow).fadeOut(400,function(){$('#slides li').eq(changenow).fadeIn(500);});
		nownow = changenow;
	}
	pagination.mouseenter(function(){
		inout = 1;
	})
	pagination.mouseleave(function(){
		inout = 0;
	})
	function GOGO(){
		var NN = nownow+1;
		if( inout == 1 ){
			} else {
			if(nownow < numpic){
			$('#slides li').eq(nownow).css('z-index','900');
			$('#slides li').eq(NN).css({'z-index':'800'}).show();
			pagination.eq(NN).addClass('current').siblings('li').removeClass('current');
			$('#slides li').eq(nownow).fadeOut(400,function(){$('#slides li').eq(NN).fadeIn(500);});
			nownow += 1;
		}else{
			NN = 0;
			$('#slides li').eq(nownow).css('z-index','900');
			$('#slides li').eq(NN).stop(true,true).css({'z-index':'800'}).show();
			$('#slides li').eq(nownow).fadeOut(400,function(){$('#slides li').eq(0).fadeIn(500);});
			pagination.eq(NN).addClass('current').siblings('li').removeClass('current');

			nownow=0;

			}
		}
		TT = setTimeout(GOGO, SPEED);
	}
	TT = setTimeout(GOGO, SPEED); 
}
</script>

<script type="text/javascript">
$(function(){
	  $.getJSON("help/home/cementcontents?type=1",function(msgBean){
 	 var html="";
 	for(var i=0;i<msgBean.data.length;i++){
 	   html+="<li><a href=\"/help/showComment?id="+msgBean.data[i].id+"\" target=\"_blank\">"+msgBean.data[i].title+"</a></li>"
 	}
 	$("#cementType1").html(html);
 })

 $.getJSON("help/home/cementcontents?type=3",function(msgBean){
 	 var html="";
 	for(var i=0;i<msgBean.data.length;i++){
 	   html+="<li><a href=\"/help/showComment?id="+msgBean.data[i].id+"\" target=\"_blank\">"+msgBean.data[i].title+"</a></li>"
 	}
 	$("#cementType3").html(html);
 })

	  $.getJSON("help/home/cementcontents?type=5",function(msgBean){
 	 var html="";
 	for(var i=0;i<msgBean.data.length;i++){
 	   html+="<li><a href=\"/help/showComment?id="+msgBean.data[i].id+"\" target=\"_blank\" >"+msgBean.data[i].title+"</a></li>"
 	}
 	$("#cementType5").html(html);
 })

})
</script>

	<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1" charset="utf-8"></script>

</body>
</html>
