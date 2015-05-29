<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun"%>
<!DOCTYPE html >
<html >
<head><base href="${applicationScope.basePath}"/>

</head>
<body>
<!-- //功能条// -->
<div class="sysContBar">
	<a href="javascript:openSaveDialog(0)" class="sysButonA2"><em></em>新增角色</a>
</div>
<table cellpadding="0" cellspacing="0" class="sysCommonTable _memTable">
	<tr>
		<th>角色名</th>
		<th>拥有权限</th>
		<th>操作</th>
	</tr>
	<c:forEach items="${adminRoles}" var="role">
	<tr>
		<td>${role.roleName }<input type="hidden" id="edit_roleName" value="${role.roleName}"/></td>
		<td>
			<c:forEach items="${role.adminResource }" var="resource" varStatus="vs">
				${resource.resourceName }<c:if test="${!vs.last }">、</c:if><c:if test="${vs.count%10==0 }"><br/></c:if>
				<input type="hidden" name="edit_resourceID" value="${resource.resourceID}"/>
			</c:forEach> 
		</td>
		<td>
			<c:if test="${role.roleID!=1}">
				<a href="javascript:void(0);" onclick="openSaveDialog(${role.roleID},this);" class="sysButonA1"><em></em>修改</a>
			</c:if>
		</td>
	</tr>
	</c:forEach>
</table>
<!--dialog-->
<div id="adminRoleDlg" style="display:none;">
	<div style="height:20px;"></div>
	<input type="hidden" id="now_roleID" value=""/>
	<table cellpadding="5" cellspacing="5" style="width:720px;margin:0 10px; height:220px;">
	       <tr>
	           <td>角色名：</td>
	           <td><input type="text" id="new_roleName"/></td>
	       </tr>
	       <tr>
	           <td>权限:</td>
	           <td id="new_resource_area"></td>
	       </tr>
	</table>
	<div style="height:20px;"></div>
	<div style="height:60px;background-color:#f0f0f0;padding-top:20px;">
		<div style="margin:0 auto; width:180px;">
			<a href="javascript:void(0)" class="sysButonA3" id="saveCreate"><em></em>&nbsp;&nbsp;&nbsp;确定&nbsp;&nbsp;&nbsp;</a>
			<a href="javascript:void(0)" class="sysButonA2" id="cancelClose"><em></em>&nbsp;&nbsp;&nbsp;取消&nbsp;&nbsp;&nbsp;</a>
		</div>
	</div>
</div>

<script type="text/javascript">

var roleInfoLayer = null;	//div编辑框对象

//编辑管理员权限
//<zy> 改_1
//2015-3-13 13:24
function openSaveDialog(roleID,obj){
		var roleName='';
		var resourceIDs = [];
		$("#now_roleID").val(0);
		if(roleID>0){
			$("#now_roleID").val(roleID);
			var tr = $(obj).parents("tr");
			roleName = tr.find("#edit_roleName").val();
			tr.find("input[name='edit_resourceID']").each(function(){
				resourceIDs.push($(this).val());
			});
		}
		 ajaxSubmit("admin/adminuser/resourceall", {}, function(data){
			var html = "<table><tbody>";
			$("#new_roleName").val(roleName);
			var trNum = 0;
			for(var i=0;i<data.length;i++){
				var adminResource = data[i];
				var flg = false;//选中状态
				for(var j=0;j<resourceIDs.length;j++){
					if(adminResource.resourceID==resourceIDs[j]){
						flg=true;
						break;
					}
				}
				if(/0000$/.test(adminResource.resourceTreeBM)){
					html+="<tr><td>>>"+adminResource.resourceName+"：</td></tr>";
					trNum=0;
				}else{
					if(trNum%4==0)html+="<tr><td></td>";
					html+="<td><input type='checkbox'";
					if(flg==true)html+=" checked='true' ";
					html+="name='new_resource' value='"+adminResource.resourceID+"' id='new_resource_"+adminResource.resourceID+"'/>"+"<label for='new_resource_"+adminResource.resourceID+"'>"+adminResource.resourceName+"</label>　";
					html+="</td>";
					if(trNum+1%4==0)html+="</tr>";
					trNum++;
				}
			}
			html += "</tbody></table>";
			$("#new_resource_area").html(html);
		},"json");
	 
	 //弹出编辑框
	 roleInfoLayer = $.layer({
			 	type : 1,
			    shade: [0.5, '#000'],
			    area: ['auto','auto'],
			    title : '编辑/新增角色权限',
			    page: {
			    	dom : '#adminRoleDlg'
			    }
			});
}

//绑定取消按钮
$('#cancelClose').on('click', function(){
	closeRoleInfoLayer();
});
//绑定确定按钮
$('#saveCreate').on('click', function(){
	save();
});

//关闭管理员信息弹出框
function closeRoleInfoLayer()
{
	if(roleInfoLayer != null)
	{
		layer.close(roleInfoLayer);
	}
}

//保存修改信息
//<zy> 改_1
//2015-3-13 13:24
function save(){
	var name = $("#new_roleName").val();
	var new_resource = [];
	if(!name||name.length==0){
		layer.msg('请填写角色名！', 1, 3);
		return;
	}
	$("input[name='new_resource']:checked").each(function(){
		new_resource.push($(this).val());
	});
	$.layer({
	    shade: [0.5, '#000'],
	    area: ['auto','auto'],
	    dialog: {
	        msg: '确认保存角色：'+name+'？',
	        btns: 2,                    
	        type: 4,
	        btn: ['确定','取消'],
	        yes: function(){
	        	ajaxSubmit("/admin/adminuser/saveRole",{"roleID":$("#now_roleID").val(),"roleName":name,"resourceIDs":new_resource},function(msgBean){
	        		if(msgBean.code == zhigu.code.success){
						layer.msg(msgBean.msg, 1, f5);
					}else{
						layer.alert(msgBean.msg);
					}
	    		},"json");
	        }
	    }
	});
}
</script>
</body>
</html>