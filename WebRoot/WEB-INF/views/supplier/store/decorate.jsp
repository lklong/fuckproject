<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>店铺装饰</title>
<style type="text/css">
.file-box {
	overflow: hidden;
	position: relative;
	height: 30px;
	width: 120px;
}

.file-box input {
	cursor: pointer;
	z-index: 100;
	margin-top: -15px;
	margin-right: -25px;
	opacity: 0;
	filter: alpha(opacity = 0);
	font-size: 100px;
	position: absolute;
	top: 0;
	right: 0;
}
</style>
<link rel="stylesheet" type="text/css" href="/js/3rdparty/webuploader/webuploader.css" />
<script type="text/javascript" src="/js/3rdparty/webuploader/webuploader.js"></script>
</head>

<body>
	<div class="rightContainer">
		<!--// 标题 //-->
		<h3 class="rc_title">
			店铺装饰<a href="user/home">我的主页</a>
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<!--// tab切换条 //-->
			<div id="userCommTab" class="userCommTab">
				<ul>
					<li><a href="javascript:void(0);" class="uctSelected">店铺装饰</a></li>
				</ul>
			</div>
			<div id="userContents" class="userContents">
				<!--// 内容1 //-->
				<div class="body_center2" id="alldd">
					<ul class=" mt30 ml30 c666 f14 dpallzl">
						<li class="mt20">店铺logo：</li>
						<li class="sclogoab mt10"><img src="${store.logoPath }" style="width: 120px; height: 120px;" id="logoUploadPreview"></img></li>
						<li class="mt10">请上传图片大小不超过80K，此图会自动生成80x80的规格</li>
						<li class="mt10 ">
								<a  id="logoUploadDiv">上传logo </a> 
						</li>
						<form enctype="multipart/form-data" action="supplier/store/updateDecorate" method="post" id="updateDecorate">
							<li>店铺简介：</li>
							<textArea class="dianpujianjie mt10" id="introduction" name="introduction">${store.introduction }</textArea>
							<div class="xiaodian1 mt30"></div>
							<div class="clear"></div>

							<a onclick="updateDecorate();"><li class="baochun">保存</li></a> <input type="submit" class="baochun" value="保存" style="display: none"
								id="subForm"></input> <input type="hidden" id="logoPath" name="logoPath" /> <input type="hidden" id="signagePath" name="signagePath" />
						</form>
					</ul>
					<iframe name="imgUpload_hidden_frame" id="imgUpload_hidden_frame" style="display: none"></iframe>
				</div>
			</div>
			<br style="clear: both;" />
		</div>
	</div>
	<div class="clear"></div>
	<script type="text/javascript">
		// ===============图片上传初始化  start================
		// 优化retina, 在retina下这个值是2
		var ratio = window.devicePixelRatio || 1,
		// 缩略图大小
		thumbnailWidth = 100 * ratio, thumbnailHeight = 100 * ratio, imgSizeLimit = 1024 * 800;

		var imgUploader = WebUploader.create({
			auto : true,
			// swf文件路径
			swf : '/js/3rdparty/webuploader/Uploader.swf',
			// 文件接收服务端。
			server : '/upload/img',
			formData : {
				'specs':'80x80'
			},
			// 选择文件的按钮。可选。
			pick : '#logoUploadDiv',
			fileSingleSizeLimit : imgSizeLimit,
			// 只允许选择文件，可选。
			accept : {
				title : 'Images',
				extensions : 'jpg,jpeg,bmp,png',
				mimeTypes : 'image/*'
			},
			duplicate : false
		});
		//imgUploader.addButton({id:'#chooseUploadImgToSpace'});
		//  加入上传队列前check
		imgUploader.on('beforeFileQueued', function(file) {
			var size = file.size;
			if (size > 1024 * 80) {
				layer.alert("文件大小不能超过80k！");
				return false;
			}

		});

		imgUploader.on('uploadSuccess', function(file, response) {
			if (response.code == zhigu.code.success) {
				var logoUrl = response.data.uri+"_80x80.jpg";
					$("#logoUploadPreview").attr("src",logoUrl);
					$("#logoPath").val(logoUrl);
			} else {
				layer.alert(response.msg);
				// 上传失败标记为移除，否则不能重新选择该文件上传
				imgUploader.removeFile(file);
			}
		});
		imgUploader.on('uploadError', function(file) {
			layer.alert('上传失败：' + file.name);
			// 上传失败标记为移除，否则不能重新选择该文件上传
			imgUploader.removeFile(file);
		});
		imgUploader.on('error', function(handler) {
			if (handler == "F_EXCEED_SIZE") {
				layer.alert("文件大小不能超过80k");
			}
		});
		// ===============图片上传初始化  end================
		function updateDecorate() {
			$("#updateDecorate").submit();
		};
	</script>
</body>
</html>
