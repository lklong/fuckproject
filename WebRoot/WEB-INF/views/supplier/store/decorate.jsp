<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>店铺装饰</title>
<link rel="stylesheet" type="text/css" href="/js/3rdparty/webuploader/webuploader.css" />
<link rel="stylesheet" type="text/css" href="/js/3rdparty/colorpicker/css/colpick.css" />
<script type="text/javascript" src="/js/3rdparty/webuploader/webuploader.js"></script>
<script type="text/javascript" src="/js/3rdparty/layer1.9/layer.js"></script>
<script type="text/javascript" src="/js/3rdparty/colorpicker/js/colpick.js"></script>
<style type="text/css">
	#picker {
	margin:0;
	padding:0;
	border:0;
	width:70px;
	height:20px;
	border-right:20px solid green;
	line-height:20px;
}
</style>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">店铺装饰</h4>
    <form id="updateDecorate">
  <table cellpadding="0" cellspacing="0" class="user-form-table">
    <tr>
      <td style="width:12%">店铺logo：</td>
      <td style="width:88%"><p><img src="${store.logoPath }" style="width: 120px; height: 120px;" id="logoUploadPreview" /></p>
        <p>请上传图片大小不超过80K，此图会自动生成80x80的规格</p>
        <p><a id="logoUploadDiv">上传logo</a></p></td>
    </tr>
	<form enctype="multipart/form-data"  method="post" id="updateDecorate">
      <tr>
        <td>店铺简介：</td>
        <td><textArea class="dianpujianjie mt10" id="introduction" name="introduction">${store.introduction }</textArea></td>
      </tr>
      <tr>
      	<td>导航条颜色</td>
      	<td>#<input type="text" id="picker" name="navColor" value="${store.navColor}" style="border-right:#'${store.navColor}'"/></td>
      </tr>
      <tr>
      	<td>店招背景图预览图</td>
      	<td>
	      	<c:if test="${store.signagePath !=null }">
	      		<img id="logoUploadPreview1" src="${store.signagePath}" style="max-width:880px;" />
	       </c:if>
	       	<c:if test="${store.signagePath ==null }">
	      		<img id="logoUploadPreview1" src="/img/default/shop_banner.jpg" style="max-width:880px;" />
	       </c:if>
      	</td>
      </tr>
      <tr>
      	<td>&nbsp;</td>
      	<td><a id="logoUploadDiv1">上传店招背景图</a></td>
      </tr>
      <tr>
        <td colspan="2"><input type="button" onclick="updateDecorate();" class="input-button" value="保存"/>
          <input type="submit" class="baochun" value="保存" style="display: none" id="subForm" />
          <input type="hidden" id="logoPath" name="logoPath" />
          <input type="hidden" id="logoPath1" name="signagePath" />
          </td>
      </tr>
  </table>
    </form>
</div>
<script type="text/javascript">
		// ===============图片上传初始化  start================
		// 优化retina, 在retina下这个值是2
/* 		var ratio = window.devicePixelRatio || 1,
		// 缩略图大小
		thumbnailWidth = 100 * ratio, thumbnailHeight = 100 * ratio, imgSizeLimit = 1024 * 800; */

		var imgUploader = WebUploader.create({
			auto : true,
			// swf文件路径
			swf : '/js/3rdparty/webuploader/Uploader.swf',
			// 文件接收服务端。
			server : '/upload/store/img',
			formData : {
				'source':3
			},
			// 选择文件的按钮。可选。
			pick : '#logoUploadDiv',
			fileSingleSizeLimit : 1024 * 80,
			// 只允许选择文件，可选。
			accept : {
				title : 'Images',
				extensions : 'jpg,jpeg,bmp,png',
				mimeTypes : 'image/*'
			},
			duplicate : true
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
			if(handler == "Q_TYPE_DENIED"){
    			layer.alert("仅支持jpg,jpeg,bmp,png图片格式的文件上传");
    		}
		});
		// ===============图片上传初始化  end================
			
		// ===============图片上传初始化  start================
		var imgUploader2 = WebUploader.create({
			auto : true,
			// swf文件路径
			swf : '/js/3rdparty/webuploader/Uploader.swf',
			// 文件接收服务端。
			server : '/upload/store/img',
			formData : {
				'source':7
			},
			// 选择文件的按钮。可选。
			pick : '#logoUploadDiv1',
			fileSingleSizeLimit : 1024*300,
			// 只允许选择文件，可选。
			accept : {
				title : 'Images',
				extensions : 'jpg,jpeg,bmp,png',
				mimeTypes : 'image/*'
			},
			duplicate : true,
			compress:false
		});
		//  加入上传队列前check
		imgUploader2.on('beforeFileQueued', function(file) {
			var size = file.size;
			console.log(size);
			if (size > 1024 * 300) {
				layer.alert("文件大小不能超过300k！");
				return false;
			}

		});

		imgUploader2.on('uploadSuccess', function(file, response) {
			if (response.code == zhigu.code.success) {
				var logoUrl = response.data.uri;
					$("#logoUploadPreview1").attr("src",logoUrl);
					$("#logoPath1").val(logoUrl);
			} else {
				layer.alert(response.msg);
				// 上传失败标记为移除，否则不能重新选择该文件上传
				imgUploader.removeFile(file);
			}
		});
		imgUploader2.on('uploadError', function(file) {
			layer.alert('上传失败：' + file.name);
			// 上传失败标记为移除，否则不能重新选择该文件上传
			imgUploader.removeFile(file);
		});
		imgUploader2.on('error', function(handler) {
			if (handler == "F_EXCEED_SIZE") {
				layer.alert("文件大小不能超过300k");
			}
		
			if(handler == "Q_TYPE_DENIED"){
    			layer.alert("仅支持jpg,jpeg,bmp,png图片格式的文件上传");
    		}
		});
		// ===============图片上传初始化  end================
			
			
		// 取色
		$('#picker').colpick({
			layout:'hex',
			submit:0,
			color:"#${store.navColor}",
			colorScheme:'dark',
			onChange:function(hsb,hex,rgb,el,bySetColor) {
				$(el).css('border-color','#'+hex);
				// Fill the text box just if the color was set using the picker, and not the colpickSetColor function.
				if(!bySetColor) $(el).val(hex);
			}
		}).keyup(function(){
			$(this).colpickSetColor(this.value);
		});
		function updateDecorate() {
			$.post("/supplier/store/decorate",$("#updateDecorate").serialize(),function(msgBean){
				if(msgBean.code === 1){
					layer.msg("修改成功！",{
						shade:[0.8],
						shadeClose:false,
						time:3000
					},function(){
						window.location.href = "/supplier/store/lookStore";
					});
				}
			})
		};
	</script>
</body>
</html>