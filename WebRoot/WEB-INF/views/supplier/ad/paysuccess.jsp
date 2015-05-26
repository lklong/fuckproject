<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单支付</title>
<link href="css/jinhuoche.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div style="height:54px;"></div>
<div class="gyheader">
<div class="jinhuologo fl">
          <p class="fl f16 fwbold fwryh">广告支付中心</p>
          <div class="clear"></div>
      </div> 
      <div class="clear"></div>
  </div>
<div class="webpage" id="${id}">
	   	<div class="cgzfpage mt10 p10">
	       	<h2 class="lh40 c333"><span class="mr10"></span>您已成功付款<strong class="cff5200 ml5 mr5">
	       		
	       	</strong>元!审核通过后会以短信的新式通知您，请您注意查收。</h2>
	           <div class="cgzffooter">
		       			<a href="javascript:void(0);">查看广告</a>
	           &nbsp;&nbsp;|&nbsp;&nbsp;<a href="user/home">个人中心</a>
	               <div class="clear"></div>
	           </div>
	       </div>
<script type="text/javascript">
     
      $.getJSON("Admanage/user/paysuccess?id="+$(".webpage").attr("id"),function(data){
			 $("strong").html(data.adorder.theoryPrice)
			 $(".cgzffooter a:eq(0)").click(function(){
				 window.location.href="supplier/ad/seeAdInfo?id="+data.adorder.id;
			 })
      })
</script>
   </div>
</body>
</html>