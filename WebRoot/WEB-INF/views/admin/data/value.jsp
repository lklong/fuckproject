<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />

<title>供应商店铺列表</title>
<link href="js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css">
<link href="css/default/jcDate.css" rel="stylesheet" type="text/css" media="all" />
<script src="js/admin/admin.js" type="text/javascript"></script>
<link href="js/3rdparty/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" language="javascript" src="js/3rdparty/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="js/admin/member.js"></script>
<style type="text/css">
		th {
    text-align: left;
}
</style>
</head>

<body>
		<div id="rightside">
			<div class="contentcontainer" style="margin-left: 20px; margin-right: 20px;">
				<div class="headings alt">
					<h2>
						属性值管理
					</h2>
				</div>
				<div class="contentbox"></div>
			</div>
		</div>
		<div style="height: auto; border: 1px solid #f7f7f7; margin-bottom: 10px; margin-top: 10px;">
		  <table style="width:100%;">
		    <thead>
		      <tr>
		      <th style="width:40%">智谷类目属性</th>
		      <th style="width:5%">属性名称</th>
		       <th style="width:50%">第三方平台选择<select id="platType" name="platType" style="width:20%"><option value="1">淘宝</option><option value="2">阿里巴巴</option></select></th>
		      <th style="width:5%">操作</th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
			      <td>
				      <select name="category" id="category" class="category" >
					      <c:forEach items="${category}" var="item">
					     	<option value="${item.id}" isParent="${item.isParent}" >${item.name}</option> 
					      </c:forEach>
				      </select>
			      </td>
			      <td><input type="text" id="pvalue" name="pvalue" /></td>
		     	  <td>
			      	<select name="thirdcategory" class="thirdcategory" style="width: 150px;">
			      		<option>请选择</option>
			      		<c:forEach items="${tbcategory}" var="item">
				      	<option value="${item.cid}" isParent="${item.isParent}">${item.name}</option> 
				      </c:forEach>
			      	</select>
			      </td>
		        <td><input value="添加属性值" type="button" id="addref"/></td>
		      </tr>
		    </tbody>
		  </table>
		</div>
	<div style="height: auto; border: 1px solid #f7f7f7;">
		  <table style="width:100%">
		    <thead>
		      <tr>
		        <td>属性id</td>
		        <td>属性值id</td>
		        <td>属性值名称</td>
		        <td>操作</td>
		      </tr>
		    </thead>
		    <tbody id="showPValue">
			   
		    </tbody>
		  </table>
		</div>
        <div style="clear: both;"></div>
			<script type="text/javascript">
			
$(function(){
	
	$(".category").live('change',function(){
			var $parent = $(this);
			var isparent = $("option:selected",$parent).attr("isParent");
			// 1.获取平台类型
			var type = $("#platType").val();
			//2.获取类目id
			var cid = $parent.val();
			console.log(isparent === "true");
			if(isparent === "true") {
				// 1.获取父级id
				var pid = $parent.val();
				var name = $parent.attr("class");
				catChange(pid,$parent,name,"/category/getcat");
			}else{
				console.log("当前类目为叶子类目");
				$parent.nextAll().remove();
				// 获取属性
				getProperty(type,cid,$parent,name);
			}
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
						options += "<option value="+cats[i].id+" isParent="+cats[i].isParent+"  >"+cats[i].name+"</option>";
					}
					$select = $select+options+"</select>";
					if(cats.length>0){
						$parent.after($select);
						$parent.attr("name","").next().attr("name",name);
					}
				}
			})
		}
		//获取智谷品台类目下的属性
		function getProperty(type,cid,$parent,name){
			$.get("/admin/data/getProperty",{type:type,cid:cid},function(data){
				$parent.nextAll().remove();
				var $select = "<select name="+name+" class='property'>";
				var options = "";
				var propertyList = data.data;
				for(var i = 0 ; i<propertyList.length ; i++){
					options += "<option value="+propertyList[i].id+">"+propertyList[i].name+"</option>";
				}
				$select = $select+options+"</select>";
				if(propertyList.length>0){
					$parent.after($select);
					$parent.attr("name","").next().attr("name",name);
				}
			});
		}
		
		$(".property").live('change',function(){
			var $parent = $(this);
			//1.获取属性值id
			var pid = $parent.val();
			//2.获取属性值的name赋值到输入框内
			var name = $("option:selected",$parent).text();
		//	$("#pvalue").val(name);
			getPropertyValueList(pid);
			$parent.nextAll().remove();
		});
		//获取到该属性下的属性值
		function getPropertyValueList(pid){
			$.post("/admin/data/getPropertyValueList",{pid:pid},function(data){
			  var line="";
			  
			  line += "<tr> ";
			  for(var i = 0;i<data.data.length;i++){
				  line += "<td>"+(data.data)[i].propertyid +"</td>";
				  line += "<td>"+(data.data)[i].id +"</td>";
				  line += "<td>"+(data.data)[i].name +"</td>"
				  line += "<td> <input class='delbtn' type='button' data='"+(data.data)[i].id +"'value='删除'/></td></tr>"
			  }
			  $("#showPValue").empty().append(line);
			});
		}
		
		// 加载第三方平台类目
		$(".thirdcategory").live('change',function(){
			// 1.获取平台类型
			var type = $("#platType").val();
			var $parent = $(this);
			// 2.获取cid
			var tbcid = $parent.val();
			// 3.是否父级
			var isParent = $("option:selected",$(this)).attr("isParent");
			// 4.获取名称
			var name = $parent.attr("class");
			console.log(isParent);
			// 判断获取数据
			if(isParent==="true"){
				// 5.删除名称
				$parent.attr("name","");
				getCategory(type,tbcid,$parent,name);
			}else{
				console.log("当前选项为叶子目录tb");
				tbPropertyList(type,tbcid,$parent,name);
				$parent.nextAll().remove();
			}
		});
		//获取第三方平台上类目的子类目
		function getCategory(type,cid,$parent,name){
			// 3.ajax请求数据
			$.get("/category/tbcategory",{type:type,pid:cid},function(data){
				$parent.nextAll().remove();
				var $select = "<select name="+name+" class='thirdcategory' style='width: 150px;'> ";
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
		//获取第三方平台的属性
		function tbPropertyList(type,tbcid,$parent,name){
			console.log(tbcid);
			console.log(name);
			// 3.ajax请求数据
			$.get("/admin/data/getTbPropertyList",{type:type,tbcid:tbcid},function(data){
				console.log(data.data);
				$parent.nextAll().remove();
				var $select = "<select name="+name+" class='tbProperty' style='width: 150px;' > ";
				var options = "";
				var tbpropertyList = data.data;
				console.log(tbpropertyList);
				for(var i = 0 ; i<tbpropertyList.length ; i++){
					options += "<option value="+tbpropertyList[i].pid+">"+tbpropertyList[i].name+"</option>";
				}
				$select = $select+options+"</select>";
				
				if(tbpropertyList.length>0){
					$parent.after($select);
					$parent.attr("name","").next().attr("name",name);
				}
			});
		}
		
		$(".tbProperty").live('change',function(){
			var $parent = $(this);
			//1.获取属性值id
			console.log($parent.val());
			var pid = $parent.val();
			var cid = $parent.prev().val();
			var type = $("#platType").val();
			
			var name = $parent.attr("class");
			
			tbPropertyValueList(type,cid,pid,$parent,name);
			$parent.nextAll().remove();
		});
		//获取第三方平台上属性对应的属性值
		function tbPropertyValueList(type,cid,pid,$parent,name){
			$.get("/admin/data/getTbPropertyValues",{type:type,tbcid:cid,tbpid:pid},function(data){
				$parent.nextAll().remove();
				var $select = "<select name='"+name+"' class='tbPropertyValue' style='width: 150px;'> ";
				var options = "";
				var tbpropertyValuesList = data.data;
				console.log(tbpropertyValuesList);
				if(tbpropertyValuesList!=null){
					for(var i = 0 ; i<tbpropertyValuesList.length ; i++){
						options += "<option value="+tbpropertyValuesList[i].vid+">"+tbpropertyValuesList[i].name+"</option>";
					}
				}
				$select = $select+options+"</select>";
				
				if(tbpropertyValuesList.length>0){
					$parent.after($select);
					$parent.attr("name","").next().attr("name",name);
				}
			});
		}
		$(".tbPropertyValue").live('change',function(){
			$("#pvalue").val($("option:selected",$(this)).text());
			$("#addref").click();
		});
		
		// 添加属性值
		$("#addref").click(function(){
			
			//智谷平台属性ID
			var propID = $(".property").val();
			//添加的属性值名称
			var name = $("#pvalue").val();
			//类目ID
 			var cid = $(".property").prev().val();
			//第三方属性值ID
			var tbpvid = $(".tbPropertyValue").val();
			//第三方属性值名称
			var tbpvname = $("option:selected",$(".tbPropertyValue")).text();
			
			var json = {propID:propID,name:name,cid:cid,tbpvid:tbpvid,tbpvname:tbpvname};
			
			// b.发送数据到后台
			$.post("/admin/data/value/save",json,function(data){
				var ref = data.data;
				if(data.status){
					var html = "<tr><td>"+ref.propertyId +"</td><td>"+ref.id+"</td><td>"+ref.name+"</td><td><input class='delbtn' type='button' data='"+ref.id+"'  value='删除'/></td></tr>";
					if($("#showPValue tr").length===0){
						$("#showPValue").append(html);
					}else{
						$("#showPValue tr:first").before(html);
					}
					
				}else{
					alert("添加失败，请重新添加！");
				}
			});
		});
		
	});
</script>
	
	
</body>
</html>
