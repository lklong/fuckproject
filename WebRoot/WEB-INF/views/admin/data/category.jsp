<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />

<title>类目管理</title>
<link href="js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css">
<link href="css/default/jcDate.css" rel="stylesheet" type="text/css" media="all" />
<script src="js/admin/admin.js" type="text/javascript"></script>
<link href="js/3rdparty/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" language="javascript" src="js/3rdparty/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="js/admin/member.js"></script>
<style>
	th {
    text-align: left;
}
</style>
</head>

	<body style="font-family: '微软雅黑'; font-size: 13px;">
		<div id="rightside">
			<!-- Content Box Start -->
<div class="contentcontainer" style="margin-left: 20px; margin-right: 20px;">
				<div class="headings alt">
					<h2>
						类目管理
					</h2>
				</div>
	<div class="contentbox">
						
		<div style="height: auto; border: 1px solid #f7f7f7; margin-bottom: 10px; margin-top: 10px;">
		
		<form action="">
		  <table style="width:100%;">
		    <thead>
		      <tr>
			      <th style="width:20%">类目数据来源<select id="platType" name="platType" style="width:20%"><option value="1">淘宝</option><option value="2">阿里巴巴</option></select></th>
			      <th style="width:20%">智谷类目名称</th>
			      <th style="width:5%">是否父级</th>
			      <th style="width:15%">父级选择
			      	<select name="category" class="category">
			       		<option value="0">请选择</option>
			       		 <c:forEach items="${category}" var="item">
					     	<option value="${item.id}" isParent="${item.isParent}" >${item.name}</option> 
					     </c:forEach>
			       	</select>
			      </th>
			      <th style="width:10%">code</th>
			      <th style="width:10%">操作</th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		      <td>
		      	<select name="thirdcategory" class="thirdcategory" style="width:100px;">
		      		<option>请选择</option>
		      		<c:forEach items="${tbcategory}" var="item">
			      	<option value="${item.cid}" isParent="${item.isParent}">${item.name}</option> 
			      </c:forEach>
		      	</select>
		      </td>
		      <td><input name="name" type="text"/></td>
		      <td><select name="isParent"><option value="0">0</option><option value="1">1</option></select></td>
		       <td>
			       	<input name="parentId" type="text" >
		       </td>
		       
		      <td><input name="code" type="text"/></td>
		      
		       <td><input value="添加类目" type="button" id="addref"/></td>
		      </tr>
		    </tbody>
		  </table>
		  </form>
		  
		</div>
		
		
		<div style="height: auto; border: 1px solid #f7f7f7;">
		  <table style="width:100%">
		    <thead>
		      <tr>
		        <td>类目id</td>
		        <td>类目名称</td>
		        <td>是否父级</td>
		        <td>父级类目id</td>
		        <td>操作</td>
		      </tr>
		    </thead>
		    <tbody id="showCatRef">
		     <c:forEach items="${categorys}" var="item">
		    	<tr>
		    	<td>${item.id }</td>
		        <td>${item.name }</td>
		        <td><c:if test="${item.isParent==0}">否</c:if><c:if test="${item.isParent==1}">是</c:if></td>
		        <td>${item.parentId}</td>
		        <td><input class='delbtn' type='button' data='${item.id}' value='删除'/><input type="button" value="添加属性" data="${item.id }" class="addpropbtn"/></td>
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
		
		$(".category").live('change',function(){
			var $parent = $(this);
			var isparent = $("option:selected",$parent).attr("isParent");
			console.log(isparent === "true");
			if(isparent === "true") {
				// 1.获取父级id
				var pid = $parent.val();
				var name = $parent.attr("class");
				catChange(pid,$parent,name,"/category/getcat");
				
			}else{
				console.log("当前类目为叶子类目");
				$parent.nextAll().remove();
				
			}
			var pid = $parent.val();
			$("input[name='parentId']").val(pid);
		
	});
		
		function catChange(id,$parent,name,url){
				
			// 1.清理子节点
			$parent.nextAll().remove();
			
			// 2.发送请求
			$.post(url,{pid:id},function(data){
				// 3.处理返回数据(dom删除，修改上、下一级的name属性)
				if(data.status){
					
					var cats = data.data;
					
					console.log(cats);
					
					var $select = "<select name="+name+" class='category'>";
					
					var options = "";
					
					for(var i = 0 ; i<cats.length ; i++){
						
						options += "<option value="+cats[i].id+" isParent="+cats[i].isParent+">"+cats[i].name+"</option>";
						
					}
					
					$select = $select+options+"</select>";
					
					if(cats.length>0){
						
						$parent.after($select);
						
						$parent.attr("name","").next().attr("name",name);
						
					}
					
				}
				
			})
			
			
		}
		
		// 加载子类目
		$(".thirdcategory").live('change',function(){
			
			// 1.获取平台类型
			var type = $("#platType").val();
			
			var $parent = $(this);
			
			// 2.获取cid
			var cid = $parent.val();
			
			// 3.是否父级
			var isParent = $("option:selected",$(this)).attr("isParent");
			
			// 4.获取名称
			var name = $parent.attr("class");

			console.log(isParent);
			
			// 判断获取数据
			if(isParent==="true"){
				
				// 5.删除名称
				$parent.attr("name","");
				
				getCategory(type,cid,$parent,name);
				
			}else{
				
				console.log("当前选项为叶子目录");
				$parent.nextAll().remove();
				
			}
				var _name = $("option:selected",$parent).text();
				var code = "00"+$parent.val();
				$("input[name='name']").val(_name);
				$("input[name='code']").val(code);
			
		});
		
		function getCategory(type,cid,$parent,name){
			// 3.ajax请求数据
			$.get("/category/tbcategory",{type:type,pid:cid},function(data){
				
				$parent.nextAll().remove();
				
				var $select = "<select class='thirdcategory' style='width:100px;'><option value='0'>请选择</option>";
				
				var options = "";
				
				var cats = data.data;
				
				console.log(cats);
				
				for(var i = 0 ; i<cats.length ; i++){
					
					options += "<option value="+cats[i].cid+" isParent="+cats[i].isParent+">"+cats[i].name+"</option>";
					
				}
				
				$select = $select+options+"</select>";
				
				if(cats.length>0){
					
					$parent.after($select);
					
					$parent.attr("name","").next().attr("name",name);
					
				}
				
			});
		}
		
		// 添加类目映射关系
		$("#addref").click(function(){
			
			var json = {
				 name : $("input[name='name']").val(), isParent : $("select[name='isParent']").val(),  parentId : $("input[name='parentId']").val(), code : $("input[name='code']").val()
					
			};
			
			// b.发送数据到后台
			$.post("/admin/data/category/save",$("form").serialize(),function(data){
				
				if(data.status){
					
					console.log(data.data);
					
					var obj = data.data;
					
					var isParent = obj.isParent?"是":"否";
					
					var html = "<tr><td>"+obj.id+"</td><td>"+obj.name+"</td><td>"+isParent+"</td><td>"+obj.parentId+"</td><td><input class='delbtn' type='button' data="+data.data.id+" value='删除'/><input data="+data.data.id+" type='button' value='添加属性' class='addpropbtn'/></td></tr>";
					
					var len = $("#showCatRef tr").length;
					
					if(len===0){
						
						$("#showCatRef").append(html);
						
					}else{
						
						$("#showCatRef tr:first").before(html);
					}
					
					
				}else{
					
					alert("类目添加失败，请重新添加！");
					
				}
				
			});
			
		});
		
		// 添加属性按钮功能
		$(".addpropbtn").live('click',function(){
			window.location.href = "/admin/data/property?catId="+$(this).attr("data");
		});
		
		$(".delbtn").click(function(){
			
			var id = $(this).attr("data");
			
			var btn = $(this);
			
			$.get("/admin/data/delete/catref",{id:id},function(data){
				
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
