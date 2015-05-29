<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html >
<html >
<head><base href="${applicationScope.basePath}"/>

<link href="js/3rdparty/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="all" />
<title>用户图片空间</title>
</head>

<body>
<script type="text/javascript" language="javascript" src="js/3rdparty/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" language="javascript" src="js/3rdparty/zTree/js/jquery.ztree.exedit-3.5.min.js"></script>
<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	用户图片空间<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">用户图片空间</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="body_center2" style="height: 670px;" id="alldd">
		<div>
			<input value="上传图片" type="button" onclick="uploadImg();"/>
		</div>
		<div class="f14 mt20">你有免费空间${userInfo.userSpaceSize/1024/1024/1024 }G,现在已用<fmt:formatNumber pattern="#0.000" value="${userInfo.userSpaceUseSize/1024/1024/1024 }"></fmt:formatNumber>G</div>
		<br />
		<div class="f14 mt20"><input type="button" onclick="newFolder();" value="新建文件夹"></input></div>
		<div style="width: 150px;height: 500px;" class="fl">
			<div class="easyui-panel" style="height: 500px;">
				<div class="fl ztree"  id="folderTree" >
					加载用户文件夹...
				</div>
			</div>
		</div>
		<div id="loadFolderFile">文件夹文件...</div>
		
</div>
     </div>
            <br style="clear:both;" />
        </div>
    </div>
<form action="supplier/space/folderFile" id="folderFileForm">
	<input type="hidden" id="curFolderID"/>
</form>
<%-- <jsp:include page="../../include/upToUserSpace.jsp" /> --%>
<script type="text/javascript">
var zTreesetting={
	callback:{
		onClick:function(event, treeId, treeNode){
			$("#curFolderID").val(treeNode.id);
			loadFolderFile();
		},
		onRename: function(event, treeId, treeNode, isCancel) {
			ajaxSubmit("/supplier/space/updateFolderName",{"folderID":treeNode.id,"folderName":treeNode.name},function(msgBean){
				if(msgBean.code == zhigu.code.success){
					layer.msg(msgBean.msg, 1, f5);
					zTree.editName(treeNode);
				}else{
					layer.alert(msgBean.msg);
				}
			});
		}
	},
	data:{
		keep:{parent:true},
	},
	edit:{enable: true,showRemoveBtn: false,drag:{isCopy:false,isMove:false}},
	view:{showLine: false,selectedMulti:false}
}
var zTree;  
$(function(){
	//加载目录树
	ajaxSubmit("/supplier/space/folderTree",{},function(data){
		$("#folderTree").html("");
		zTree=$.fn.zTree.init($("#folderTree"), zTreesetting, data);
		var nodes = zTree.getNodes();
		//加载第一个文件夹文件
		zTree.selectNode(nodes[0],false);
		$("#curFolderID").val(nodes[0].id);
		loadFolderFile();
	},"json");
});
function loadFolderFile(){
	ajaxSubmit("/supplier/space/folderFile",{"folderID":$("#curFolderID").val()},function(data){
		$("#loadFolderFile").html(data);
	},"text");
}
function uploadImg(){
	popUpfileToSpace(1,$("#curFolderID").val(),function(data){
		dialog(data.msg,function(){
			if(data.flag==0)loadFolderFile();
		})
	});
}
function newFolder(){
	var newNode = {id:0,name:"新文件夹",isParent :true};
	newNode = zTree.addNodes(null, newNode)[0];
	zTree.editName(newNode);
}
</script>
</body>
</html>
