<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品列表</title>
<script src="js/admin.js" type="text/javascript"></script>
</head>
<body>
	<!-- //功能条// -->
	<div class="sysContBar">
		<form action="admin/goods/index" id="searh_form" method="post">
			<div class="sysCBBox">
				<div>
					<input onclick="addCement();" class="sysSubmit" value="发布文章" type="button" />
				</div>
			</div>
			<div class="sysCBBox">
				<div>
					共有 <span class="c">${page.totalRow }</span>个信息
				</div>
			</div>
		</form>
	</div>

	<div class="tableActBar"></div>
	<table class="sysCommonTable" cellspacing="0" cellpadding="0">
		<thead>
			<tr>
				<th>信息标题</th>
				<th>作者</th>
				<th>发布时间</th>
				<th>排序</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${comentList}" var="cl">
				<tr>
					<td width="20%">${cl.title}</td>
					<td>admin</td>
					<td><fmt:formatDate value="${cl.addTime}" pattern="yyyy-MM-dd " /></td>
					<td>${cl.sort }</td>
					<td width="20%"><a class="sysButonA4" href="javascript:void(0);" onclick="updateCement(${cl.id});"><em></em>更新信息</a> 
					<a class="sysButonA4" href="javascript:void(0);" onclick="deleteComent(${cl.id});"><em></em>删除信息</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="dataPager">
		<div class="ddpage">
			<jsp:include page="../../include/page.jsp">
				<jsp:param name="request" value="url" />
				<jsp:param name="requestForm" value="searh_form" />
				<jsp:param name="requestUrl" value="/admin/system/CementContentsList" />
			</jsp:include>
		</div>
	</div>
	<script type="text/javascript">
	function addCement(){		
		  window.location.href ="/admin/system/coment/addAndUpdate";
	   }
	
      function  updateCement(id){
    	  window.location ="/admin/system/coment/addAndUpdate?id="+id;
          } 

   
      function deleteComent(id){
    		layer.confirm("确认要删除此条信息吗？",_status);
    		//更新函数
    		function _status(){
    			  $.post("/admin/system/deleteComent?id="+id,function(msgBean){
    	        	  if(msgBean.code == zhigu.code.success){
       						layer.msg(msgBean.msg,2,changePage);
       					}else{	
       						layer.alert(msgBean.msg);
       					}
    	          });
    		};
    	}
      function changePage(){
    	  window.location ="/admin/system/CementContentsList";  
      }
</script>
</body>

</html>
