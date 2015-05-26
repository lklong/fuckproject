<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评价管理</title>
<link href="js/3rdparty/raty-2.7.0/jquery.raty.css" rel="stylesheet" type="text/css" >
</head>
<body>
<script type="text/javascript" language="javascript" src="js/3rdparty/raty-2.7.0/jquery.raty.js"></script>
<div class="body_center2 fl p10 ml10">
	<div class="chongzhititle">
       <h4>评价列表</h4>
	</div>
	<div class="mingxitable0 mt10">
       <table class="mingxitable">
           <tr class="mingxitableth">
               <th width="200">商品</th>
               <th width="150">评分</th>
               <th>内容</th>
               <th width="160">时间</th>
           </tr>
           <c:forEach var="e" items="${page.datas}">
				<tr>
					<td title="${e.goodsName }"><a style="color: blue;" href="goods/detail?goodsId=${e.goodsId }" target="_blank">${e.goodsName }</a></td>
					<td><span class="data-score" data-score="${e.score }"></span></td>
					<td title="${e.content }">${e.content }</td>
					<td><fmt:formatDate value="${e.time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
           </c:forEach>
        </table>
        <div class="ddtablefooter mt10">
        <div class="ddpage fr mr20">
			<jsp:include page="../../include/page.jsp">
				<jsp:param name="request" value="url"/>
				<jsp:param name="requestUrl" value="user/order/evaluate"/>
			</jsp:include>
		</div>
		</div>
    </div>
</div> 
<div class="clear"></div>
<script type="text/javascript">
$(function(){
	$('.data-score').raty({
		readOnly: true,
		score: function() {
		    return $(this).attr('data-score');
		}
	});
});
function showContent(msg){
	dialog(msg);
}
</script>
</body>
</html>