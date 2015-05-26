<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/js/jquery-1.11.2.min.js"></script>
<script src="/js/jquery.lazyload.js"></script>
<script type="text/javascript">
	$(function(){
		$("img.lazy").lazyload({
			placeholder:"/img/show/loading.gif",
			effect : "fadeIn",
			threshold : 200, 
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<div id="container">
	<fieldset><legend>第一栏</legend>
		<c:forEach items="${iamges}"  var="img">
		 	<img alt="xx"  class="lazy" data-original="${img}" width="640px" ><br>
			<noscript>
			 <img src="${img}" class="lazy" width="640px" alt="" />
			</noscript>
		</c:forEach>
		<img alt="xx"  class="lazy" data-original="5.jpg" width="640px" ><br>
	</fieldset>
	</div>
</body>
</html>