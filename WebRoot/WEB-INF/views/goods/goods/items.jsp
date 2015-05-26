<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="sglbInside">
	<c:forEach items="${page.datas }" var="g">
		<div class="goodsListBoxes">
			<div id="listImgBox">
				<%--<div class="fengXiangDivOut">
				 	<div class="fenXiangDiv">
						<ul class="fenXiangTopUl" onmouseout="hideFenXiangBox(this)">
							<li class="addFavDiv" onclick="favoGoods(${g.id})"><a
								href="javascript:void(0)">收藏</a></li>
							<!-- <li class="addFenXiang" onclick="showFenXiangBox(this)">分享 -->
								<ul class="fengXiangButtonDiv"
									shareurl="goods/detail?goodsId=${g.id}" sharetitle="${g.name}">
									<li><a title="分享到微信" class="jiathis_button_weixin"><span
											class="weixin"></span></a></li>
									<li><a title="分享到腾讯微博" href="javascript:void(0)"><span
											class="tengxunweibo"></span></a></li>
									<li><a title="分享到新浪微博" href="javascript:void(0);"><span
											class="xinlang"></span></a></li>
									<li><a title="分享到网易微博" href="javascript:void(0);"><span
											class="wangyi"></span></a></li>
									<li><a title="分享到Qzone空间" href="javascript:void(0);"><span
											class="qqzone"></span></a></li>
									<li><a title="分享到朋友社区" href="javascript:void(0);"><span
											class="qqpengyou"></span></a></li>
									<li><a title="分享到人人网" href="javascript:void(0);"><span
											class="renren"></span></a></li>
									<li><a title="分享到开心网" href="javascript:void(0);"><span
											class="kaixin"></span></a></li>
									<li><a title="分享到淘江湖" href="javascript:void(0);"><span
											class="taojianghu"></span></a></li>
									<li><a title="分享到豆瓣" href="javascript:void(0);"><span
											class="douban"></span></a></li>
									<li><a title="分享到百度收藏" href="javascript:void(0);"><span
											class="baidusoucang"></span></a></li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="fenXiangDivBg"></div>
				</div> --%>
				<div class="goodsTagDiv">
					<!-- 推荐图标 -->
				</div>
				<div>
					<a href="goods/detail?goodsId=${g.id}" target="_blank"><img
						src="${g.image300 }" width="220" height="220" /></a>
				</div>
			</div>
			<h4>
				<a href="goods/detail?goodsId=${g.id}" title="${g.itemNo }"
					target="_blank" class="ellipsis">${g.itemNo == null?g.name:g.itemNo } </a>
			</h4>
			<p>
				单价：<font color="#ff3300">￥</font><font color="#ff3300" size="+1"><strong>${g.minPrice }</strong></font>
				<span><a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a></span>
			</p>
		</div>
	</c:forEach>
</div>
<div class="clear"></div>
<script type="text/javascript">

$(function(){
	$(".addFenXiang").mouseleave(function(){
		$(".fengXiangButtonDiv").hide();
	});
});

if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}
zhigu.pageNo = "${page.pageNo}";
zhigu.totalPage = "${page.totalPage}";
</script>

