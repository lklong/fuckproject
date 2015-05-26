<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="jibenform2 mt10">
	<p class="title fl">商品属性：</p>
    <div class="shuxingbox fl" id="attributes">
   	<jsp:include page="property.jsp"></jsp:include>
    </div>
    <div class="clear"></div>
</div>

<div class="jibenform">
	<p class="title">商品规格：</p>
	<jsp:include page="sku.jsp" />
</div>
<script>
$(document).ready(
	function(){
		zhigu.goods.loadPropertyInit();
	});
</script>