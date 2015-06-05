<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>收藏的商品</title>
<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">收藏的商品</h4>
  <div class="fun-bar">
    <ul class="fun-tabs">
      <li><a href="javascript:void(0);">收藏的商品</a></li>
      <li><a href="/user/favourite/favouritestore" >收藏的店铺</a></li>
    </ul>
  </div>
  <h4 class="ddtitle">全部<span class="color-red" id="num">${fn:length(goodsList) }</span></h4>
  <div class="fun-bar">
    <span><input type="checkbox" id="deletshou" /></span>
    <span><label for="deletshou">全选</label></span>
    <span class="ml10"><a href="javascript:;" onclick="zhigu.delFavouriteGoods();">删除</a></span></div>
  <div id="showNo">
    <c:if test="${empty goodsList }"><strong class="color-red">暂无收藏！</strong></c:if>
    <div class="scshangpin" id="scshangpin">
      <ul class="fav-shop-right" style="width:100%;">
        <c:forEach var="goods" items="${ goodsList}">
          <li class="${goods.id}">
            <p><a target="_blank" href="goods/detail?goodsId=${goods.id}"> <img height="115" width="115" src="${goods.image300}" title="${goods.name}" /></a></p>
            <p class="word-overflow">
              <input type="checkbox" class="ver_ali " name="goodsID" value="${goods.id }" />
              <a target="_blank" href="goods/detail?goodsId=${goods.id}">${goods.name}</a></p>
            <p><span class="color-red">￥${goods.minPrice }-￥${goods.maxPrice }</span></p>
            <p> <a target="_blank" href="goods/detail?goodsId=${goods.id}" title="立即购买"></a> <a target="_blank" href="store/index?storeId=${goods.storeId}" title="进入店铺" class="icon2"></a> <a onclick="zhigu.delFavouriteGoods(${goods.id });" title="删除"></a> </p>
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
		$(function() {
			$("#deletshou").click(function() {
				if ($("#deletshou").is(":checked")) {
					$("#scshangpin input:checkbox").attr("checked", true);
				} else {
					$("#scshangpin input:checkbox").attr("checked", false);
				}
			});
		})
		zhigu.delFavouriteGoods = function(goodId){
			var goodIds = [];
			if(isNaN(goodId)){
				$("#scshangpin input[type='checkbox']:checked").each(function(){
					goodIds.push($(this).val());
				});
			}else{
				goodIds.push(goodId);
			}
			if(goodIds.length>0){
				ajaxSubmit("user/favourite/delFavouriteGoods",{"goodsID":goodIds},function(msgBean){
					if(msgBean.code==zhigu.code.success){
	       				layer.msg(msgBean.msg);
	       		        $.each(goodIds,function(n,value){
	       		        	var num=parseInt($("#num").html())-1;
	       		        	$("#num").html(num);
	       		         	$("."+value).remove();
	       		         	if(num == 0){
	       		         		$("#showNo").html("<strong class='color-red'>暂无收藏！</strong>");
	       		         	}
	       		        });
		       	  }else{
		       		  layer.alert(msgBean.msg);  
		       	  }
				});
			}
		}
	</script>
</body>
</html>