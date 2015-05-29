<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="sglbInside">
  <c:forEach items="${page.datas }" var="g">
    <div class="goodsListBoxes">
      <div id="listImgBox">
        <a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300 }" width="220" height="220" /></a>
      </div>
      <p class="goods-name"> <a href="goods/detail?goodsId=${g.id}" title="${g.itemNo }" target="_blank" class="ellipsis">${g.itemNo == null?g.name:g.itemNo } </a> </p>
      <p> 单价：<font color="#ff3300">￥</font><font color="#ff3300" size="+1"><strong>${g.minPrice }</strong></font> <span><a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a></span> </p>
    </div>
  </c:forEach>
  <br style="clear:both;">
</div>
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}
zhigu.pageNo = "${page.pageNo}";
zhigu.totalPage = "${page.totalPage}";
</script> 