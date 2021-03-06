<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html>
<head>

<title>店铺商品</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<!--** 通知 **-->
<div class="tongZhi hidden">
  <div class="tzTitle">通知</div>
  <div class="tzBox">
    <p>test</p>
  </div>
  <span id="closeTZ" title="关闭通知">╳</span> </div>

<!--** 商家筛选条 **-->
<div class="sortShopBar">
  <div class="bsbSort">
    <div class="bsbSortDiv" style="width:50px">
      <div>排序</div>
    </div>
    <div class="bsbSortDiv">
      <div>销售量</div>
      <div> <span class="${gc.sort == 1 ? 'sortUp_2' : 'sortUp_1'}"  onclick="zhigu.storeGoods(1,1)"></span> <span class="${gc.sort == 2 ? 'sortDown_2' : 'sortDown_1'}" onclick="zhigu.storeGoods(1,2)"></span> </div>
    </div>
    <div class="bsbSortDiv">
      <div>下载量</div>
      <div> <span class="${gc.sort == 5 ? 'sortUp_2' : 'sortUp_1'}"  onclick="zhigu.storeGoods(1,5)"></span> <span class="${gc.sort == 6 ? 'sortDown_2' : 'sortDown_1'}" onclick="zhigu.storeGoods(1,6)"></span> </div>
    </div>
    <div class="bsbSortDiv hidden">
      <div>人气</div>
      <div> <span class="${gc.sort == 3 ? 'sortUp_2' : 'sortUp_1'}"  onclick="zhigu.storeGoods(1,3)"></span> <span class="${gc.sort == 4 ? 'sortDown_2' : 'sortDown_1'}" onclick="zhigu.storeGoods(1,4)"></span> </div>
    </div>
    <div class="bsbSortDiv">
      <div>时间</div>
      <div> <span class="${gc.sort == 9 ? 'sortUp_2' : 'sortUp_1'}"  onclick="zhigu.storeGoods(1,9)"></span> <span class="${gc.sort == 10 ? 'sortDown_2' : 'sortDown_1'}" onclick="zhigu.storeGoods(1,10)"></span> </div>
    </div>
    <div class="bsbSortDiv">
      <div>价格</div>
      <div> <span class="${gc.sort == 7 ? 'sortUp_2' : 'sortUp_1'}"  onclick="zhigu.storeGoods(1,7)"></span> <span class="${gc.sort == 8 ? 'sortDown_2' : 'sortDown_1'}" onclick="zhigu.storeGoods(1,8)"></span> </div>
    </div>
  </div>
</div>

<!--** 商家商品列表 **-->
<div class="shopGoodsListBox">
  <div class="sglbInside">
    <c:forEach items="${page.datas }" var="g">
      <div class="goodsListBoxes">
        <div id="listImgBox">
          <div><a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="http://www.zhiguw.com/${g.image300 }" width="220" height="220" /></a></div>
        </div>
        <h3> <a href="goods/detail?goodsId=${g.id}" title="${g.name }" target="_blank">
          <c:if test="${fn:length(g.name) > 28 }"> ${fn:substring(g.name,0,27) }... </c:if>
          <c:if test="${fn:length(g.name) < 28 }"> ${g.name } </c:if>
          </a> </h3>
        <p>价格：<font color="#ff3300"><strong>￥</strong></font><font color="#ff3300" size="+1"><strong>${g.minPrice }</strong></font> <span>下载次数<font color="#0C8B0C"> ${g.aux.downloadCount } </font></span></p>
      </div>
    </c:forEach>
  </div>
  <div class="clear"></div>
  <div class="ddpage fr mt20">
    <jsp:include page="../../include/page.jsp">
    <jsp:param name="request" value="function"/>
    <jsp:param name="functionName" value="storeGoods"/>
    </jsp:include>
  </div>
</div>
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
	var zhigu = {};
}
zhigu.storeGoods = function(pageNo,sort){
	if(!sort)sort = "${gc.sort }";
	if(!pageNo)pageNo=1;
	window.location.href = "/store/index?storeId=${store.ID}"+(sort?("&sort="+sort):"")+"&pageNo="+pageNo;
}
//隐藏主导航和搜索框
$('.nav').hide();
$('.search').remove();
</script>
</body>
</html>