<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户积分兑换</title>
<script src="js/admin/admin.js" type="text/javascript"></script>

</head>

<body >
<!-- //功能条// -->
<div class="sysContBar">
	<form action="admin/promotion/userPointExchangeList" id="searh_form" method="post">
		<div class="sysCBBox">
			<div>状态</div>
			<div>
				<select name="status" class="sysComSelect">
					<option value="">-全部-</option>
					<option value="0" <c:if test="${page.paras.status==0 }">selected="selected"</c:if>>待发送</option>
					<option value="1" <c:if test="${page.paras.status==1 }">selected="selected"</c:if>>已发送</option>
				</select>
			</div>
			<div>
				<input class="sysSubmit" value="查找" type="submit">
			</div>
		</div>
	</form>
</div>
<!-- //列表// -->
<table cellpadding="0" cellspacing="0" class="sysCommonTable _memTable">
   	<tr>
       	<th>用户账户</th>
           <th>收货人名</th>
           <th>收货地址</th>
           <th>收货电话</th>
           <th>邮政编码</th>
           <th>使用积分</th>
           <th>兑换物品名</th>
           <th>兑换时间</th>
           <th>操作</th>
       </tr>
       <c:forEach items="${userPointExchangeList }" var="ue">
       <tr class="sysTr">
      		<td>${ue.userName}</td>
          	<td >${ue.name } </td>
          	<td>${ue.address}</td>
          	<td>${ue.phone}</td>
          	<td>${ue.postCode }</td>
          	<td>${ue.usePoint }</td>
          	<td>${ue.exchangeName }</td>
          	<td><fmt:formatDate value="${ue.addTime  }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
          	<td><c:if test="${ue.status==1 }">已发送</c:if><c:if test="${ue.status==0 }"><button class="sysCommonButon" onclick="sendDlg(${ue.id})" >发送奖励</button></c:if></td>
       </tr>
       </c:forEach>
</table>
<!-- //分页// -->
<div class="dataPager">
	<div class="ddpage fr mr20">
		<jsp:include page="../../include/page.jsp">
			<jsp:param name="request" value="form"/>
			<jsp:param name="requestForm" value="searh_form"/>
		</jsp:include>
	</div>
</div>

<div id="sendDlg" title="发送奖励" modal="true" closed="true" class="easyui-dialog"  style="padding: 20px;width: 450px;height: 300px;" >
	   <table style="width: 100%;line-height: 34px;">
		<tr><td colspan="2" id="userInfoTD"></td></tr>
           <tr>
               <td width="90" align="right">备注：</td>
               <td><textarea id="comment" rows="5" ></textarea></td>
           </tr>
	 </table>
</div>
<script type="text/javascript">
function sendDlg(id){
	$("#comment").val("");
	$('#sendDlg').dialog({
		buttons : [ {
			text : '　确定　 ',
			handler : function() {
				confirmDialog("确认更新为物品已发送状态？",function(){
					ajaxSubmit("/admin/promotion/sendUserPointExchange",{"id":id,"comment":$("#comment").val()},function(msgBean){
						if(msgBean.code == zhigu.code.success){
							layer.msg(msgBean.msg, 1, f5);
						}else{
							layer.alert(msgBean.msg);
						}
					});
				});
			}
		}, {
			text : '　取消　',
			handler : function() {
				$("#sendDlg").dialog("close");
			}
		}]
	});
	$("#sendDlg").dialog("move",{top:$(document).scrollTop() + 250});
	$("#sendDlg").dialog("open");
}
</script>
</body>
</html>
