<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户积分列表</title>
<script src="js/admin/admin.js" type="text/javascript"></script>
</head>
<body >
<table cellpadding="0" cellspacing="0" class="sysCommonTable _memTable">
        	<tr>
            	<th>用户账户</th>
                <th>充值累积积分</th>
                <th>商品消费积分</th>
                <th>服务消费积分</th>
            </tr>
            <c:forEach items="${userPoints }" var="userPoint">
	        <tr class="sysTr">
	        	<td><input type="hidden" id="userID"/>${userPoint.userName }</td>
	        	<td id="point_${userPoint.userID}">${userPoint.rechargePoint } </td>
	        	<td>${userPoint.goodsPoint}</td><td>${userPoint.servicePoint}</td>
	        </tr>
	        </c:forEach>
</table>   
<!-- 分页 -->
<div class="dataPager">
	<div class="ddpage">
			<jsp:include page="../../include/page.jsp">
				<jsp:param name="request" value="url"/>
				<jsp:param name="requestUrl" value="admin/promotion/userPointList"/>
			</jsp:include>
	</div>
</div>   
<div id="sendDlg" title="发送奖励" modal="true" closed="true" class="easyui-dialog"  style="padding: 20px;width: 450px;height: 300px;" >
	   <table style="width: 100%;line-height: 34px;">
		<tr><td colspan="2" id="userInfoTD"></td></tr>
           <tr>
               <td width="90" align="right">消耗积分：</td>
               <td><input type="text" id="usePoint" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="9"/></td>
           </tr>
           <tr>
               <td width="90" align="right">备注：</td>
               <td><textarea id="comment" rows="5" ></textarea></td>
           </tr>
	 </table>
</div>
<script type="text/javascript">
function sendDlg(userID){
	var userPoint ;
	ajaxSubmit("/admin/promotion/userPointInfo",{"userID":userID},function(data){
		userPoint = data;
		$("#userInfoTD").html("用户名："+data.userName+"　"+"充值积分："+data.rechargePoint);
	},"json");
	$('#sendDlg').dialog({
		buttons : [ {
			text : '　确定　 ',
			handler : function() {
				var usePoint = $("#usePoint").val();
				var comment = $("#comment").val();
				if(!usePoint||usePoint==0||usePoint>userPoint.rechargePoint){
					dialog("请正确填写消耗的积分，不能大于用户拥有的积分！");
					return ;
				}
				if(!comment||comment.leng>300){
					dialog("请填写备注，不能大于300字！");
					return; 
				}
				confirmDialog("确认扣除此用户的积分？",function(){
					ajaxSubmit("/admin/promotion/saveSendAward",{"userID":userID,"usePoint":usePoint,"comment":comment},function(data){
						dialog(data.msg,function(){
							reloadCurrentPage();
						});
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
