<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<iframe name="upfile_frame" id="upfile_frame" style="display: none;"></iframe>

<div id="upFileSpaceDiv" class="easyui-dialog" closed="true" modal="true" title="上传文件" style="width:400px;height:200px;">
	<span class='red' id='upToFolderName'></span><br/>
	<form name="upFileSpaceForm" id="upFileSpaceForm" method="post" action="/upload/img" enctype="multipart/form-data" target="upfile_frame">
		<input type="hidden" id="upFileType" name="ftype">
		<input type="hidden" id="upFolderID" name="upFolderID">
		<div class="mt30 ml20">请选择图片：<input type="file" name="upfile" id="spacefileBtn"/></div>
		<div class="clear"></div><br />
	</form>
</div>
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
	var zhigu = {};
}
if (typeof zhigu.userSpace == "undefined" || !zhigu.userSpace) {
	zhigu.userSpace = {};
}
// 上传完成后服务器回调函数
zhigu.userSpace._upfileCallBack = null;
function popUpfileToSpace(upFileType,upFolderID,cbfun,okFun,cancelFun){
	if(zTree){
		var curNode = zTree.getSelectedNodes()[0];
		if(curNode){
			$("#upToFolderName").html('上传到：'+curNode.name);
		}
	}
	// upFileType 是FileUtil中定义
	$("#upFileType").val(upFileType);
	$("#upFolderID").val(upFolderID);
	zhigu.userSpace._upfileCallBack = function(data){
		if(data.flag == 1){
			dialog(data.msg);
		}
		if(data.flag == 0 && typeof(cbfun) == 'function'){
			cbfun(data);
		}
		$('#upFileSpaceDiv').dialog('close');
		$('#spacefileBtn').val('');
	};
	
	$('#upFileSpaceDiv').dialog({
		onClose : function() {
			zhigu.userSpace._cancelUpSpacefile();
			if (typeof (eval(cancelFun)) == "function")
				cancelFun();
		},
		buttons : [ {
			text : '　确定　 ',
			handler : function() {
				if(zhigu.cmn.isCanUploadFile()){
					var c = true;
					if (typeof (eval(okFun)) == "function"){
						c = okFun();
					}
					if (c || c == undefined){
						zhigu.userSpace._confirmUpSpacefile();
					}
				}
			}
		}, {
			text : '　取消　',
			handler : function() {
				zhigu.userSpace._cancelUpSpacefile();
				if (typeof (eval(cancelFun)) == "function")
					cancelFun();
				$("#upFileSpaceDiv").dialog("close");
			}
		} ]
	});
	
	$("#upFileSpaceDiv").dialog("move",{top:$(document).scrollTop() + 250});
	$("#upFileSpaceDiv").dialog("open");
};
//上传图片
zhigu.userSpace._confirmUpSpacefile = function(){
	var type = /\.(gif)|(jpeg)|(jpg)|(bmp)|(png)|(zip)|(rar)$/;
	if($("#spacefileBtn").val() == null || $("#spacefileBtn").val() == ""){
		dialog("请选择上传文件！");
		return;
	}else if(!type.test($("#spacefileBtn").val().toLowerCase())){
		dialog("不支持的文件格式！");
		return;
	}
	$("#upFileSpaceForm").submit();
	$('#upFileSpaceDiv').dialog('close');
};
//取消上传，执行清楚操作
zhigu.userSpace._cancelUpSpacefile = function(){
	$('#spacefileBtn').val('');
}
</script>