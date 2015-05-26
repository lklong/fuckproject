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
<title>摄影服务</title>
</head>
<body>
	<%-- <div class="header"><jsp:include page="../../include/logohead.jsp" /></div> --%>
	<!--** 顶部大滚动Banner **-->
	<%-- <div class="topBigBanner disnone" style="background: url('img/photograph/index_top_banner.jpg');"><div class="tbb_insideBlock" ></div></div> --%>
<!--** 最外层背景显示  **-->
<div class="visionBox">
	<div class="visionBgBox">
		<div class="visionBg_1"></div>
		<div class="visionBg_2"></div>
		<div class="visionBg_3"></div>
		<div class="visionBg_4"></div>
		<div class="visionBg_5"></div>
		<div class="visionBg_6"></div>
		<div class="visionBg_7"></div>
		<div class="visionBg_8"></div>
		<div class="visionBg_9"></div>
		<div class="visionBg_10"></div>
		<div class="visionBg_11"></div>
		<div class="visionBg_12"></div>
	</div>
	<!--** 商品筛选条 **-->
	<div class="sreeningBar">
		<div class="sb_left" id="searchCondition">
			<c:forEach items="${properties }" var="p">
				<p><b>${p.name }：</b>&nbsp;
					<a value="" class="schecked" onclick="goodsSearch(this);">全部</a>
					<c:forEach items="${p.values }" var="v">
						<a value="${p.id }:${v.id}" href="javascript:void(0)" onclick="goodsSearch(this);">${v.name }</a>
					</c:forEach>
				</p>
			</c:forEach>
		</div>
	</div>
	<form id="goodsForm" action="goods/service/ajaxQueryGoods?categoryID=2" method="post">
		<input name="categoryID" value="2" type="hidden"/>
	</form>
	<!--** 商品列表 **-->
	<div class="zhuanxiumidnr" id="goodsItems">
		<jsp:include page="../service/items.jsp"></jsp:include>
		<br/>
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