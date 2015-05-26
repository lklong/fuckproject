<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<iframe name="upfile_frame" id="upfile_frame" style="display: none;"></iframe>

<div id="upFileDiv" class="easyui-dialog" closed="true" modal="true" title="上传文件" style="width:400px;height:200px;">
	<form name="upFileForm" id="upFileForm" method="post" action="/upload/uploadImageFile" enctype="multipart/form-data" target="upfile_frame">
		<input type="hidden" id="ftype" name="ftype">
		<div class="mt30 ml20">请选择文件：<input type="file" name="preImageFile" id="fileBtn"/></div>
		<input name="callBackFun"  id="callBackFun" type="hidden" value="callbackImagePre"/>
		<div class="clear"></div><br />
	</form>
</div>
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
	var zhigu = {};
}
if (typeof zhigu.admin == "undefined" || !zhigu.admin) {
	zhigu.admin = {};
}

zhigu.admin._upfileCallBack = null;
function popUpfile(ftype,cbfun,okFun,cancelFun,uploadto){
	$("#ftype").val(ftype);
	$("#upFileFrom").prop("action","/upload/uploadImageFile");
	zhigu.admin._upfileCallBack = function(data){
		if(data.flag == 1){
			dialog(data.msg);
		}
		if(data.flag == 0 && typeof(cbfun) == 'function'){
			cbfun(data);
		}
		$('#upFileDiv').dialog('close');
		$('#fileBtn').val('');
	};
	
	$('#upFileDiv').dialog({
		onClose : function() {
			_cancelUpfile();
			if (typeof (eval(cancelFun)) == "function")
				cancelFun();
		},
		buttons : [ {
			text : '　确定　 ',
			handler : function() {
				ajaxSubmit("/upload/uploadedSize",{},function(progressEntity){
					if(progressEntity.pBytesRead<progressEntity.pContentLength){
						alert("你有其他文件正在上传！请完成后再上传此文件。"); 
					}else{
						var c = true;
						if (typeof (eval(okFun)) == "function")
							c = okFun();
						if (c || c == undefined)
							_confirmUpfile();
					}
				});
			}
		}, {
			text : '　取消　',
			handler : function() {
				_cancelUpfile();
				if (typeof (eval(cancelFun)) == "function")
					cancelFun();
			}
		} ]
	});
	
	$("#upFileDiv").dialog("move",{top:$(document).scrollTop() + 250});
	$("#upFileDiv").dialog("open");
}
//上传图片
function _confirmUpfile(){
	var type = /\.(gif)|(jpeg)|(jpg)|(bmp)|(png)|(zip)|(rar)$/;
	if($("#fileBtn").val() == null || $("#fileBtn").val() == ""){
		dialog("请选择上传文件");
		return;
	}else if(!type.test($("#fileBtn").val().toLowerCase())){
		dialog("不支持的文件格式");
		return;
	}
	$("#upFileForm").submit();
	$('#upFileDiv').dialog('close');
}
//取消上传
function _cancelUpfile(){
	$('#fileBtn').val('');
	$("#upFileDiv").dialog("close");
}
</script>