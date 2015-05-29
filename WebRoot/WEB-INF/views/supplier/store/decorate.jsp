<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>店铺装饰</title>
<link rel="stylesheet" type="text/css" href="/js/3rdparty/webuploader/webuploader.css" />
<script type="text/javascript" src="/js/3rdparty/webuploader/webuploader.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">店铺装饰</h4>
  <table cellpadding="0" cellspacing="0" class="user-form-table">
    <tr>
      <td>店铺logo：</td>
      <td><p><img src="${store.logoPath }" style="width: 120px; height: 120px;" id="logoUploadPreview" /></p>
        <p>请上传图片大小不超过80K，此图会自动生成80x80的规格</p>
        <p><a  id="logoUploadDiv">上传logo</a></p></td>
    </tr>
    <form enctype="multipart/form-data" action="supplier/store/updateDecorate" method="post" id="updateDecorate">
      <tr>
        <td>店铺简介：</td>
        <td><textArea class="dianpujianjie mt10" id="introduction" name="introduction">${store.introduction }</textArea></td>
      </tr>
      <tr>
        <td colspan="2"><a href="javascript:;" onclick="updateDecorate();" class="default-a">保存</a>
          <input type="submit" class="baochun" value="保存" style="display: none" id="subForm" />
          <input type="hidden" id="logoPath" name="logoPath" />
          <input type="hidden" id="signagePath" name="signagePath" /></td>
      </tr>
    </form>
  </table>
  <iframe name="imgUpload_hidden_frame" id="imgUpload_hidden_frame" style="display: none"></iframe>
</div>
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
