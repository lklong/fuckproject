<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>供应商家</title>
<link href="/css/default/list.css" rel="stylesheet">
<link href="/css/default/shop.css" rel="stylesheet">
<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
</head>
<body>

<!--** 供应商家列表 **-->
<div class="buniesList">
  <div class="buniesInside">
    <div class="buniesLeft">
      <c:forEach items="${page.datas }" var="s">
        <div class="busBoxes">
          <div class="bsbLeftBox">
            <dl>
              <dt><a href="store/index?storeId=${s.ID }"><img src="${s.logoPath}" height="80" width="80" /></a></dt>
            </dl>
               <ul style="width: 220px;">
              <li id="buniesName">
                <h3><a href="store/index?storeId=${s.ID }">${s.storeName }</a></h3>
              </li>
              <li>直达域名：<a style="color: #F00;" href="http://${s.domain }.zhiguw.com">${s.domain }.zhiguw.com</a></li>
              <li>QQ交谈：${s.QQ }
                <c:if test="${not empty s.QQ }"> <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${s.QQ }&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${s.QQ}:52" alt="点这里给我发消息" /></a> </c:if>
              <li>
                <c:if test="${not empty s.aliWangWang }"> 联系旺旺：${s.aliWangWang }<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${s.aliWangWang}&site=cntaobao&s=2&charset=utf-8"><img border="0"
										src="http://amos.im.alisoft.com/online.aw?v=2&uid=${s.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a> </c:if>
              </li>
            </ul>
            <ul class="hiddtext">
              <li>联系手机：${s.phone }</li>
              <li>所在地区：${s.province }${s.city }</li>
              <li>联系地址：${s.district }${s.street }</li>
            </ul>
            <ul style="width: 310px;">
              <li>
                <c:if test="${s.companyAuth==1 }"><span class="rzspan qiye"></span></c:if>
                <c:if test="${s.realStoreAuth==1 }"><span class="rzspan shidi"></span></c:if>
                <c:if test="${s.realUserAuth==1 }"><span class="rzspan shiming"></span></c:if>
              </li>
            </ul>
            <ul class="w200">
              <li><a class="markShopButn" href="store/index?storeId=${s.ID }" target="_blank">进入店铺></a></li>
              <li><a class="markShopButn" href="javascript:favoStore(${s.ID })">收藏店铺</a></li>
            </ul>
          </div>
          <div class="bsbRigthBox">
            <div class="bsbTopInfo"><span class="fl">上架销售<font color="#ff5500"> ${s.commodityOnSaleTotal } </font>件商品</span><span class="fr">最新上架<font color="#ff5500"> ${s.newPurchaseTotal } </font>件商品</span></div>
            <div class="bsbBodyImgs">
              <div class="bsbbiInside">
                <c:forEach items="${s.goods }" var="g">
                  <div class="bsbImgBox">
                    <div><a href="goods/detail?goodsId=${g.id }" target="_blank"><img src="${g.image300 }" height="175" width="175" /></a></div>
                    <br />
                    <p>价格：<font color="#ff4400"><strong>￥${g.minPrice }</strong></font></p>
                    <p style="height:45px;overflow: hidden;"><a href="goods/detail?goodsId=${g.id }" target="_blank">${g.name }</a></p>
                  </div>
                </c:forEach>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
      <div class="ddpage fr mr20">
        <jsp:include page="../include/page.jsp">
        <jsp:param name="request" value="form"/>
        <jsp:param name="requestForm" value="storeSearchForm"/>
        </jsp:include>
      </div>
      <form id="storeSearchForm" action="store/list" method="post">
        <input type="hidden" id="scope" name="scope" value="${scope }">
        <input type="hidden" id="orderBy" name="orderBy" value="${orderBy }">
        <input type="hidden" id="searchStoreName" name="searchStoreName" value="${searchStoreName }">
      </form>
    </div>
    <div class="buniesRight disnone">
      <c:forEach items="${adRight }" var="ad">
        <div class="buniesAdd"><a href="${ad.targetLink }" target="_self"><img src="${ad.image}" title="${ad.title }" style="max-height: 108px;max-width: 275px"/></a></div>
      </c:forEach>
    </div>
  </div>
</div>
<script type="text/javascript" language="javascript">
/* 隐藏网站qq客服*/
$(function(){
	$('#qq_hover').remove();
})
	function searchStore(scope,orderBy){
		window.location.href = "/store/list?scope="+scope+"&orderBy="+orderBy+"&searchStoreName="
	}
	/**
	 * 刷新
	 */
	function refresh(storeId){
		ajaxSubmit("supplier/goods/refresh", {"storeId":storeId}, function(msgBean){
			if(msgBean.code==zhigu.code.success){
				layer.alert(msgBean.msg,reloadCurrentPage);
			}else{
				layer.alert(msgBean.msg);
			}
		});
	}
</script>
</body>
</html>