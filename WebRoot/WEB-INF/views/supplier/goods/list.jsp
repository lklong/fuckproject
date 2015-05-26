<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>出售中的商品</title>
</head>
<body>
<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	出售的商品<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">出售的商品</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="body_center2"  id="alldd">
 	<div class="wdddbj over_hid">
         <ul class="allqunbudd over_hid">
             <li><a href="supplier/goods/add">商品发布</a></li>
             <li><a href="supplier/goods/list?status=1" <c:if test="${gc.status == 1 }">class="sected"</c:if>>出售中的商品</a></li>
             <li><a href="supplier/goods/list?status=2" <c:if test="${gc.status == 2 }">class="sected"</c:if>>下架的商品</a></li>
         </ul>          	
     </div>
     <table width="100%" class="f14 tablegysdd mt10 c666" >
         <tr height="40 " class="th1a c333">
             <th width="310">宝贝名称 </th>
             <th width="140">价格</th>    
             <th width="80">库存</th>
             <th width="190">发布时间</th>
             <th>操作</th>
         </tr>
         <c:forEach items="${page.datas }" var="item">
         	<tr class="tr1a">
         		<td class="tl">
         			<div class="fl ml10">
         				<a class="borderImg" target="_blank" href="goods/detail?goodsId=${item.id}">
         					<img height="80" width="80" src="${item.image300}" />
         				</a>
         			</div>
         			<div class="fl ml10 w200 tl" ><a href="goods/detail?goodsId=${item.id}" target="_blank" class="c52a0e5">${item.name }</a></div>
         		</td>
         		<td class="fwryh fwbold c666">￥${item.minPrice }-￥${item.maxPrice }</td>
         		<td>${item.aux.amount < 0 ? '-' : item.aux.amount }</td>
         		<td><fmt:formatDate value="${item.time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
         		<td>
         			<a href="javascript:void(0);" class=" c52a0e5" onclick="refresh(${item.id})" >刷新商品</a>
	         		<br/>
         			<a href="supplier/goods/edit?goodsId=${item.id}" class=" c52a0e5">编辑商品</a>
	         		<br/>
	         		<a href="javascript:void(0);" class="c52a0e5" onclick="soldout(${item.id},${gc.status == 1 ? 2 : 1});">
	         			<c:choose>
	         				<c:when test="${gc.status == 1 }">商品下架</c:when>
	         				<c:when test="${gc.status == 2 }">商品上架</c:when>
	         			</c:choose>
	         		</a>
	         		<br/>
	         		<a href="javascript:void(0);" class="c52a0e5" onclick="delGoods(${item.id});">删除商品</a>
	         		<br/>
	         	</td>
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
     </div>
            <br style="clear:both;" />
        </div>
    </div>

<div class="clear"></div>	
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
