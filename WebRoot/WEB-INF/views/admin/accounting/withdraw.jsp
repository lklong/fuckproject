<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />

<title>用户提现申请</title>
<script src="js/admin/admin.js" type="text/javascript"></script>

</head>

<body>
	<!-- //功能条// -->
	<div class="sysContBar">
			<div class="sysCBBox">
				<div>状态：</div>
				<div>
					<select id="withdrawStatus" class="sysComSelect">
						<option value="">-全部-</option>
						<c:forEach items="${withdrawStatusAll}" var="ws">
						<option value="${ws.value}" <c:if test="${queryStatus==ws.value}">selected="selected"</c:if>>${ws.name}</option>
					</c:forEach>
					</select>
				</div>
				<div>银行卡号：</div>
				<div><input id="bankNo" value="${queryBankNo }" class="sysCommonInput" type="text" /></div>
				<div>
					<input class="sysSubmit" value="查找" type="button" onclick="zhigu.loadWithdraw(1);">
				</div>
			</div>
		<font color="red" size="3"> &nbsp;&nbsp;处理流程：用户申请(资金从用户账户扣除)--->受理---->线下完成转账--->转账成功确认(成功确认前都可以选择转账失败，将资金退还到用户账户)</font><br><br>
	</div>
	<!-- //列表// -->
	<table cellpadding="0" cellspacing="0" class="sysCommonTable _memTable">
		<tr>
			<th>用户id</th>
			<th>用户账户</th>
			<th>用户手机</th>
			<th>申请时间</th>
			<th>提现金额</th>
			<th>转入卡主</th>
			<th>转入卡号</th>
			<th>银行名</th>
			<th>状态</th>
			<th>受理人</th>
			<th>操作</th>
			<th>受理时间</th>
			<th>受理完成时间</th>
		</tr>
		<c:forEach items="${page.datas }" var="withdraw">
			<tr class="sysTr">
				<td>${withdraw.userId}</td>
				<td>${withdraw.userName}</td>
				<td>${withdraw.userPhone}</td>
				<td><fmt:formatDate value="${withdraw.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${withdraw.money}</td>
				<td>${withdraw.toAccountMaster}</td>
				<td>${withdraw.toAccount}</td>
				<td>${withdraw.bankName}</td>
				<td>${withdraw.statusLabel}</td>
				<td>${withdraw.adminName}</td>
				<td>
					<c:if test="${withdraw.status==1}"><a href="javascript:void(0);" class="sysButonA3" onclick="zhigu.acceptWithdraw(${withdraw.id});"><em></em>受理</a></c:if>
					<c:if test="${withdraw.status==2}"><a href="javascript:void(0);" class="sysButonA1" onclick="zhigu.successWithdraw(${withdraw.id});"><em></em>转账成功</a></c:if>
					<c:if test="${withdraw.status==2||withdraw.status==1}"><a href="javascript:void(0);" class="sysButonA2" onclick="zhigu.FailWithdraw(${withdraw.id});"><em></em>转账失败</a></c:if>
				</td>
				<td><fmt:formatDate value="${withdraw.acceptTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatDate value="${withdraw.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</c:forEach>
	</table>
	<!-- //分页// -->
	<div class="dataPager">
		<div class="ddpage fr mr20">
			<jsp:include page="../../include/page.jsp">
				<jsp:param name="request" value="function" />
				<jsp:param name="functionName" value="zhigu.loadWithdraw" />
			</jsp:include>
		</div>
	</div>

<script type="text/javascript">
zhigu.loadWithdraw = function(pageNo){
	var status = $("#withdrawStatus").val();
	status = status?status:"";
	var bankNo =  $("#bankNo").val();
	bankNo = bankNo?bankNo:"";
	window.location.href = "/admin/accounting/withdraw?status="+status+"&bankNo="+bankNo;
}
zhigu.acceptWithdraw = function(id){
	$.post("/admin/accounting/withdraw/accept",{'id':id},function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.msg(msgBean.msg,2,f5);
		}else{
			layer.alert(msgBean.msg);
		}
	});
}
zhigu.successWithdraw = function(id){
	layer.confirm("确定已经将提现资金转入到账？",function(){
		$.post("/admin/accounting/withdraw/success",{'id':id},function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg,2,f5);
			}else{
				layer.alert(msgBean.msg);
			}
		});
	});
}
zhigu.FailWithdraw = function(id){
	layer.confirm("提现失败，将提现金额退还用户？",function(){
		$.post("/admin/accounting/withdraw/fail",{'id':id},function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg,2,f5);
			}else{
				layer.alert(msgBean.msg);
			}
		});
	});
}
</script>
</body>
</html>
