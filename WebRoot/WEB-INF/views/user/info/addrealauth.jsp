<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/jcDate.css" media="all" />
<script type="text/javascript" src="js/jQuery-jcDate.js"></script>

<link rel="stylesheet" type="text/css" href="/js/3rdparty/webuploader/webuploader.css"/>
<script type="text/javascript" src="/js/3rdparty/webuploader/webuploader.js"></script>
<title>实名认证</title>
</head>
<body>
	<div class="rightContainer">
		<!--// 标题 //-->
		<h3 class="rc_title">
			个人/个体户认证<a href="user/home">我的主页</a>
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<!--// tab切换条 //-->
			<div id="userCommTab" class="userCommTab">
				<ul>
					<li><a href="javascript:void(0);" class="uctSelected">个人/个体户认证</a></li>
				</ul>
			</div>
			<div id="userContents" class="userContents">
				<!--// 内容1 //-->
				<div class="body_center2">
					<c:if test="${realUserAuth.approveState==3}">
						<span class="red">* ${realUserAuth.rejectReason}</span>
					</c:if>
					<form method="post" action="user/addrealauth" id="authForm" enctype="multipart/form-data">
						<input name="codeimg1" id="codeimg1"  type="hidden" value="${companyAuth.image }"/>
							<c:if test="${realUserAuth!=null&&realUserAuth.approveState==2}">
								<div class="shimingbox">
									<strong class="red" style="position: relative; left: 80px;">* 未通过审核，请修改后重新提交。</strong>
								</div>
								<div class="shimingbox">
									<p style="position: relative; left: 60px;">未通过原因：${realUserAuth.rejectReason}</p>
								</div>
							</c:if>
							<div class="shimingbox">
								<p class="smtitle">账户名：</p>
								<p class="smneirong">${userAuth.username}</p>
							</div>
							<div class="shimingbox">
								<p class="smtitle">
									<span class="smxing">*</span>真实姓名：
								</p>
								<input class="smtext fl" type="text" name="realName" placeholder="请输入真实姓名" value="${realUserAuth.realName }" maxlength="8" /><span class="red checkMsg" id="msgRealName"></span>
							</div>
							<div class="shimingbox">
								<p class="smtitle">
									<span class="smxing">*</span>身份证号码：
								</p>
								<input class="smtext fl" type="text" name="cardId"  placeholder="请输入你的身份证号码" value="${realUserAuth.idCard }" maxlength="18" /><span class="red checkMsg" id="msgCardId"></span>
							</div>
							<div class="shimingbox">
								<p class="smtitle">
									<span class="smxing">*</span>身份证到期时间：
								</p>
								<p>
									<input class="jcDate c666" type="text" readonly="readonly" id="datec" name="datec" value="${realUserAuth.cardValidity }" maxlength="10" style="border: 1px solid #ABADB3; height: 30px;" />
								</p>
								<p>
									<input class="changqi fl" type="checkbox" name="codechk" value="1" onchange="if($(this).is(':checked')){$('#datec').hide();}else{$('#datec').show();};"
										<c:if test="${realUserAuth.perpetual==1 }">checked="true"</c:if> />长期
								</p>
								<span class="red checkMsg" id="msgCardValidity"></span>
							</div>
							<span class="red checkMsg" id="msgCodeimg1" style="padding-left: 200px;"></span>
					</form>
					<div class="shimingbox" id="shimingbox1">
						<p class="smtitle">
							<span class="smxing">*</span>身份证正面：
						</p>
						<div class="sfzbox fl" id="bimg1">
							<img height="165px;" width="244px;" id="IDCard1" src="${realUserAuth.cardFrontImg}"> <span class="sfzscbg"></span>
							<div  id="chooseUploadImg" style="height: 30px;text-align: center;line-height:30px;">选择上传</div>
						</div>
						<div class="shili fl">
							示例：<span class="shili1"></span>
						</div>
					</div>
						<div class="clear"></div><br><br>
					<div class="shimingbox" id="shimingbox1">
					<c:choose>
						<c:when test="${realUserAuth!=null&&realUserAuth.approveState==0}">
							<input value="审核中" class="shimingsub" style="text-align: center;" />
						</c:when>
						<c:otherwise>
							<input type="button" value="提交" class="shimingsub" onclick="authSubmit();"/>
						</c:otherwise>
					</c:choose>
					</div>
					</div>
				</div>

			</div>
			<br style="clear: both;" />
		</div>
	<div class="clear"></div>
	<iframe name="imgUpload_hidden_frame" id="imgUpload_hidden_frame" style="display: none"></iframe>
	
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
		            //formData:{specType:1,specs:"285x285,160x160"},
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
		        //imgUploader.addButton({id:'#chooseUploadImgToSpace'});
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
		    			$("#codeimg1").val(uri);
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
	function authSubmit(){
		var param = zhigu.cmn.formToObj("#authForm");
		var checkFlg = true;
		$(".checkMsg").html("");
		if(!param.realName||param.realName.length>30){
			$("#msgRealName").html("请正确填写真实姓名！");
			checkFlg = false;
		}
		if(!cardIdCheck(param.cardId)){
			$("#msgCardId").html("请正确填写身份证号码！");
			checkFlg = false;
		}
		if(!param.codeimg1){
			$("#msgCodeimg1").html("请上传身份证图片！");
			checkFlg = false;
		}
		if(!checkFlg){
			return false;
		}
		$.post("user/addrealauth",param,function(msgBean){
			if(msgBean.code==zhigu.code.success){
				f5();
			}else{
				zhigu.dialog(msgBean.msg);
			}
		},"json");
		
	}
	function cardIdCheck(cardId){
		var userCode = "";
		if (cardId.length == 15) {
			userCode = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
		} else {
			userCode = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
		}
		return userCode.test(cardId);
	}
	</script>
	
</body>
</html>