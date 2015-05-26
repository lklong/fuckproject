<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>提现</title>
</head>
<body>
	<div class="rightContainer">
		<div class="chongzhititle">
			<h4>账户提现跟踪记录</h4>
		</div>
		<div class="tixianjilu mt20">
			<div class="tixiantop">
				<span class="fl">提现状态：</span>
				<select id="withdrawStatus">
					<option value="">所有</option>
					<c:forEach items="${withdrawStatus}" var="ws">
						<option value="${ws.value}" <c:if test="${currStatus==ws.value}">selected="selected"</c:if>>${ws.name}</option>
					</c:forEach>
				</select>
					<span class="fr" style="margin-right: 40px;"><input class="liinput" type="button" value="申请提现"  onclick="window.location.href ='/user/withdraw/add'"/></span>
				<div class="clear"></div>
			</div>
			<div class="tixiantable0 mt20">
				<table class="tixiantable">
					<tr>
						<th class="th0" width="200">申请时间</th>
						<th class="th0" width="150">提现金额</th>
						<th class="th0" width="300">转入卡号</th>
						<th class="th0" width="200">状态</th>
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