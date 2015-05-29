<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>发布商品</title>
<link rel="stylesheet" type="text/css" href="/js/3rdparty/webuploader/webuploader.css"/>
<script type="text/javascript" src="/js/3rdparty/webuploader/webuploader.js"></script>
<link href="/js/3rdparty/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="/js/3rdparty/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="js/3rdparty/layer/layer.min.js"></script>
</head>
<body>
<div class="rightContainer fr">
		<!-- 标题 -->
    	<h4 class="ddtitle">发布商品</h4>
    	<!-- 商品操作选项 -->
    	<div class="fun-bar">
    		<ul class="fun-tabs">
				<c:choose>
					<c:when test="${sessionScope.sessionUser.userID==0&&sessionScope.sessionUser.fakeUserID>0 }">
						<li><a href="javascript:void(0)" class="sected">代发布商品</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="javascript:void(0)" class="sected">商品发布</a></li>
						<li><a href="supplier/goods/list?status=1">出售中的商品</a></li>
						<li><a href="supplier/goods/list?status=2">下架的商品</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
    	</div>
    	<!-- 填写基本信息开始 -->
    	<h4 class="ddtitle">1.商品基本信息</h4>
    	<br>
    	<div class="msg-alert"><span class="gantanhao"></span>带<span color="color-red"> * </span>号项为必填项目，敬请知悉。</div>
    	<form method="post" action="#">
    	<table cellpadding="0" cellspacing="0" class="user-form-table">
				<tr>
					<td style="width:10%"><strong class="color-red"> * </strong>商品类别：</td>
					<td style="width:90%">
					<div id="categorySelectDiv">
					<select onchange="zhigu.goods.loadCategory(this);" class="select-txt">
						<option value="" selected="selected">请选择</option>
						<c:forEach items="${category }" var="p">
							<option isparent="${p.isParent }" value="${p.id }">${p.name }</option>
						</c:forEach>
					</select>
					</div>
					</td>
				</tr>
				<tr>
					<td><strong class="color-red"> * </strong>商品标题：</td>
					<td>
					<input type="text" class="input-txt" style="width:550px;" id="name" onkeyup="zhigu.goods.checkTitleLen(this)"/><span class="color-gray ml10">还能输入<strong class="color-red" id="titleCount">30</strong>字</span></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;商品属性：</td>
					<td>
						<div class="msg-alert"><span class="gantanhao"></span>填错宝贝属性，可能会引起宝贝下架，影响您的正常销售。请认真准确填写！</div>
						<div id="attributes_sku">
					   		<div class="jibenform2">
								   <div class="shuxingbox"  id="goodsattr">
									 	<jsp:include page="property.jsp"></jsp:include>
								   </div>
					   		</div>
			   			</div>
			   			<!-- 商品规格信息列表 -->
					   	<div class="shuxingtable2" id="scletabletbody"></div>
		   			</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;商品总数：</td>
					<td><font class="fwb color-red fz14" id="sumAmount">0</font> 件</td>
				</tr>
				<tr>
					<td><strong class="color-red"> * </strong>商品重量：</td>
					<td><input type="text" class="input-txt"  id="weight" onkeyup='zhigu.goods.priceInputCheck(this);' onafterpaste='zhigu.goods.priceInputCheck(this);' maxlength='11'/> 千克(kg) （请确认商品实际重量，以便订单中运费的计算。）</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;商品图片：</td>
					<td>
						<div class="fun-bar" id="tupianheader">
					   	<ul class="fun-tabs">
						   	<li class="shangchuanselect" id="shangchuan1" onclick="com_img_upload();">本地上传</li>
						  <!--  	<li id="shangchuan2">图片空间</li> -->
						</ul>
						</div>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<!--本地上传-->
						<div class="shangchuanbox" id="localUpload">
							<div class="xuanzebox">
								<div id="chooseUploadImg">选择本地图片</div>
							</div>
							<div class="shangchuantishi">
								<p>温馨提示：</p>
								<ul>
									<li>1. 商品主图不能超过<strong class="color-red"> 800K </strong>，图片规格必须为<strong class="color-red"> 正方形 </strong>且大于<strong class="color-red"> 430x430 </strong>。</li>
									<li>2. 最多可以上传<strong class="color-red"> 5 </strong>张图片。</li>
									<li>3. 图片<strong class="color-red"> 1 </strong>必须上传。</li>
								</ul>
							</div>
						</div>
						<!--文件夹-->
						<div class="shangchuanbox hidden"  id="userspace-com-img">
						<div class="shangchuanleft">
							<div class="easyui-panel">
								<div class="fl ztree"  id="folderTree1" >
									加载用户文件夹...
								</div>
							</div>
							<div class="clear"></div>
						</div>
						<div id="com_shangchuanbox" class="fl"></div>
						</div>
						<!--预览图-->
						<div class="shangchuanbottom">
							<ul id="upimgul">
								<li class="prebakimg">
									<div class="imgbox" id="imgbox1">
										 <img src="/img/default/upload-img-bak.jpg" width="102" height="102"/>
									</div>
									<div class="fabubgtian hidden">
									<span class="" onclick="zhigu.goods.mleft(this)">左移</span>
									<span class="" onclick="zhigu.goods.mright(this)">右移</span>
									<span class="">×</span></div>
								</li>
							</ul>
						</div>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;商品详情：</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2"><jsp:include page="../../../ueditor/index_desc.jsp"></jsp:include></td>
				</tr>
		</table>
    	<h4 class="ddtitle">2.上传数据包</h4>
    	<table cellpadding="0" cellspacing="0" class="user-form-table">
				<tr>
					<td><div id="chooseDataFile">上传数据包</div></td>
					<td><div id="dataFileProgress">无数据包</div><input type="hidden" id="dataFilePath"  value="${saveFile }"/></td>
				</tr>
			</table>
		<table cellpadding="0" cellspacing="0" class="user-form-table">
				<tr>
					<td>&nbsp;</td>
					<td><input class="input-button" type="button" value="发布" onclick="save()" id="saveGoods" /></td>
				</tr>
			</table>
</form>
</div>
<script charset="utf-8" src="js/goods.js"></script>
<script>

if (typeof zhigu == "undefined" || !zhigu) {
	var zhigu = {};
}
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
			layer.alert("文件大小不能超过"+(dataFileSizeLimit/1024/1024/5)+"M");
		}
    });
//     setInterval(function(){
//     	zhigu.log("轮询文件上传文件==：",dataUploader.getFiles());
//     	zhigu.log("轮询文件上传状态==：",dataUploader.isInProgress());
//     }, 5000);
// ===============初始化数据包上传  end================
	 
 // ===============图片上传初始化  start================
	 zhigu.goods.defaultImageAmount = 5;
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
            server: '/upload/img/goods/main',
            formData:{specType:1,specs:"285x285,160x160"},
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
        	var imgsize = $(".upimg").size();
        	if(imgsize >= zhigu.goods.defaultImageAmount){
        		layer.alert("上传图片数量已达上限！");
        		return false;
        	}
        	var size = file.size;
        	if(size>1024*1024*0.8){
        		layer.alert("文件大小不能超过800k！");
        		return false;
        	}
        	
        });
 		
        imgUploader.on( 'uploadSuccess', function( file,response ) {
        	if(response.code==zhigu.code.success){
        		zhigu.goods.appendToUpimgul(response.data,response.data);
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
})


var _cindex = 0;
var _sindex = 0;
var _size = 0;
// 批量设置价格或数量
function batchset(obj) {
	$("#divbox :radio").attr("checked", false);
	_cindex = $(obj).attr("cindex");
	_sindex = $(obj).attr("sindex");
	_size = $(obj).attr("size");
	$('#divbox').css("top", $(obj).offset().top + 30);
	$('#divbox').css("left", $(obj).offset().left-60);
	$('#divbox').show();
}
//确认批量设置价格或数量
function confirmbatch() {
	var rprice = $(":radio[name=rprice][checked]").val();
	var rquantity = $(":radio[name=rquantity][checked]").val();

	var v_price = skuArr[_cindex].rele[_sindex].price;
	var v_quantity = skuArr[_cindex].rele[_sindex].amount;
	if (rprice == 1) {//同颜色分类价格相同
		for (var i = 0; i < skuArr[_cindex].rele.length; i++) {
			if (skuArr[_cindex].rele[i].isshow == 1)
				skuArr[_cindex].rele[i].price = v_price;
		}
	}
	if (rprice == 2) {//同尺码价格相同
		for (var i = 0; i < skuArr.length; i++) {
			if (skuArr[i].isshow == 1) {
				for (var j = 0; j < skuArr[i].rele.length; j++) {
					if (skuArr[i].rele[j].isshow == 1 && skuArr[i].rele[j].usename == _size)
						skuArr[i].rele[j].price = v_price;
				}
			}
		}
	}
	if (rquantity == 1) {//同颜色分类数量相同
		for (var i = 0; i < skuArr[_cindex].rele.length; i++) {
			if (skuArr[_cindex].rele[i].isshow == 1)
				skuArr[_cindex].rele[i].amount = v_quantity;
		}
	}
	if (rquantity == 2) {//同尺码数量相同
		for (var i = 0; i < skuArr.length; i++) {
			if (skuArr[i].isshow == 1) {
				for (var j = 0; j < skuArr[i].rele.length; j++) {
					if (skuArr[i].rele[j].isshow == 1 && skuArr[i].rele[j].usename == _size)
						skuArr[i].rele[j].amount = v_quantity;
				}
			}
		}
	}
	zhigu.goods.showArr();
	zhigu.goods.statAmount();
	$('#divbox').hide();
}
// 颜色修改别名
function cchange(index, obj) {
	if (index == 0) {
		skuArr[$(obj).attr("index")].usename = $(obj).val();
	} else if (index == 1) {
		for (var i = 0; i < skuArr.length; i++) {
			skuArr[i].rele[$(obj).attr("index")].usename = $(obj).val();
		}
	}
	zhigu.goods.showArr();
}

//保存商品
function save() {
	
	var submit = true;
	var saveData = {};
	var categoryId = $("#categorySelectDiv select").last().val();
	if (categoryId == '') {
		dialog("请选择商品类别！");
		return;
	}
	//商品名称 
	if ($("#name").val() == null || $("#name").val() == '') {
		dialog("请填商品标题！");
		return;
	}
	saveData.name = $("#name").val();
	
	debugger;

	var propertyStr = "[";
	//属性（select)
	$("#attributes").find("select").each(
			function() {
				var required = $("#property_" + $(this).attr("index")).attr("requ");
				var value = $(this).val();
				if (required == 'true' && value == '') {
					dialog("请选择商品属性！");
					submit = false;
					return false;
				}
				if (value != '')
					propertyStr += "{propertyId:" + $(this).attr('pid') + ",propertyName:'" + $(this).attr('pname') + "',propertyValueId:" + $(this).val() + ",propertyValueName:'"
							+ $(this).find("option:selected").text() + "'},";
			});
	if (!submit){
		return;
	}
	

	//属性（checkbox)
	$("#attributes .checkboxpro[requ=true]").each(function() {
		var size = $(this).find("input:checked").size();
		if (size == 0) {
			dialog("请选择商品属性！");
			submit = false;
			return false;
		}
	});
	if (!submit){
		return;
	}
	
	// 处理可输入属性
	$("#attributes input.only_input").each(
			function(i,n){
				propertyStr += "{propertyId:" + $(this).attr('pid') + ",propertyName:'" + $(this).attr('pname') + "',propertyValueId:" + "-1" + ",propertyValueName:'"
				+ $(this).val() + "'},";
			}
	)
	
	

	$("#attributes input:checked").each(
			function() {
				propertyStr += "{propertyId:" + $(this).attr('pid') + ",propertyName:'" + $(this).attr('pname') + "',propertyValueId:" + $(this).val() + ",propertyValueName:'"
						+ $(this).attr('vname') + "'},";
			});
    
	//SKU
	var skuStr = "["
	var count = 0;
	for (var i = 0; i < skuArr.length; i++) {
		if (skuArr[i].isshow == 1) {
			if(zhigu.goods.skuColumnLabel.length==2){
				for (var j = 0; j < skuArr[i].rele.length; j++) {
					if (skuArr[i].rele[j].isshow == 1) {
						if (skuArr[i].rele[j].price > 0 && skuArr[i].rele[j].amount > 0) {
							propertyStr += "{propertyId:" + skuArr[i].pid + ",propertyName:'" + skuArr[i].pname + "',propertyValueId:" + skuArr[i].vid + ",propertyValueName:'" + skuArr[i].usename
									+ "',sku:1},";
							propertyStr += "{propertyId:" + skuArr[i].rele[j].pid + ",propertyName:'" + skuArr[i].rele[j].pname + "',propertyValueId:" + skuArr[i].rele[j].vid + ",propertyValueName:'"
									+ skuArr[i].rele[j].usename + "',sku:1},";
							skuStr += "{amount:" + skuArr[i].rele[j].amount + ",price:" + skuArr[i].rele[j].price + ",propertyStr:'" + skuArr[i].pid + ":" + skuArr[i].vid + ","
									+ skuArr[i].rele[j].pid + ":" + skuArr[i].rele[j].vid + "',propertyStrName:'"
									+ (skuArr[i].pname + ":" + skuArr[i].usename + "  " + skuArr[i].rele[j].pname + ":" + skuArr[i].rele[j].usename) + "',skupros:[{propertyId:" + skuArr[i].pid
									+ ",propertyName:'" + skuArr[i].pname + "',propertyValueId:" + skuArr[i].vid + ",propertyValueName:'" + skuArr[i].usename + "'},{propertyId:"
									+ skuArr[i].rele[j].pid + ",propertyName:'" + skuArr[i].rele[j].pname + "',propertyValueId:" + skuArr[i].rele[j].vid + ",propertyValueName:'"
									+ skuArr[i].rele[j].usename + "',sku:1}]},";
						} else {
							dialog('请填写完整商品规格中的价格和数量！');
							return false;
						}
						count++;
					}
				}
			}else if(zhigu.goods.skuColumnLabel.length==1){
				if (skuArr[i].price > 0 && skuArr[i].amount > 0) {
					propertyStr += "{propertyId:" + skuArr[i].pid + ",propertyName:'" + skuArr[i].pname + "',propertyValueId:" + skuArr[i].vid + ",propertyValueName:'" + skuArr[i].usename
							+ "',sku:1},";
					skuStr += "{amount:" + skuArr[i].amount + ",price:" + skuArr[i].price + ",propertyStr:'" + skuArr[i].pid + ":" + skuArr[i].vid
							+ "',propertyStrName:'"
							+ (skuArr[i].pname + ":" + skuArr[i].usename) + "',skupros:[{propertyId:" + skuArr[i].pid
							+ ",propertyName:'" + skuArr[i].pname + "',propertyValueId:" + skuArr[i].vid + ",propertyValueName:'" + skuArr[i].usename + "'}]},";
				}else {
					dialog('请填写完整商品规格中的价格和数量！');
					return false;
				}
				count++;
			}
		}
	}
	if (count == 0) {
		dialog("请选择商品规格！");
		return;
	}
	if ($("#weight").val() == null || $("#weight").val() == '') {
		dialog('请填写商品重量！');
		return;
	}
	saveData.weight = $("#weight").val();
	//图片
	var imagesStr = "[";
	if ($(".upimg").size() == 0) {
		dialog("请至少上传一张商品图片！");
		return;
	}
	$(".upimg").each(function(i) {
		imagesStr += "{image:'" + $(this).attr("savesrc") + "',main:" + (i == 0) + "},"
	});

	saveData.file = $("#dataFilePath").val();
	
	// 描述
    var desc = UE.getEditor('editor').getPlainTxt();
	// 过滤外链
	var reg2 = /(http:\/\/|https:\/\/)((\w|=|\?|\.|\/|&|-)+)/g;
    var reg = new RegExp(reg2);
    //saveData.description = desc.replace(reg, "");
    desc = desc.replace(reg, "");
    
    // 过滤a标签
    var $desc = $("<div>"+desc+"</div>");
    if($desc.find("a").length>0){
       $desc.find("a").replaceAll("span");
    }
    
	saveData.description = $desc.html();
	
	//去掉最后多余的逗号
	if (propertyStr.length > 1)
		propertyStr = propertyStr.substring(0, propertyStr.length - 1);
	propertyStr += "]";
	if (skuStr.length > 1)
		skuStr = skuStr.substring(0, skuStr.length - 1);
	skuStr += "]";
	if (imagesStr.length > 1)
		imagesStr = imagesStr.substring(0, imagesStr.length - 1);
	imagesStr += "]";

	saveData.propertyStr = zhigu.objToJson(eval("("+propertyStr+")"));
	saveData.skuStr = zhigu.objToJson(eval("("+skuStr+")"));
	saveData.imagesStr = zhigu.objToJson(eval("("+imagesStr+")"));
	saveData.categoryId = categoryId;
	// 数据包上传状态检查
	if (dataUploader && dataUploader.isInProgress()) {
		dialog("正在上传数据包中，请等数据包上传完成后再保存！");
		return false;
	}
	// 提交保存
	if (submit){
		$("#saveGoods").prop("disabled",true);
		setTimeout(function(){
			$("#saveGoods").prop("disabled",false);
		}, 4000);
		layer.load("商品保存中", 3);
		$.post("/supplier/goods/save", saveData, function(msgBean) {
			layer.msg(msgBean.msg,2, function() {
				if(msgBean.code==zhigu.code.success && msgBean.data){
					window.location.href= "goods/detail?goodsId="+msgBean.data;
				}
			});
		}, "json");
	}
}

var com_img_upload = function() {
	$('#localUpload').show();
	$('#userspace-com-img').hide();
	$('#shangchuan2').removeClass("shangchuanselect");
	$('#shangchuan1').addClass("shangchuanselect");
}
var zTreesetting = {
	callback : {
		onClick : function(event, treeId, treeNode) {
			//$("#curFolderID").val(treeNode.id);
			loadFolderFile();
		},
		onRename : function(event, treeId, treeNode, isCancel) {
			ajaxSubmit("/supplier/space/updateFolderName", {"folderID" : treeNode.id,"folderName" : treeNode.name}, function(msgBean) {
				if(msgBean.code == zhigu.code.success){
					layer.msg(msgBean.msg, 1, f5);
					zTree.editName(treeNode);
				}else{
					layer.alert(msgBean.msg);
				}
			});
		}
	},
	data : {
		keep : {
			parent : true
		},
	},
	view : {
		showLine : false,
		selectedMulti : false
	}
}
function loadFolderFile() {
	if (zTree.getSelectedNodes()[0]) {
		ajaxSubmit("/supplier/space/folderFileMini", {
			"folderID" : zTree.getSelectedNodes()[0].id
		}, function(data) {
			$("#com_shangchuanbox").html(data);
		}, "text");
	} else {
		zgzTreeLoad();
	}
}

var zTree;
function zgzTreeLoad() {
	//加载目录树
	ajaxSubmit("/supplier/space/folderTree", {}, function(data) {
		$("#folderTree1").html("");
		zTree = $.fn.zTree.init($("#folderTree1"), zTreesetting, data);
		var nodes = zTree.getNodes();
		//加载第一个文件夹文件
		zTree.selectNode(nodes[0], false);
		//$("#curFolderID").val(nodes[0].id);
		loadFolderFile();
	}, "json");
}
$(function() {
	//商品图片选择图片空间
	$("#shangchuan2").on("click", function() {
		$('#localUpload').hide();
		$('#shangchuan1').removeClass("shangchuanselect");
		$(this).addClass("shangchuanselect");
		$("#userspace-com-img").show();
		
		zgzTreeLoad();
	});
});
</script>
<div id='divbox' class='hidden'>
	<ul class=''>
		<li>价格：</li>
		<li><input id="rprice_01" name="rprice" value="1" type='radio' class='ver_ali'/><label for="rprice_01">同颜色分类价格相同</label></li>
		<li><input id="rprice_02" name="rprice" value="2" type='radio' class='ver_ali'/><label for="rprice_02">同规格价格相同</label></li>
	</ul>
	<ul class=''>
		<li>数量：</li>
		<li><input id="rquantity_01" name="rquantity" value="1" type='radio' class='ver_ali'/><label for="rquantity_01">同颜色分类数量相同</label></li>
		<li><input id="rquantity_02" name="rquantity" value="2" type='radio' class='ver_ali'/><label for="rquantity_02">同规格数量相同</label></li>
	</ul>
	<div class='mt10'>
	<input type='button' value='确定' onclick="confirmbatch()" class='mini-btn' />
	<input type='button' onclick="javascript:$('#divbox').hide()" value='取消' class='mini-btn'/>
	</div>
</div>
</body>
</html>
