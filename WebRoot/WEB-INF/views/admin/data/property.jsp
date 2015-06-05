<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />

<title>智谷类目属性管理</title>
<link href="js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css">
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
						属性管理 ：当前类目 &nbsp;&nbsp;&nbsp;&nbsp;${category.name}
					</h2>
				</div>
	<div class="contentbox">
						
		<div style="height: auto; border: 1px solid #f7f7f7; margin-bottom: 10px; margin-top: 10px;">
		
		<form action="">
		  <table style="width:100%;">
		    <thead>
		      <tr>
			      <th style="width:35%">属性数据来源<select id="platType" name="platType" style="width:20%"><option value="1">淘宝</option><option value="2">阿里巴巴</option></select></th>
			      <th style="width:10%">智谷属性名称</th>
			      <th style="width:50%">附加属性选择</th>
			      <th style="width:5%">操作</th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		      <td>
		      	<select name="thirdcategory" class="thirdcategory" style="width:100px;" >
		      		<option>请选择</option>
		      		<c:forEach items="${tbcategory}" var="item">
			      	<option value="${item.cid}" isParent="${item.isParent}">${item.name}</option> 
			      </c:forEach>
		      	</select>
		      </td>
		      <td><input name="name" type="text"/></td>
		      <td>
		      	<input type="checkbox" name="isAlias" class="extraprop"/>别名
		      	<input type="checkbox" name="isNunm" class="extraprop"/>枚举
		      	<input type="checkbox" name="isColor" class="extraprop"/>颜色
		      	<input type="checkbox" name="isKey" class="extraprop"/>关键
		      	<input type="checkbox" name="isSell" class="extraprop"/>销售
		      	<input type="checkbox" name="isSearch" class="extraprop"/>搜索
		      	<input type="checkbox" name="isInput" class="extraprop"/>输入
		      	<input type="checkbox" name="isRequired" class="extraprop"/>必须
		      	<input type="checkbox" name="isMult" class="extraprop"/>多选
		      	<input type="hidden" name="status" value="1"/>
		      	<input type="hidden" name="pid" />
		      	<input type="hidden" name="pname" />
		      	<input type="hidden" name="catId" value="${category.id}"/>
		      </td>
		     
		       <td><input value="添加属性" type="button" id="addref"/></td>
		      </tr>
		    </tbody>
		  </table>
		  </form>
		  
		</div>
		
		
		<div style="height: auto; border: 1px solid #f7f7f7;">
		  <table style="width:100%">
		    <thead>
		      <tr>
		        <td>id</td>
		        <td>属性名称</td>
		        <td>操作</td>
		      </tr>
		    </thead>
		    <tbody id="showCatRef">
		    <c:forEach items="${props}" var="item">
		    	<tr>
		    	<td>${item.id }</td>
		        <td>${item.name }</td>
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
		
		$(".extraprop").click(function(){
			if(this.checked){
				this.value = 1;
			}else{
				this.value = 0;
			}
		});
		
		var tpcatId = parseInt("${pcategory.code}");
		$(".thirdcategory").val(tpcatId);
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

			// 判断获取数据
			if(isParent==="true"){
				
				// 5.删除名称
				$parent.attr("name","");
				
				getCategory(type,cid,$parent,name);
				
			}else{
				
				console.log("当前选项为叶子目录");
				$parent.nextAll().remove();
				
				// 加载属性
				$.get("/taobao/ajax/props",{cid:cid},function(data){
					var props = data.data;
					if(props!=null){
						var html = "<select class='tbprop' >"
						var options = "";
						for(var i = 0; i<props.length;i++){
							var prop = props[i];
							
							options += "<option value='"+prop.pid+"' "+
							"isalias='"+prop.isAllowAlias+"'"+ 
							"iscolor='"+prop.isColorProp+"'"+
							"isnunm='"+prop.isEnumProp+"'"+
							"isinput='"+prop.isInputProp+"'"+
							"iskey='"+prop.isKeyProp+"'"+
							"issell='"+prop.isSaleProp+"'"+
							"ismult='"+prop.multi+"'"+
							"isrequired='"+prop.must+"'"+
							">"+prop.name+"</option>"
						}
						html += options+"</select>"
						$parent.after(html);
					}
				});
				
			}
			
		});
		
		$(".tbprop").live("change",function(){
			
			$(".extraprop").each(function(i,n){
				n.checked = false;
				n.value = 0;
			});
			
			var prop = $("option:selected" , $(this));
			
			var isAlias = prop.attr("isalias");
			var isColor = prop.attr("iscolor");
			var isNunm = prop.attr("isnunm");
			var isInput = prop.attr("isinput");
			var isKey = prop.attr("iskey");
			var isSell = prop.attr("issell");
			var isMult = prop.attr("ismult");
			var isRequired = prop.attr("isrequired");
			
			console.log(isColor);
			
			if(isAlias === "true" )$("input[name='isAlias']").attr("checked",true).val("1");
			if(isColor === "true")$("input[name='isColor']").attr("checked",true).val("1");
			if(isNunm === "true")$("input[name='isNunm']").attr("checked",true).val("1");
			if(isInput === "true")$("input[name='isInput']").attr("checked",true).val("1");
			if(isKey === "true")$("input[name='isKey']").attr("checked",true).val("1");
			if(isMult === "true")$("input[name='isMult']").attr("checked",true).val("1");
			if(isRequired === "true")$("input[name='isRequired']").attr("checked",true).val("1");
			if(isSell === "true")$("input[name='isSell']").attr("checked",true).val("1");
			
			var name = prop.text();
			var pid = $(this).val();
			
			$("input[name='name']").val(name);
			$("input[name='pid']").val(pid);
			$("input[name='pname']").val(name);
			
		});
		
		
		function getCategory(type,cid,$parent,name){
			// 3.ajax请求数据
			$.get("/category/tbcategory",{type:type,pid:cid},function(data){
				$parent.nextAll().remove();
				var $select = "<select name="+name+" class='thirdcategory' style='width:100px;'><option value='0'>请选择</option>";
				var options = "";
				var cats = data.data;
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
		
		// 添加属性
		$("#addref").click(function(){
			var url = "/admin/data/propperty/save";
			$.post(url,$("form").serialize(),function(data){
				if(data.status){
					var obj = data.data;
					var len = $("#showCatRef tr").length;
					var html = "<tr><td>"+obj.id+"</td><td>"+obj.name+"</td><td><input class='delbtn' type='button' data="+data.data.id+" value='删除'/><input data="+data.data.id+" type='button' value='添加属性值' class='addpropbtn'/></td></tr>";
					if(len === 0 ){
						$("#showCatRef").append(html)
					}else{
						$("#showCatRef tr:first").before(html);
					}
				}else{
					alert("添加失败，请重新添加");
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
