<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>充值明细</title>
</head>
<body>
<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	充值明细<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">充值明细</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="body_center2">
	 <div class="mt10">
	<div class="mingxitable0 mt10">
       <table class="mingxitable">
           <tr class="mingxitableth">
               <th width="200">流水号</th>
               <th width="300">金额</th>
               <th width="100">充值方式</th>
               <th width="100">状态</th>
               <th width="150">充值时间</th>
           </tr>
           <c:forEach var="r" items="${page.datas}">
            <tr>
           	<td>${r.paymentNo}</td>
               <td><fmt:formatNumber pattern="#0.00" value="${r.rechargeMoney }"/> </td>
              	<td>
              		<c:if test="${r.type == 1}">支付宝</c:if>
              	</td> 
              	<td>
              		<c:choose>
              			<c:when test="${r.status == 0}">
              				<a href="user/repayent?rechargeId=${r.id}"><span style="color:red;">充值中...</span></a>
              			</c:when>
              			<c:when test="${r.status == 1}">
              				<span style="color: green;">充值成功</span>
              			</c:when>
              			<c:when test="${r.status == 2}">充值失败</c:when>
              			<c:when test="${r.status == 9}">失效</c:when>
              		</c:choose>
              	</td>
           	<td><fmt:formatDate value="${r.rechargeTime}"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" /> </td>
             </tr>
           </c:forEach>
        </table>
        <div class="ddtablefooter mt10">
        <div class="ddpage fr mr20">
			<jsp:include page="../../include/page.jsp">
				<jsp:param name="request" value="url"/>
				<jsp:param name="requestUrl" value="user/acc/rechargelist"/>
			</jsp:include>
		</div>
		</div>
    </div>
</div> 
<div class="clear"></div>
     </div>
            <br style="clear:both;" />
        </div>
    </div>


<script type="text/javascript">
// $(function(){
// 	//充值后中转到当前页时，360会出现样式问题，先这样变相处理
// 	var href = window.location.href;
// 	var index = href.indexOf('?',0);
// 	if(index > 0){
// 		window.location.href = "/user/acc/rechargelist";
// 		//page_go(1);
// 	}
// })
</script>
</body>
</html>