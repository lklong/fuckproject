<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>发布商品</title>
<link href="/js/3rdparty/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" type="text/css" href="/js/3rdparty/webuploader/webuploader.css">
<style>
.piliansezhijia{ border:1px solid #e4e4e4; width:80px; height:20px; line-height: 20px; color:blue;  z-index:100;}
.piliansz{  border:1px solid #e4e4e4; position: absolute; background: #fff;padding: 5px; left:0px; width:170px; top:30px; z-index:111;}

.popBox { background: #FFF; position: absolute; z-index: 999; top: 0px; display: none; }
.popBox .bg1 { background: #FFF; width:350px; height: 210px;}
.popBox h1 { padding: 0px 10px; height: 38px; font: 16px Microsoft YaHei; line-height: 38px; background: #1a7cc7; color: #FFF; }
.popBox h1 span { float: left;  }
.popBox h1 .close { color: #FFF; font-size: 12px; float: right; font-family: Verdana;}
.popBox h1 .close:hover { color: #333; }

.mask { width: 100%; opacity:0.5; filter:alpha(opacity=50); background: #000; position: absolute; left: 0px; top: 0px; z-index: 998; }
.fabubgtian{ background:#333; width:104px; height:20px; color:#fff; position:absolute; bottom:0px; line-height:20px;}
.edit label{display: none;}
.edit .yansetext{display: block;width: 70px !important;}

.webuploader-pick{background-color: #E81268}
</style>
<script type="text/javascript" src="/js/3rdparty/webuploader/webuploader.js"></script>

</head>
<body>
<script type="text/javascript" language="javascript" src="js/3rdparty/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<!-----------------------------------------------center中间部分---------------------------------------------------->
 <form method="post" action="#">
    <div class="body_center2 fl p10 ml10"  id="alldd">
    	<div class="wdddbj over_hid">
            <ul class="allqunbudd over_hid">
               <li><a href="supplier/goods/add" >商品发布</a></li>
                <li><a href="javascript:void(0)" class="sected">编辑商品</a></li>
                <li><a href="supplier/goods/list?status=1">出售中的商品</a></li>
                <li><a href="supplier/goods/list?status=2">下架的商品</a></li>
            </ul>          	
        </div>
        <div class="jibenxinxi ml20 mt10">
           <h4 class="jbxxtitle pl10">1.商品基本信息</h4>
           
           <div class="jibenform">
           	   <div class="title">
                   <strong>*</strong><label for="baobeititle0">商品标题：</label>
               </div>
               <input type="text" value="${goods.name }" class="biaobeititle fl" id="name" onkeyup="zhigu.goods.checkTitleLen(this)"/>
               <span class="baobeititle_1 ml10">还能输入<strong id="titleCount">30</strong>字</span>
               <div class="clear"></div>
           </div>
           
           <div id="attributes_sku">
	           <jsp:include page="include.jsp"></jsp:include>
	       </div>
           <div class="shuxingtable2 mt10" id="scletabletbody">
           </div>
           <div class="jibenform">
           		<div class="title">
                    <p>商品总数：</p>
                    <div class="clear"></div>
               </div>
               <span class="jian fl ml10"><font color="red" size="5" id="sumAmount">0</font>&nbsp;&nbsp;件</span>
               <div class="clear"></div>
           </div>
           <div class="jibenform">
           	   <div class="title">
                   <strong>*</strong><label for="baobeititle0">商品重量：</label>
               </div>
               <input type="text" class="biaobeititle fl" id="weight" value="${goods.weight }" style="width: 100px" onkeyup='zhigu.goods.priceInputCheck(this);' onafterpaste='zhigu.goods.priceInputCheck(this);' maxlength='11'/> 千克 （邮费计算用）
               <div class="clear"></div>
           </div>
           <div class="tupian mt20">
	        	<div class="title">
	                <p>商品图片：</p>
	            </div>
                <div class="tupianright fl">
	               	<div class="tupianheader" id="tupianheader">
	                   	<ul>
	                       	<li class="shangchuanselect" id="shangchuan1" onclick="com_img_upload();">本地上传</li>
	                       	<li  id="shangchuan2">图片空间</li>
	                    </ul>
	                    <div class="clear"></div>
	                </div>
                    <!--本地上传-->
                    <div class="shangchuanbox" id="localUpload">
                    	<div class="xuanzebox mt20">
                            <div id="chooseUploadImg" style="float: left;margin-left: 25px;">选择本地图片</div>
                            <div class="clear"></div>
                        </div>
                        <div class="shangchuantishi mt20">
                            <p>提示：</p>
                            <ol>
                                <li>1.商品主图不能超过<strong>800K</strong>，图片规格必须为<strong>正方形</strong>且大于<strong>430x430</strong>。</li>
                                <li>2.最多可以上传<strong>5</strong>张图片。</li>
                                <li>3.图片<strong>1</strong>必须上传。</li>
                            </ol>
                        </div>
                    </div>
                    <div class="shangchuanbox" style="display:none;" id="userspace-com-img">
                	    <div class="shangchuanleft fl" style="width: 150px;">
							<div class="easyui-panel" style="height: 220px;width:150px;">
								<div class="fl ztree"  id="folderTree1" >
									加载用户文件夹...
								</div>
							</div>
							<div class="clear"></div>
						</div>
						<div id="com_shangchuanbox" class="fl" style="width: 640px;"></div>
                    </div>
                    
                    <div class="shangchuanbottom" style="padding-top: 10px;background-image: url('/img/img_back.png');">
                        <ul id="upimgul">
                        	<li class="prebakimg">
                            	<div class="imgbox" id="imgbox1">
                                     <img src="img/upload-img-bak.jpg" width="102px" height="102px"/>
                                </div>
                                <div class="fabubgtian disnone"><span class="ml5 cp" onclick="zhigu.goods.mleft(this)">左移</span><span class="ml10 cp" onclick="zhigu.goods.mright(this)">右移</span> <span class="ml10">×</span></div>
                            </li>
                            <c:forEach items="${goods.images }" var="img" varStatus="vs">
                            	<li id="0.861172192497178${vs.index }" onmouseover="zhigu.goods.mouseover(this)" onmouseout="zhigu.goods.mouseout(this)">
                            		<div class="imgbox" id="imgbox1">
                            			<img class="upimg" imgId="${img.id }" src="${img.image}" savesrc="${img.image}" savesrc300="${img.image300}" width="102px" height="102px" />
                            		</div>
                            		<div class="fabubgtian disnone">
                            			<span class="ml5 cp" onclick="zhigu.goods.mleft(this)">左移</span>
                            			<span class="ml10 cp" onclick="zhigu.goods.mright(this)">右移</span> 
                            			<span class="ml10 cp" onclick="zhigu.goods.delimg(this)">×</span>
                            		</div>
                            	</li>
                            </c:forEach>
                        </ul>
                        <div class="clear"></div>
                     </div> 
                </div>
                <div class="clear"></div>
         </div>
    <%--        <div class="jibenform">
       	<div class="title">
                 <p>商品详情：</p>
                 <div class="clear"></div>
             </div><br/>
             <textarea id="introduce" name="introduce" style="width:850px;height:360px;">
				${goods.description }
			 </textarea>
             <div class="clear"></div> 
         </div>--%>
             
              <div class="jibenform">
		 		<div class="title" style="clear:both;height:30px;">
					<p>商品详情：</p>
			 	</div>
		 	  </div>
             
          <div class="clear"></div>
          
            <div class="jibenform">
			 	<div class="tupianright fl" style="border:none;margin-left: -20px;">
			 		<jsp:include page="../../../ueditor/index_desc.jsp">
			 			<jsp:param name="desc" value="${goods.description }" />
			 		</jsp:include>
			 	</div>
		 	  </div>
             
          <div class="clear"></div>
         <h4 class="jbxxtitle pl10">2.上传数据包</h4>
         <div class="jibenform">
             <div id="chooseDataFile" style="float: left;margin-left: 25px;">上传数据包</div>
             <div id="dataFileProgress" style="margin:10px 20px ; float: left"><c:if test="${empty goods.file }">无数据包</c:if><c:if test="${!empty goods.file }"><a href="${goods.file }" target="_blank">原数据包：下载</a></c:if></div>
             <input type="hidden" id="dataFilePath" value="${goods.file }"/>
             <div class="clear"></div>
         </div>
         </div>
         <div class="tc fabusubdiv mt20 mb20 "><input class="fabusub f14 fwbold  cp" type="button" value="保存" onclick="save()" id="saveGoods"/></div>
   </div>
</form>
<div class="clear"></div>

<!-- <script charset="utf-8" src="js/3rdparty/kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="js/3rdparty/kindeditor/lang/zh_CN.js"></script> -->
<script charset="utf-8" src="js/goods.js"></script>
<script>
if (typeof zhigu == "undefined" || !zhigu) {
	var zhigu = {};
}

$(function() {
	zhigu.goods.editLoadGoods("${goods.id}");
	$(".prebakimg").hide();
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
		$dataFileProgress.html("<span id='"+file.id+"'>"+file.name+" --> <span class='progress'></span></span>");
    });
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
        imgSizeLimit = 1024*800,
        imgUploader = WebUploader.create({
            auto: true,
            // swf文件路径
            swf:  '/js/3rdparty/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: '/upload/img/goods/main',
            formData:{ftype:1,specs:"285x285,160x160"},
            // 选择文件的按钮。可选。
            pick: '#chooseUploadImg',
            fileSingleSizeLimit:imgSizeLimit,
            // 只允许选择文件，可选。
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            }
        });
 		//  加入上传队列前check
        imgUploader.on( 'beforeFileQueued', function( file ) {
        	var imgsize = $(".upimg").size();
        	if(imgsize >= zhigu.goods.defaultImageAmount){
        		dialog("上传图片数量已达上限！");
        		return false;
        	}
        	var size = file.size;
        	alert(size);
        	if(size>1024*1024*0.8){
        		dialog("文件大小不能超过800k！");
        		return false;
        	}
        });
        imgUploader.on( 'uploadSuccess', function( file,response ) {
        	if(response.code==zhigu.code.success){
        		zhigu.goods.appendToUpimgul(response.data,response.data);
        	}else{
        		dialog(response.msg);
        		// 上传失败标记为移除，否则不能重新选择该文件上传
            	imgUploader.removeFile(file);
        	}
        });
        imgUploader.on( 'uploadError', function( file ) {
        	dialog('上传失败：'+file.name);
        	// 上传失败标记为移除，否则不能重新选择该文件上传
        	imgUploader.removeFile(file);
        });
        imgUploader.on('error', function(handler) {
    		if(handler=="F_EXCEED_SIZE"){
    			dialog("文件大小不能超过"+(imgSizeLimit/1024)+"k");
    		}
        });
 // ===============图片上传初始化  end================
})

//attr 1 颜色 2 大小
//value 对应的值
//op操作 0取消 1添加
function setArrIsShow(attr, value, op) {
	for (var i = 0; i < colorArr.length; i++) {
		if (attr == 1) {
			if (value == colorArr[i].color) {
				colorArr[i].isshow = op;
			}
		} else {
			for (var j = 0; j < colorArr[i].sizeArr.length; j++) {
				if (value == colorArr[i].sizeArr[j].size) {
					colorArr[i].sizeArr[j].isshow = op;
				}
			}
		}
	}
}

var _cindex = 0;
var _sindex = 0;
var _size = 0;
// 批量设置价格或数量
function batchset(obj) {
	$("#divbox :radio").attr("checked", false);
	_cindex = $(obj).attr("cindex");
	_sindex = $(obj).attr("sindex");
	_size = $(obj).attr("size");
	$('#divbox').show();
	$('#divbox').css("top", $(obj).offset().top + 20);
	$('#divbox').css("left", $(obj).offset().left-60);
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
	var categoryId = "${goods.categoryId}";
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
	if (!submit)
		return;

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
		imagesStr += "{image:'" + $(this).attr("savesrc") + "',main:" + (i == 0) +",image300:'"+$(this).attr("savesrc300")+ "'},"
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
	saveData.id = "${goods.id}";
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
		$.post("/supplier/goods/update", saveData, function(msgBean) {
			layer.msg(msgBean.msg,1, function() {
				if(msgBean.code==zhigu.code.success && msgBean.data){
					window.location.href= "goods/detail?goodsId="+msgBean.data;
				}
			});
		}, "json");
	}
}


//图片空间
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
function uploadToUserspace() {
	var id = 0;
	if (zTree.getSelectedNodes()[0]) {
		id = zTree.getSelectedNodes()[0].id;
	}
	popUpfileToSpace(1, id, function(data) {
		if (data.flag == 0) {
			loadFolderFile();
		} else {
			dialog(data.msg);
		}
	});
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
<div id='divbox' class='piliansz tl disnone'>
	<ul class=''>
		<li>价格：</li>
		<li><input name="rprice" value="1" type='radio' class='ver_ali mr5'/>同颜色分类价格相同</li>
		<li><input name="rprice" value="2" type='radio' class='ver_ali mr5'/>同规格价格相同</li>
	</ul>
	<ul class=''>
		<li>数量：</li>
		<li><input name="rquantity" value="1" type='radio' class='ver_ali mr5'/>同颜色分类数量相同</li>
		<li><input name="rquantity" value="2" type='radio' class='ver_ali mr5'/>同规格数量相同</li>
	</ul>
	<div class='clear'></div>
	<div class='mt10'><input type='button' value='确定' onclick="confirmbatch()" class='w80' /><input   type='button' onclick="$('#divbox').hide()" value='取消' class='ml10 w80'/></div>
</div>
</body>
</html>
