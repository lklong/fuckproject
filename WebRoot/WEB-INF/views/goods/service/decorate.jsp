<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" media="all" href="css/basic.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/secondCate.css" />
<style type="text/css">
.schecked {
	color: red !important;
}
</style>
<title>网店装修</title>
</head>
<body>
	<%-- <div class="header"><jsp:include page="../../include/logohead.jsp" /></div> --%>
	<!--** 顶部大滚动Banner **-->
	<%-- <div class="topBigBanner disnone"><div class="tbb_insideBlock"></div></div> --%>
<div class="zhuangXiuBox">
	<div class="zhuangXiuBgBox">
		<div class="zhuangxiu_1"></div>
		<div class="zhuangxiu_2"></div>
		<div class="zhuangxiu_3"></div>
		<div class="zhuangxiu_4"></div>
		<div class="zhuangxiu_5"></div>
	</div>
	<div class="zhuangXiuBgBox">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td><img src="/img/photograph/zhangxiu_6.jpg" /></td>
				<td><a href="http://www.zhiguw.com/goods/detail?goodsId=56" target="_blank"><img src="/img/photograph/zhangxiu_7.jpg" /></a></td>
				<td><a href="http://www.zhiguw.com/goods/detail?goodsId=55" target="_blank"><img src="/img/photograph/zhangxiu_8.jpg" /></td>
				<td><a href="http://www.zhiguw.com/goods/detail?goodsId=54" target="_blank"><img src="/img/photograph/zhangxiu_9.jpg" /></td>
				<td><img src="/img/photograph/zhangxiu_10.jpg" /></td>
			</tr>
			<tr>
				<td><img src="/img/photograph/zhangxiu_11.jpg" /></td>
				<td><a href="http://www.zhiguw.com/goods/detail?goodsId=38" target="_blank"><img src="/img/photograph/zhangxiu_12.jpg" /></a></td>
				<td><a href="http://www.zhiguw.com/goods/detail?goodsId=39" target="_blank"><img src="/img/photograph/zhangxiu_13.jpg" /></a></td>
				<td><a href="http://www.zhiguw.com/goods/detail?goodsId=30" target="_blank"><img src="/img/photograph/zhangxiu_14.jpg" /></a></td>
				<td><img src="/img/photograph/zhangxiu_15.jpg" /></td>
			</tr>
		</table>
	</div>
	<div class="zhuangXiuBgBox">
		<div class="zhuangxiu_6"></div>
	</div>
	<div class="zhuangXiuBgBox">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td><img src="/img/photograph/zhangxiu_17.jpg" /></td>
				<td><a href="http://www.zhiguw.com/goods/detail?goodsId=31" target="_blank"><img src="/img/photograph/zhangxiu_18.jpg" /></td>
				<td><a href="http://www.zhiguw.com/goods/detail?goodsId=32" target="_blank"><img src="/img/photograph/zhangxiu_19.jpg" /></td>
				<td><a href="http://www.zhiguw.com/goods/detail?goodsId=30" target="_blank"><img src="/img/photograph/zhangxiu_20.jpg" /></td>
				<td><img src="/img/photograph/zhangxiu_21.jpg" /></td>
			</tr>
		</table>
	</div>
	<div class="zhuangXiuBgBox">
		<div class="zhuangxiu_7"></div>
	</div>
	<!--** 商品筛选条 **-->
	<div class="sreeningBar">
		<div class="sb_left" id="searchCondition">
			<c:forEach items="${properties }" var="p">
				<p><b>${p.name }</b>：&nbsp;
					<a value="" class="schecked" onclick="goodsSearch(this);">全部</a>
					<c:forEach items="${p.values }" var="v">
						<a value="${p.id }:${v.id}" href="javascript:void(0)" onclick="goodsSearch(this);">${v.name }</a>
					</c:forEach>
				</p>
			</c:forEach>
		</div>
	</div>
	<form id="goodsForm" action="goods/service/ajaxQueryGoods" method="post">
		<input name="categoryID" value="1" type="hidden"/>
	</form>
	<!--** 装修商品列表 **-->
	<div class="zhuanxiumidnr" id="goodsItems">
		<jsp:include page="items.jsp"></jsp:include>
	</div>
	<div class="zhuangXiuBgBox">
		<div class="zhuangxiu_8"></div>
		<div class="zhuangxiu_9"></div>
		<div class="zhuangxiu_10"></div>
	</div>
	
<div class="clear"></div>
</div>
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}
function setCondition(){
	$("#goodsForm input[name='condition']").remove();
	$("#searchCondition .schecked[value!='']").each(function(index){
		$("#goodsForm").append("<input type='hidden' name='condition' value='" + $(this).attr("value") + "' />");
	});
}
function goodsSearch(obj){
	$(obj).parent().find("a").removeClass("schecked");
	$(obj).addClass("schecked");
	setCondition();
	/* var condition = "";
	$("#searchCondition .schecked[value!='']").each(function(index){
		if(index != 0)
			condition += "&";
		
		condition += "condition=" + $(this).attr("value");
	}); */
	ajaxSubmit("goods/service/ajaxQueryGoods", $("#goodsForm").serialize(), function(data){
		zhigu.pageAjaxSuccess(data);
	}, "text");
}
zhigu.pageAjaxSuccess = function(data){
	$("#goodsItems").html(data);
}
</script>
</body>
</html>