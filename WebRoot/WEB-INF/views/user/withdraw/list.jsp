<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>提现</title>
</head>
<body>
<div class="rightContainer fr">
  <div class="chongzhititle">
    <h4 class="ddtitle">账户提现跟踪记录</h4>
  </div>
  <div class="tixianjilu mt20">
    <div class="fun-bar"> <span class="fl">提现状态：</span>
      <select id="withdrawStatus" class="select-txt">
        <option value="">所有</option>
        <c:forEach items="${withdrawStatus}" var="ws">
          <option value="${ws.value}" <c:if test="${currStatus==ws.value}">selected="selected"</c:if>>${ws.name}</option>
        </c:forEach>
      </select>
      <span class="fr" style="margin-right: 40px;">
      <input class="input-button" type="button" value="申请提现"  onclick="window.location.href ='/user/withdraw/add'"/>
      </span> </div>
    <div class="tixiantable0 mt20">
      <table cellpadding="0" cellspacing="0" class="user-list-table">
        <tr>
          <th>申请时间</th>
          <th>提现金额</th>
          <th>转入卡号</th>
          <th>状态</th>
        </tr>
        <c:forEach items="${page.datas}" var="withdraw">
          <tr>
            <td><fmt:formatDate value="${withdraw.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${withdraw.money}</td>
            <td>${withdraw.toAccount}【${withdraw.toAccountMaster}】</td>
            <td>${withdraw.statusLabel}</td>
          </tr>
        </c:forEach>
      </table>
      <div class="ddpage fr mr20">
        <jsp:include page="../../include/page.jsp">
        <jsp:param name="request" value="function"/>
        <jsp:param name="functionName" value="zhigu.loadWithdraw"/>
        </jsp:include>
      </div>
    </div>
  </div>
</div>
<div class="clear"></div>
<script type="text/javascript">
		$(function(){
			$("#withdrawStatus").change(function(){
				zhigu.loadWithdraw(1);
			});
		})
		zhigu.loadWithdraw = function(pageNo){
			var  status = $("#withdrawStatus").val();
			window.location.href = "/user/withdraw?pageNo="+pageNo+(status?("&status="+status):"");
		}
		
	</script>
</body>
</html>