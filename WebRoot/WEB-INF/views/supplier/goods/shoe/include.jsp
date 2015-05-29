<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sku-box-bg">
  <p class="sku-title">商品属性：</p>
  <div class="" id="attributes">
    <jsp:include page="property.jsp"></jsp:include>
  </div>
</div>
<div class="sku-box-bg">
  <p class="sku-title">商品规格：</p>
  <jsp:include page="sku.jsp" />
</div>
<script>
$(document).ready(
	function(){
		zhigu.goods.loadPropertyInit();
	});
</script>