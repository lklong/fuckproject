<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="css/default/jcDate.css">
<script type="text/javascript" src="js/jQuery-jcDate.js"></script>
<link rel="stylesheet" type="text/css" href="/js/3rdparty/webuploader/webuploader.css"/>
<script type="text/javascript" src="/js/3rdparty/webuploader/webuploader.js"></script>
<!-- <script src="js/admin/member.js" type="text/javascript"></script> -->
<style type="text/css">
.shili1 { 
	display:block; 
	height:176px; 
	width:253px; 
	background:url(../../img/default/sfzsl.jpg) no-repeat left top; 
	float:left;}
.checkMsg { 
	color:#ff1100;}
.input-txt { 
	width:200px; 
	height:28px; 
	border:1px solid #9a9a9a;}

</style>
<script type="text/javascript">
$(document).ready(function() {
	$("input.jcDate").jcDate({
		IcoClass : "jcDateIco",
		Event : "click",
		Speed : 100,
		Left : 0,
		Top : 28,
		format : "-",
		Timeout : 100
	});
	$("#jcDate").css("z-index","2147483647");
	// ===============图片上传初始化  start================
    // 优化retina, 在retina下这个值是2
    var ratio = window.devicePixelRatio || 1,
    // 缩略图大小
    thumbnailWidth = 100 * ratio,
    thumbnailHeight = 100 * ratio,
    imgSizeLimit = 1024*800;

    var imgUploader = WebUploader.create({
        auto: true,
        // swf文件路径
        swf:  '/js/3rdparty/webuploader/Uploader.swf',
        // 文件接收服务端。
        server: '/upload/img/userCard',
        // 选择文件的按钮。可选。
        pick: '#chooseUploadImg',
        fileSingleSizeLimit:imgSizeLimit,
        // 只允许选择文件，可选。
        accept: {
            title: 'Images',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/*'
        },
        duplicate:false
    });
		//  加入上传队列前check
    imgUploader.on( 'beforeFileQueued', function( file ) {
    	var size = file.size;
    	if(size>1024*1024*0.8){
    		layer.alert("文件大小不能超过800k！");
    		return false;
    	}
    });
		
    imgUploader.on( 'uploadSuccess', function( file,response ) {
    	if(response.code==zhigu.code.success){
    		var uri = response.data.uri;
    		$("#IDCard1").attr("src",uri);
			$("#cardFrontImg").val(uri);
    	}else{
    		layer.alert(response.msg);
    		// 上传失败标记为移除，否则不能重新选择该文件上传
        	imgUploader.removeFile(file);
    	}
    });
    imgUploader.on( 'uploadError', function( file ) {
    	layer.alert('上传失败：'+file.name);
    	// 上传失败标记为移除，否则不能重新选择该文件上传
    	imgUploader.removeFile(file);
    });
    imgUploader.on('error', function(handler) {
		if(handler=="F_EXCEED_SIZE"){
			layer.alert("文件大小不能超过"+(imgSizeLimit/1024)+"k");
		}
    });
// ===============图片上传初始化  end================
});
</script>

<div style="height:20px;"></div>
	<table cellpadding="4" cellspacing="4" style="width:600px;margin:0 10px; ">
		<c:if test="${realUserAuth.status==2 }">
		<tr><td><span style="color:red;">审核不通过原因：</span></td><td><span style="color:red;">${realUserAuth.rejectReason }</span></td></tr>
		</c:if>
		<form method="post" action="/admin/realUserAuth/addRealAuth" id="authForm" enctype="multipart/form-data">
		<input type="hidden" name="cardFrontImg" id="cardFrontImg" value="${ realUserAuth.cardFrontImg}"/>
		<input name="userId"  id="userID" type="hidden" value="${userID }"/>
		<tr>
			<td>真实姓名：</td>
			<td>
				<input class="input-txt" type="text" name="realName" id="realName" placeholder="请输入真实姓名" value="${realUserAuth.realName }" maxlength="8" />
	        		<span class="checkMsg" id="msgRealName"></span>
	        </td>
       	</tr>
		<tr>
			<td>身份证号码：</td>
			<td>
				<input class="input-txt" type="text" name="idCard" id="idCard" placeholder="请输入你的身份证号码" value="${realUserAuth.idCard }" maxlength="18" />
       				<span class="checkMsg" id="msgCardId"></span>
			</td>
		</tr>
		<tr>
			<td>身份证到期时间：</td>
			<td>
				<input class="jcDate input-txt" type="text" readonly id="cardValidity" name="cardValidityStr" value="${realUserAuth.cardValidity }" maxlength="10" style="border: 1px solid #ABADB3; height: 30px;" />
	       		<input class=" " type="checkbox" name="perpetualFlag" id="perpetualFlag" value="0" onchange="if($(this).is(':checked')){$('#cardValidity').hide();$(this).val(1);}else{$('#cardValidity').show();$(this).val(0);};" <c:if test="${realUserAuth.perpetualFlag==true }">checked="true"</c:if> />
	       		<label>长期</label>
	       		<span class="checkMsg" id="msgCardValidity"></span>
			</td>
		</tr>
		</form>
		<tr>
			<td>身份证正面：</td>
			<td>
				<div class="shimingbox" id="shimingbox1">
		        <div class="sfzbox fl" id="bimg1"> <img height="176" width="253" id="IDCard1" src="${realUserAuth.cardFrontImg}"> <span class="sfzscbg"></span>
		          <div id="chooseUploadImg" style="height:15px;text-align: center;line-height:30px;margin: -50px -160px 0px 0px;">选择上传</div>
		        </div>
		        <div class="shili fl" style="margin: 50px 0px 0px 0px;"><span style="margin:-20px 200px 0px 0px">示例：</span><span class="shili1"></span><span class="checkMsg" id="msgCodeimg1"></span></div>
		      	</div>
			</td>
		</tr>
	</table>
<div style="height:20px;"></div>
<div style="height:60px;background-color:#f0f0f0;padding-top:20px;">
	<div style="margin:0 auto; width:180px;">
		 	<a onclick="saveRealUserAuth()" href="javascript:void(0)" class="sysButonA3"><em></em>保存</a>
	</div>
</div>
