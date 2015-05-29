<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>充值明细</title>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">充值明细</h4>
  <div class="">
    <div id="userContents" class="userContents"> 
      <!--// 内容1 //-->
      <div class="body_center2">
        <div class="mt10">
          <div class="mingxitable0 mt10">
            <table cellpadding="0" cellspacing="0" class="user-list-table">
              <tr class="mingxitableth">
                <th>流水号</th>
                <th>金额</th>
                <th>充值方式</th>
                <th>状态</th>
                <th>充值时间</th>
              </tr>
              <c:forEach var="r" items="${page.datas}">
                <tr>
                  <td>${r.paymentNo}</td>
                  <td><fmt:formatNumber pattern="#0.00" value="${r.rechargeMoney }"/></td>
                  <td><c:if test="${r.type == 1}">支付宝</c:if></td>
                  <td><c:choose>
                      <c:when test="${r.status == 0}"> <a href="user/repayent?rechargeId=${r.id}"><span style="color:red;">充值中...</span></a> </c:when>
                      <c:when test="${r.status == 1}"> <span style="color: green;">充值成功</span> </c:when>
                      <c:when test="${r.status == 2}">充值失败</c:when>
                      <c:when test="${r.status == 9}">失效</c:when>
                    </c:choose></td>
                  <td><fmt:formatDate value="${r.rechargeTime}"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" /></td>
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
      </div>
    </div>
  </div>
</div>
</body>
</html>