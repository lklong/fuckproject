<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>积分商品</title>
</head>
<body>
<!-- //功能条// -->
<div class="sysContBar">
	<div class="sysCBBox"><input class="sysSubmit" type="button" value="新增" onclick="location.href='admin/goods/pointGoodsAddPage'" /></div>
</div>
<table class="sysCommonTable" cellspacing="0" cellpadding="0">
	<tr >
		<th>商品名</th>
		<th>所需积分</th>
		<th>真实价值</th>
		<th>发布时间</th>
		<th>库存</th>
		<th>图片</th>
		<th>操作</th>
	</tr>
	<c:forEach var="item" items="${ pointExchangeGoodsList  }">
		<tr >
			<td>${item.name }</td>
			<td>${item.needPoint }</td>
			<td>${item.money }</td>
			<td><fmt:formatDate value="${item.addTime  }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td>${ item.repertory}</td>
			<td><img src="${item.picture}" height="70" width="70" /></td>
			
			<td id="statusTd${shortcutgoods.id }"  >
				<a href="javascript:void(0);" onclick="zhigu.pointGoods.updatePage( '${ item.id }' )" class="sysButonA2"><em></em>修改</a>
				
				<c:if test="${item.status == 1 }">
					<a href="javascript:void(0);" onclick="zhigu.pointGoods.changeStatus( '${ item.id}', 0 )" class="sysButonA4">	<em></em>下架</a>
				</c:if>
				<c:if test="${item.status == 0 }">
					<a href="javascript:void(0);" onclick="zhigu.pointGoods.changeStatus( '${ item.id}', 1 )" class="sysButonA3"><em></em>上架</a>
				</c:if>
			</td>
		</tr>
	</c:forEach>
</table>
<div class="dataPager">
<div class="ddpage fr mr20">
	<jsp:include page="../../../include/page.jsp" >
		<jsp:param name="request" value="url"/>
		<jsp:param name="requestUrl" value="/admin/goods/pointGoods"/>
	</jsp:include>
</div>
</div>
	<script>
			zhigu.pointGoods = {};
			zhigu.pointGoods.changeStatus = function( id ,status ){
				ajaxSubmit("/admin/goods/pointGoodsChange", {"id":id,"status":status} , 
						function( data  ){
							if( data.code = 1 ){
								alert(data.msg );
								location.reload() 
							}else{
								alert(data.msg );		
							}
						
						}
						, "json", true );
				
			}
			zhigu.pointGoods.updatePage = function( id ){
				location.href='admin/goods/pointGoodsUpdatePage?id='+ id;
			}
			
	
	
	
	</script>
</body>
</html>