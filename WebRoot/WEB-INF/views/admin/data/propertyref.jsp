<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>属性映射管理</title>
<link href="js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css">
<link href="css/jcDate.css" rel="stylesheet" type="text/css" media="all" />
<script src="js/admin/admin.js" type="text/javascript"></script>
<link href="js/3rdparty/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" language="javascript" src="js/3rdparty/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="js/admin/member.js"></script>
</head>

	<body style="font-family: '微软雅黑'; font-size: 13px;">
		<div id="rightside">
			<!-- Content Box Start -->
			<div class="contentcontainer" style="margin-left: 20px; margin-right: 20px;">
				<div class="headings alt">
					<h2>
						属性映射管理
					</h2>
				</div>
				<div class="contentbox">
				
				 <div  style="height: auto; border: 1px solid #f7f7f7; margin-bottom: 10px; margin-top: 10px;">当前映射类目 ${catRef.categoryName} &lt;--&gt; ${catRef.thirdCatName} 平台：<c:if test="${catRef.thirdPlatType==1 }">淘宝</c:if><c:if test="${catRef.thirdPlatType==2 }">阿里巴巴</c:if>
				 	<input type="hidden" id="refId" name="refId" value="${catRef.id}"/>
				 	<input type="hidden" id="platType"  value="${catRef.thirdPlatType}"/>
				 </div>
				
				<div style="height: auto; border: 1px solid #f7f7f7; margin-bottom: 10px; margin-top: 10px;">
		  <table style="width:100%;">
		    <thead>
		      <tr>
		      <th style="30%">智谷属性</th>
		        <th style="width:10%">第三方平台选择<select id="platType" name="platType" style="width:20%"><option value="1">淘宝</option><option value="2">阿里巴巴</option></select></th>
		      <th>操作</th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		      <td style="text-align:right">
		      <select name="property" id="property">
			      <c:forEach items="${props}" var="item">
			      	<option value="${item.id}">${item.name}</option>
			      </c:forEach>
		      </select>
		      </td>
		      <td>
		      	<select name="thirdproperty" id="thirdproperty">
		      		<option>请选择</option>
		      		<c:forEach items="${itemProps}" var="item">
			      	<option value="${item.pid}"  >${item.name}</option>
			     </c:forEach>
		      	</select>
		      	</td>
		        <td><input value="添加映射" type="button" id="addref"/></td>
		      </tr>
		    </tbody>
		  </table>
		</div>
		<div style="height: auto; border: 1px solid #f7f7f7;">
		  <table style="width:100%">
		    <thead>
		      <tr>
		        <td>属性id</td>
		        <td>属性名称</td>
		        <td>平台类型</td>
		        <td>属性id</td>
		        <td>属性名称</td>
		        <td>操作</td>
		      </tr>
		    </thead>
		    <tbody id="showRef">
		    <c:forEach items="${proprefs}" var="item">
		    	<tr>
		    	<td>${item.categoryPropID}</td>
		        <td>${item.catPropName }</td>
		        <td><c:if test="${item.thirdPlatType}">淘宝</c:if><c:if test="${item.thirdPlatType==false}">阿里巴巴</c:if></td>
		        <td>${item.thirdCatPropID }</td>
		        <td>${item.thirdCatPropName }</td>
		        <td><input class='delbtn' type='button' data='${item.id}' value='删除'/><input data="${item.id}" type='button' value='添加属性值映射' class='addpropvaluebtn'/></td>
		        </tr> 
		    </c:forEach>
		    </tbody>
		  </table>
		</div>
		
		
              <div style="clear: both;"></div>
              
</div>
			</div>
		</div>
			<script type="text/javascript">
		$(function(){
			
			$("#property").change(function(){
				var text_val = $.trim($("option:selected",$(this)).text());
				$("#thirdproperty option").each(function(i,n){
					
					var next_val = $.trim($(n).text());
					
					if(next_val.indexOf(text_val)!=-1){
						$(n).attr("selected","selected");
					}
					if(text_val.indexOf(next_val)!=-1){
						$(n).attr("selected","selected");
					}
					if(next_val==text_val){
						$(n).attr("selected","selected");
						$("#addref").click();
						return false;
					}
				});
			});
			
			$("#addref").live("click",function(){
				// 1.获取数据
				var type = $("#platType").val();
				
				var typename = "淘宝";
				
				if(type===2){
					
					typename = "阿里巴巴";
					
				}
				
				var refId = $("#refId").val();
				var categoryPropID = $("#property").val();
				var catPropName = $("#property option:selected").text();
				var thirdCatPropID = $("#thirdproperty").val();
				var thirdCatPropName = $("#thirdproperty option:selected").text();
				
				var json = {refId:refId,categoryPropID:categoryPropID,catPropName:catPropName,thirdCatPropID:thirdCatPropID,thirdCatPropName:thirdCatPropName};
				
				// 2.发送数据到后台
				$.post("/admin/data/propertyref",json,function(data){
					
				// 3.处理页面效果
					if(data.status){
						
						var html = "<tr><td>"+categoryPropID+"</td><td>"+catPropName+"</td><td>"+typename+"</td><td>"+thirdCatPropID+"</td><td>"+thirdCatPropName+"</td> <td><input class='delbtn' type='button' data="+data.data.id+" value='删除'/><input data="+data.data.id+" type='button' value='添加属性值映射' class='addpropbtn'/></td></tr>";
						var len = $("#showRef tr").length;
						if(len===0){
							$("#showRef").append(html);
						}else{
							$("#showRef tr:first").before(html);
						}
						
					}else{
						
						alert("映射添加失败，请重新添加！");
					}
					
				});
				
			});
			
			// 添加属性值映射按钮功能
			$(".addpropvaluebtn").live('click',function(){
				window.location.href = "/admin/data/valueref?refId="+$(this).attr("data");
			});
			
			$(".delbtn").live("click",function(){
				
				var id = $(this).attr("data");
				
				var btn = $(this);
				
				$.get("/admin/data/delete/propref",{id:id},function(data){
					
					if(data.status){
						
						btn.parents("tr").remove();
						
					}else{
						
						alert("删除失败，请稍候再试！");
						
					}
					
				});
				
			});
			
		});
	</script>
	</body>

</html>
