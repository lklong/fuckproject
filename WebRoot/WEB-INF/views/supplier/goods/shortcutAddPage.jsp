<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>快速发布商品</title>
<link type="text/css" rel="stylesheet" rev="stylesheet" href="/css/commodityManage/shortcutAddPage.css" />

<link rel="stylesheet" type="text/css" href="/js/3rdparty/webuploader/webuploader.css">
<script type="text/javascript" src="/js/3rdparty/webuploader/webuploader.js"></script>

</head>


<body>
<script src="../../js/ajaxfileupload.js"></script>
<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	快速发布商品<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">快速发布商品</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
     <div class="body_center2">
		<div class="contentDiv">
			本站客服代发货，客服QQ：
				<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2880306186&site=qq&menu=yes">
					<img src="http://www.sunkf.net/codes/one/images/q_1.gif" border="0" alt="点击咨询" title="点击咨询" style="margin-bottom: -5px">
				</a>
		</div>
		<div class="titleDiv">货物信息</div>
		<div class="contentDiv">
			<strong>重点提示</strong>：本功能是你将<font color="#ff3300">产品压缩包</font>在这里上传后，由我们客服免费帮你发布出来，客服发布的数据更准确，但是您<br />
			需要保证每个产品都有相对应的文字说明，文字说明包含<font color="#ff3300">（货号、价格、尺码、颜色、材质）</font>等基本信息，<font
				color="#ff3300">文字说明<br /> 必须是TXT文件，
			</font>否则无法正确发布。
		</div>
		<div class="contentDiv">
			<!-- 上传控件 -->
			<div class="scss" style="height:auto; width: 800px; border: 1px solid #dedede; padding:15px;">
				<div class="jibenform">
				 	<div id="chooseDataFile" style="float: left;margin-left: 25px;">上传产品压缩包</div>
				 		<div id="dataFileProgress" style="margin:10px 20px ; float: left">无产品压缩包</div>
					 	<input type="hidden" id="dataFilePath"  value="${saveFile }"/>
					 <div class="clear"></div>
				 </div>
				<br/><br/><br/>
				已发布的商品文件：<br/>
				<c:forEach var="shortcutgoods" items="${shortcutgoodsList}">
					<div id="shortcutGoodsContainerOld" >
						<div  id="shortcutGoods${ shortcutgoods.id  }"><span class="myName">${ shortcutgoods.realFileName  }</span>  <br/></div>
					</div>
				</c:forEach>
				<div id="shortcutGoodsContainerNew" >
				</div>
			</div>
		</div>
		<div class="titleDiv">使用说明</div>
		<div class="contentDiv">
			<p>
				1.使用方法：点击上图的<font color="#ff3300">"选择文件"</font>按钮，找到你所有需要发布的产品图片压缩包，然后点击<font
					color="#ff3300">"上传"</font>按钮，等待 上传完成，<br />在上传完成之前，请不要关闭窗口，也不要切换到其他页面。
			</p>
			<p>2.快速发布产品是将你所有的款式通过这里上传到服务器，我们人工为你发布。省去你去编辑的麻烦。</p>
			<p>3.人工发布效率有差异，一般上传成功后最长24小时内完成发布。</p>
		</div>
	</div>
     </div>
            <br style="clear:both;" />
        </div>
    </div>


	
<script type="text/javascript" >
//===============文件上传  start================
var dataUploader;// 数据包上传器
$(function() {
	// ===============初始化数据包上传  start================
	var $dataFileProgress = $('#dataFileProgress');
	var dataFileSizeLimit = 1024*1024*50;
	dataUploader = WebUploader.create({
        // 自动上传。
        auto: true,
        // swf文件路径
        swf:  '/js/3rdparty/webuploader/Uploader.swf',
        // 文件接收服务端。
        server: '/upload/data',
        formData:{},//附带参数
        // 选择文件的按钮。可选。
        pick: '#chooseDataFile',
        // 只允许选择文件，可选。
        accept: {
        	title: 'RAR Archive',
            extensions: 'rar',
            mimeTypes: 'application/x-rar-compressed'
        },
        fileSingleSizeLimit:dataFileSizeLimit
    });
 // 当有文件添加进来的时候
    dataUploader.on( 'beforeFileQueued', function( file ) {
		// 数据文件只保留最后一个
    	var fileArray = dataUploader.getFiles();
		var length = fileArray.length;
		for(var i=length;i>0;i--){
			dataUploader.removeFile( fileArray[i-1] );
		}
    });
 	// 文件开始上传
    dataUploader.on( 'uploadStart', function( file ) {
		$dataFileProgress.html("<span id='"+file.id+"'>"+file.name+" --> <span class='progress'></span>  <a href='javascript:void(0);' onclick='zhigu.cancelUpFile("+file.id+")'></a></span>");
    });
 	zhigu.cancelUpFile = function(fileId){
 		dataUploader.cancelFile(fileId);
 	}
 // 文件上传过程中创建进度条实时显示。
    dataUploader.on( 'uploadProgress', function( file, percentage ) {
        $( '#'+file.id).find('.progress').html((percentage * 100).toFixed(2) + '%');
    });
 // 文件上传成功，给item添加成功class, 用样式标记上传成功。
    dataUploader.on( 'uploadSuccess', function( file,response ) {
    	if(response.code==zhigu.code.success){
    		$("#dataFilePath").val(response.data.uri);
    		$( '#'+file.id).find('.progress').html('上传完成');
    	}else{
    		$( '#'+file.id).find('.progress').html("<span class='red'>"+response.msg+"</span>");
    		// 上传失败标记为移除，否则不能重新选择该文件上传
        	dataUploader.removeFile(file);
    	}
    });
 // 文件上传失败，现实上传出错。
    dataUploader.on( 'uploadError', function( file ) {
    	$( '#'+file.id).find('.progress').html('上传失败');
    	// 上传失败标记为移除，否则不能重新选择该文件上传
    	dataUploader.removeFile(file);
    });
    // 完成上传完了，成功或者失败，先删除进度条。
    dataUploader.on( 'uploadComplete', function( file ) {
    });
    dataUploader.on('error', function(handler) {
		if(handler=="F_EXCEED_SIZE"){
			dialog("文件大小不能超过"+(dataFileSizeLimit/1024/1024)+"M");
		}
    });
});
  //===============文件上传  end================
	zhigu.shortcutGoods.deleteShortcutGoods = function( id ){
		if( confirm("删除后不可恢复，确认删除？") ){
			
			$.ajax({
				type:"post",
				url:"/supplier/goods/shortcutDelete",
				asyn:false,
				data:{"id":id},
				success:function( date ){
					$("#shortcutGoods" + id).hide();
				}			
				
			});
			
		}
	}
	
	function checkFileExtName(){
		var  rt =  false;
		var extReg = /.rar$|.zip$/;
		
		var value =  $("#file").val();
		if( value==null ){
			alert("请选择上传文件");
		}
		rt =  extReg.test( value ) ;
		if( !rt ){
			alert("仅支持rar和zip压缩文件");
		}
		
		var filePath = $("#file").val();
		var fileName = filePath.substring( filePath.lastIndexOf( "\\" ) + 1, filePath.length );
		
		//class="myName"
		var myName =  $(".myName");
		for( var i = 0;i<myName.length;i++ ){
			var c = myName[i];
			c= $(c);
			if( fileName == c.html() ){
				rt = false;
				alert("重名");
				break;
			}
			
		}
		
		
		return rt;
	}
	
	var shortcutgoodsNotUpdate = $("#shortcutgoodsNotUpdate");
	var shortcutgoodsNotUpdateFile = $("#shortcutgoodsNotUpdateFile");
	function addFile( me ){
		var filePath = $(me).val() ;
		var fileName = filePath.substring( filePath.lastIndexOf( "\\" ) + 1, filePath.length );
		var fileLength = $(".fileNotUpdate").length;
		
		
		shortcutgoodsNotUpdate.append( "<div id='fileNotUpdate"+ fileLength+1 +"' class='fileNotUpdate' >" + fileName +  "<input type='button' onclick='deleteNotUpdateFile( this )' value='删除' ></input></div>" );
		shortcutgoodsNotUpdateFile.append( "<input id='inputfileNotUpdate"+ fileLength+1 +"' name='file' type='file' value='"+ filePath +"'  />" );
		
		var fileInput = $("#inputfileNotUpdate"+ fileLength+1 );
		
	}
	
	function deleteNotUpdateFile( me ){
		me = $(me);
		var inputEle = $("#input" + me.parent().attr("id") );
		inputEle.remove();
		me.parent().remove();
		

		
	}

</script>
</body>
</html>
