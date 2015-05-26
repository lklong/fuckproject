<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>快速发布商品</title>
<script src="js/admin.js" type="text/javascript"></script>
</head>
<body>
<table class="sysCommonTable" cellspacing="0" cellpadding="0">
	<thead>
		<tr >
			<th>发布用户名</th>
			<th>用户电话号码</th>
			<th>真实文件名</th>
			<th>发布时间</th>
			<th>文件下载</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="shortcutgoods" items="${ shortcutgoodsList  }">
		<tr >
			<td>${shortcutgoods.user.username }</td>
			<td>${shortcutgoods.user.phone }</td>
			<td>${shortcutgoods.realFileName }</td>
			<td><fmt:formatDate value="${shortcutgoods.createDate  }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td><a href="${shortcutgoods.filePath }" class="sysButonA3"><em></em>下载</a></td>
			
			<td id="statusTd${shortcutgoods.id }"  >
				<c:if test="${shortcutgoods.status == 0 }">
					<a href="admin/goods/add?shortcutGoodsID=${ shortcutgoods.id }" class="sysButonA5"><em></em>去发布</a>
					<a href="javascript:void(0);" onclick="changeStatus(${ shortcutgoods.id },2 )"  class="sysButonA4"><em></em>不予代发</a>
				</c:if>
				<c:if test="${shortcutgoods.status == 1 }">
					<span style="color: green;">已代发</span>
				</c:if>
				<c:if test="${shortcutgoods.status == 2 }">
					<span style="color: red;">不予代发</span>
				</c:if>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="dataPager">
		<div class="ddpage">
					<jsp:include page="../../include/page.jsp">
						<jsp:param name="request" value="url"/>
						<jsp:param name="requestUrl" value="/admin/goods/shortcutGoods"/>
					</jsp:include>
		</div>
</div>
<script>
function changeStatus( id , status ){
	var statusTd =  $("#statusTd"+ id);
	ajaxSubmit("/admin/goods/changeShortcutGoodsStatus", {"id":id,"status":status} , function(msgBean){
		if(msgBean.code == zhigu.code.success){
			if( status == 1 ){
				statusTd.html( "<span style='color: green;'>已代发</span>" );
			}else{
				statusTd.html( "<span style='color: red;'>不予代发</span>" );
			}
			layer.msg(msgBean.msg, 1, f5);
		}else{
			layer.alert(msgBean.msg);
		}
	}, "json", true );
} 
</script>
	
</body>
</html>