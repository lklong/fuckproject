<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<jsp:include page="header.jsp"/>
<!--** 通知 **-->
<div class="tongZhi disnone">
	<div class="tzTitle">通知</div>
    <div class="tzBox">
    	<p>会上，全国公安系统100个爱民模范集体和100名爱民模范受到表彰。<br />2014年10月28日 19:06:40 </p>
    </div>
    <span id="closeTZ" title="关闭通知">╳</span>
</div>

<!--** 商家筛选条 **-->
<div class="sortShopBar">
	<div class="bsbSort">
       	<div class="bsbSortDiv" style="width:50px">
           	<div>排序</div>
           </div>
           <div class="bsbSortDiv">
           	<div>销售量</div>
               <div>
               	<span class="${gc.sort == 1 ? 'sortUp_2' : 'sortUp_1'}"  onclick="javascript:search(1)"></span>
               	<span class="${gc.sort == 2 ? 'sortDown_2' : 'sortDown_1'}" onclick="javascript:search(2)"></span>
               </div>
           </div>
           <div class="bsbSortDiv">
           	<div>下载量</div>
               <div>
               	<span class="${gc.sort == 5 ? 'sortUp_2' : 'sortUp_1'}"  onclick="javascript:search(5)"></span>
               	<span class="${gc.sort == 6 ? 'sortDown_2' : 'sortDown_1'}" onclick="javascript:search(6)"></span>
               </div>
           </div>
           <div class="bsbSortDiv">
           	<div>人气</div>
               <div>
               	<span class="${gc.sort == 3 ? 'sortUp_2' : 'sortUp_1'}"  onclick="javascript:search(3)"></span>
               	<span class="${gc.sort == 4 ? 'sortDown_2' : 'sortDown_1'}" onclick="javascript:search(4)"></span>
               </div>
           </div>
           <div class="bsbSortDiv">
           	<div>时间</div>
               <div>
               	<span class="${gc.sort == 9 ? 'sortUp_2' : 'sortUp_1'}"  onclick="javascript:search(9)"></span>
               	<span class="${gc.sort == 10 ? 'sortDown_2' : 'sortDown_1'}" onclick="javascript:search(10)"></span>
               </div>
           </div>
           <div class="bsbSortDiv">
           	<div>价格</div>
               <div>
               	<span class="${gc.sort == 7 ? 'sortUp_2' : 'sortUp_1'}"  onclick="javascript:search(7)"></span>
               	<span class="${gc.sort == 8 ? 'sortDown_2' : 'sortDown_1'}" onclick="javascript:search(8)"></span>
               </div>
           </div>
       </div>
</div>

<!--** 商家商品列表 **-->
<div class="shopGoodsListBox">
    <div class="sglbInside">
		<c:forEach items="${page.datas }" var="g">
			<div class="goodsListBoxes">
		    	<div id="listImgBox">
		        	<div class="fengXiangDivOut">
		                <div class="fenXiangDiv">
		                	<ul class="fenXiangTopUl">
		                        <li class="addFavDiv" onclick="favoGoods(${g.id})"><a href="javascript:void(0)">收藏</a></li>
		                        <li class="addFenXiang" onclick="showFenXiangBox(this)" >
		                        	分享
		                            <ul class="fengXiangButtonDiv">
		                                <li><a title="复制链接" href="javascript:void(0)" onclick="copyLink()"><span class="copylink"></span></a></li>
		                                <li><a title="分享到腾讯微博" href="javascript:void(0)" onclick="postToWb();"><span class="tengxunweibo"></span></a></li>
		                                <li><a title="分享到新浪微博" href="javascript:void(0);"><span class="xinlang"></span></a></li>
		                                <li><a title="分享到搜狐微博" href="javascript:void((function(s,d,e,r,l,p,t,z,c){var f='http://t.sohu.com/third/post.jsp?',u=z||d.location,p=['&url=',e(u),'&title=',e(t||d.title),'&content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a(){if(!window.open([f,p].join(''),'mb',['toolbar=0,status=0,resizable=1,width=660,height=470,left=',(s.width-660)/2,',top=',(s.height-470)/2].join('')))u.href=[f,p].join('');};if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent,'','','','','','utf-8'));"><span class="sohu"></span></a></li>
		                                <li><a title="分享到网易微博" href="javascript:void(0);"><span class="wangyi"></span></a></li>
		                                <li><a title="分享到Qzone空间" href="javascript:void(0);"><span class="qqzone"></span></a></li>
		                                <li><a title="分享到朋友社区" href="javascript:void(0);"><span class="qqpengyou"></span></a></li>
		                                <li><a title="分享到人人网" href="javascript:void(0);"><span class="renren"></span></a></li>
		                                <li><a title="分享到开心网" href="javascript:void(0);"><span class="kaixin"></span></a></li>
		                                <li><a title="分享到淘江湖" href="javascript:void(0);"><span class="taojianghu"></span></a></li>
		                                <li><a title="分享到豆瓣" href="javascript:void(0);"><span class="douban"></span></a></li>
		                                <li><a title="分享到百度收藏" href="javascript:void(0);"><span class="baidusoucang"></span></a></li>
		                            </ul>
		                        </li>
		                    </ul>
		                </div>
		                <div class="fenXiangDivBg"></div>
		            </div>
		            <%-- <div class="goodsTagDiv"><img src="img/rmtuihon.png" height="43" width="42" /></div> --%>
		        	<div><a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="http://www.zhiguw.com/${g.image300 }" width="220" height="220" /></a></div>
		        </div>
		        <h3>
		       		<a href="goods/detail?goodsId=${g.id}" title="${g.name }" target="_blank">
						<c:if test="${fn:length(g.name) > 28 }">
							${fn:substring(g.name,0,27) }...
						</c:if>
						<c:if test="${fn:length(g.name) < 28 }">
							${g.name }
						</c:if>
					</a>
		        </h3>
		        <p>价格：<font color="#ff3300"><strong>￥</strong></font><font color="#ff3300" size="+1"><strong>${g.minPrice }</strong></font>
		        <span>下载次数<font color="#0C8B0C"> ${g.aux.downloadCount } </font></span></p>
		    </div>
		</c:forEach>
	</div>
	<div class="clear"></div>
	<div class="ddpage fr mt20">
		<jsp:include page="../../include/page.jsp">
			<jsp:param name="request" value="form"/>
			<jsp:param name="requestForm" value="storeHomeForm"/>
		</jsp:include>
	</div>
</div>
<form action="store/index?storeId=${store.ID}" id="storeHomeForm" method="post">
	<input type="hidden" name="sort" id="sort" value="${gc.sort }">
</form>
<script type="text/javascript">
function search(sort){
	$("#sort").val(sort);
	$("#storeHomeForm").submit();
}
$(function(){
	$(".addFenXiang").mouseleave(function(){
		$(".fengXiangButtonDiv").hide();
	});
});
</script>
</body>
</html>