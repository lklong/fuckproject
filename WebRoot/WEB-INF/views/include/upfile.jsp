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

zhigu._upfileCallBack = null;
function popUpfile(ftype,cbfun,okFun,cancelFun,uploadto){
	$("#ftype").val(ftype);
	$("#upFileFrom").prop("action","/upload/uploadImageFile");
	zhigu._upfileCallBack = function(data){
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
				$("#upFileDiv").dialog("close");
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
		dialog("请选择上传文件！");
		return;
	}else if(!type.test($("#fileBtn").val().toLowerCase())){
		dialog("不支持的文件格式！");
		return;
	}
	alert($("#upFileForm").attr("action"));
	$("#upFileForm").submit();
	$('#upFileDiv').dialog('close');
}
//取消上传，执行清除操作
function _cancelUpfile(){
	$('#fileBtn').val('');
}
function filesize(){
	var maxsize = 2 * 1024 * 1024;//2M
	var errMsg = "上传的附件文件不能超过2M！！！";
	var tipMsg = "您的浏览器暂不支持计算上传文件的大小，确保上传文件不要超过2M，建议使用IE、FireFox、Chrome浏览器。";
	var browserCfg = {};
	var ua = window.navigator.userAgent;
	if (ua.indexOf("MSIE") >= 1) {
		browserCfg.ie = true;
	} else if (ua.indexOf("Firefox") >= 1) {
		browserCfg.firefox = true;
	} else if (ua.indexOf("Chrome") >= 1) {
		browserCfg.chrome = true;
	}
	try {
		var obj_file = document.getElementById("fileBtn");
		if (obj_file.value == "") {
			alert("请先选择上传文件！");
			return;
		}
		var filesize = 0;
		if (browserCfg.firefox || browserCfg.chrome) {
			filesize = obj_file.files[0].size;
		} else if (browserCfg.ie) {
			var obj_img = document.getElementById('fileBtn');
			obj_img.dynsrc = obj_file.value;
			filesize = obj_img.fileSize;
			alert(filesize);
		} else {
			alert(tipMsg);
			return;
		}
		if (filesize == -1) {
			alert(tipMsg);
			return;
		} else if (filesize > maxsize) {
			alert(errMsg);
			return;
		} else {
			alert("文件大小符合要求。");
			return;
		}
	} catch (e) {
		alert(e);
	}
}
</script>