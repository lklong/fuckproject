<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>出售中的商品</title>
<script type="text/javascript" src="/js/3rdparty/layer/layer.min.js?v=20150505"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">出售中的商品</h4>
  <div class="fun-bar">
    <ul class="fun-tabs">
      <li><a href="supplier/goods/add">商品发布</a></li>
      <li><a href="supplier/goods/list?status=1" <c:if test="${gc.status == 1 }">class="sected"</c:if>>出售中的商品</a></li>
      <li><a href="supplier/goods/list?status=2" <c:if test="${gc.status == 2 }">class="sected"</c:if>>下架的商品</a></li>
    </ul>
  </div>
  <table cellpadding="0" cellspacing="0" class="user-list-table">
    <tr>
      <th>宝贝名称 </th>
      <th>价格</th>
      <th>库存</th>
      <th>发布时间</th>
      <th>操作</th>
    </tr>
    <c:forEach items="${page.datas }" var="item">
      <tr>
        <td style="width:35%"><span class="fl"> <a target="_blank" href="goods/detail?goodsId=${item.id}"><img height="50" width="50" src="${item.image300}" /></a> </span><span class="fl mt15 ml5"><a href="goods/detail?goodsId=${item.id}" target="_blank">${item.name }</a> </span></td>
        <td style="width:10%">￥${item.minPrice }-￥${item.maxPrice }</td>
        <td style="width:10%">${item.aux.amount < 0 ? '-' : item.aux.amount }</td>
        <td style="width:10%"><fmt:formatDate value="${item.time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
        <td style="width:35%"><span><a href="javascript:void(0);" class="default-a" onclick="refresh(${item.id})" >刷新商品</a></span> <span><a href="supplier/goods/edit?goodsId=${item.id}" class="default-a">编辑商品</a></span> <span><a href="javascript:void(0);" class="default-a" onclick="soldout(${item.id},${gc.status == 1 ? 2 : 1});">
          <c:choose>
            <c:when test="${gc.status == 1 }">商品下架</c:when>
            <c:when test="${gc.status == 2 }">商品上架</c:when>
          </c:choose>
          </a></span> <span><a href="javascript:void(0);" class="default-a" onclick="delGoods(${item.id});">删除商品</a></span></td>
      </tr>
    </c:forEach>
  </table>
  <div class="ddpage fr mt20">
    <jsp:include page="../../include/page.jsp">
    <jsp:param name="request" value="url"/>
    <jsp:param name="requestUrl" value="supplier/goods/list?status=${gc.status }"/>
    </jsp:include>
  </div>
</div>
<script>
function soldout(goodsId,status){
	var tips = "确认上架此商品？";
	if(status == 2)
		tips = "确认下架此商品？";
	
	layer.confirm(tips,function(){
		$.post("supplier/goods/soldOut",{"goodsId":goodsId},function(msgBean){
			if(msgBean.code==zhigu.code.success){
				layer.msg(msgBean.msg,2,reloadCurrentPage);
			}else{
				layer.alert(msgBean.msg);
			}
		});
	});
}
/**
 * 刷新
 */
function refresh(goodsID){
	ajaxSubmit("supplier/goods/refresh", {"goodsID":goodsID}, function(msgBean){
		if(msgBean.code==zhigu.code.success){
			layer.msg(msgBean.msg, 1, reloadCurrentPage);
		}else{
			layer.alert(msgBean.msg);
		}
	});
}

function delGoods(goodsID){
	layer.confirm("确定要删除该商品？",function(){
		$.post("supplier/goods/delGoods",{"goodsID":goodsID},function(msgBean){
			if(msgBean.code==zhigu.code.success){
				layer.msg(msgBean.msg,2,reloadCurrentPage);
			}else{
				layer.alert(msgBean.msg);
			}
		});
	});
}
</script>
</body>
</html>