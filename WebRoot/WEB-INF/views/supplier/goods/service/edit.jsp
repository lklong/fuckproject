<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>发布商品</title>
<link rel="stylesheet" type="text/css" href="/js/3rdparty/webuploader/webuploader.css">
<script type="text/javascript" src="/js/3rdparty/webuploader/webuploader.js"></script>
<link href="/js/3rdparty/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="/js/3rdparty/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<style>
.piliansezhijia{ border:1px solid #e4e4e4; width:80px; height:20px; line-height: 20px; color:blue;  z-index:100;}
.piliansz{  border:1px solid #e4e4e4; position: absolute; background: #fff;padding: 5px; left:0px; width:170px; top:30px; z-index:111;}
	   
.fabubgtian{ background:#333; width:104px; height:20px; color:#fff; position:absolute; bottom:0px; line-height:20px;}
.edit label{display: none;}
.edit .yansetext{display: block;width: 70px !important;}

.webuploader-pick {
    background-color:#E81268;
}
</style>
</head>
<body>
	<!-----------------------------------------------center中间部分---------------------------------------------------->
 <form method="post" id="serviceForm" action="#">
    <div class="body_center2 fl p10 ml10"  id="alldd">
    	<div class="wdddbj over_hid">
            <ul class="allqunbudd over_hid">
                <li><a href="supplier/goods/add" >商品发布</a></li>
                <li><a href="javascript:void(0)" class="sected">编辑商品</a></li>
                <li><a href="supplier/goods/list?status=1">出售中的商品</a></li>
                <li><a href="supplier/goods/list?status=2">下架的商品</a></li>
            </ul>          	
        </div>
        <div class="jibenxinxi ml20">
           <div class="jibenform">
           	   <div class="title">
                   <strong>*</strong><label for="baobeititle0">商品标题：</label>
               </div>
               <input type="text"  class="biaobeititle fl" id="name" value="${goods.name }" onkeyup="zhigu.goods.checkTitleLen(this)" onafterpaste="zhigu.goods.checkTitleLen(this)"/>
               <span class="baobeititle_1 ml10">还能输入<strong id="titleCount">30</strong>字</span>
               <div class="clear"></div>
           </div>
           <!-- 属性 -->
           <jsp:include page="property.jsp"></jsp:include>
           
           <div class="jibenform">
           		<div class="title">
                    <strong>*</strong><p>价格：</p>
                    <div class="clear"></div>
               </div>
               <span class="jian fl"><input type="text" id="goodsPrice" value="${goods.minPrice }" class="biaobeititle fl" style="width: 100px" onkeyup='zhigu.goods.priceInputCheck(this);' onafterpaste='zhigu.goods.priceInputCheck(this);' /></span>
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
                                <li>1.本地上传图片大小不能超过<strong>800K</strong>，图片规格必须大于<strong>430x430</strong>。</li>
                                <li>2.最多可以上传<strong>1</strong>张图片。</li>
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
                    
                    <div class="shangchuanbottom">
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
                            			<img class="upimg" imgId="${img.id }" src="${img.image}" savesrc="${img.image}" width="102px" height="102px" />
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
        <%--  <div class="jibenform">
         	<div class="title">
                 <p>商品描述：</p>
                 <div class="clear"></div>
             </div>
             <textarea id="introduce" name="introduce" style="width:850px;height:360px;">${goods.description }</textarea>
             <div class="clear"></div>
         </div> --%>
           <div class="jibenform">
		 		<div class="title" style="clear:both;height:30px;">
					<p>商品描述：</p>
			 	</div>
			 	<div class="tupianright fl" style="border:none;">
			 		<jsp:include page="../../../ueditor/index.jsp">
			 			<jsp:param name="desc" value="${goods.description }" />
			 		</jsp:include>
			 	</div>
		 	  </div>
		 	  
          <div class="clear"></div>
         </div>
         <div class="tc fabusubdiv mt20 mb20 "><input class="fabusub f14 fwbold  cp" type="button" value="发布" onclick="save()" id="saveGoods"/></div>
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
	// ===============图片上传初始化  start================
	zhigu.goods.defaultImageAmount = 1;
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
        //imgUploader.addButton({id:'#chooseUploadImgToSpace'});
 		//  加入上传队列前check
        imgUploader.on( 'beforeFileQueued', function( file ) {
        	var imgsize = $(".upimg").size();
        	if(imgsize >= zhigu.goods.defaultImageAmount){
        		dialog("上传图片数量已达上限！");
        		return false;
        	}
        	var size = file.size;
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

var com_img_upload = function() {
	$('#localUpload').show();
	$('#userspace-com-img').hide();
	$('#shangchuan2').removeClass("shangchuanselect");
	$('#shangchuan1').addClass("shangchuanselect");
}
var colorArr = [];
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
$(document).ready(function() {
	//商品图片选择图片空间
	$("#shangchuan2").on("click", function() {
		$('#localUpload').hide();
		$('#shangchuan1').removeClass("shangchuanselect");
		$(this).addClass("shangchuanselect");
		$("#userspace-com-img").show();
		zgzTreeLoad();
	});
	$(".prebakimg").hide();
});

function save() {
	var saveData = {};
	//名称
	var name = $("#name").val();
	if (name == null || name == '') {
		dialog('请填写必填项');
		return;
	}
	//属性（select)
	var submit = true;
	var propertyStr = "[";
	$(".servicePropertity").find("select").each(
			function() {
				var required = $("#property_" + $(this).attr("index")).attr("requ");
				var value = $(this).val();
				if (required == 'true' && value == '') {
					dialog("请填写必填项");
					submit = false;
					return false;
				}
				if (value != ''){
					propertyStr += "{propertyId:" + $(this).attr('pid') + ",propertyName:'" + $(this).attr('pname') + "',propertyValueId:" + $(this).val() + ",propertyValueName:'"
							+ $(this).find("option:selected").text() + "'},";
				}
			});
	if (!submit)
		return;

	//商品价格
	var goodsPrice = $("#goodsPrice").val();
	if (goodsPrice == "") {
		dialog("请填写必填项");
		return;
	}

	//图片
	var imagesStr = "[";
	if ($(".upimg").size() == 0) {
		dialog("请至少上传一张商品图片");
		return;
	}
	$(".upimg").each(function(i) {
		imagesStr += "{id:" + $(this).attr("imgId") + ",image:'" + $(this).attr("savesrc") + "',main:" + (i == 0) + "},"
	});

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
	
	//去掉最后的','
	if (propertyStr.length > 1)
		propertyStr = propertyStr.substring(0, propertyStr.length - 1);
	propertyStr += "]";
	//图片
	if (imagesStr.length > 1)
		imagesStr = imagesStr.substring(0, imagesStr.length - 1);
	imagesStr += "]";

	saveData.name = name;
	saveData.minPrice = goodsPrice;
	saveData.maxPrice = goodsPrice;
	saveData.skuStr = '[{"amount":-1,price:' + goodsPrice + '}]';
	saveData.propertyStr = zhigu.objToJson(eval("("+propertyStr+")"));
	saveData.imagesStr = zhigu.objToJson(eval("("+imagesStr+")"));
	saveData.categoryId = "${goods.categoryId}";
	saveData.id = "${goods.id}";

	if (submit){
		$("#saveGoods").prop("disabled",true);
		setTimeout(function(){
			$("#saveGoods").prop("disabled",false);
		}, 4000);
		layer.load("商品保存中", 3);
		$.post("supplier/goods/update", saveData, function(msgBean) {
			layer.msg(msgBean.msg, function() {
				if(msgBean.code==zhigu.code.success && msgBean.data){
					window.location.href= "goods/detail?goodsId="+msgBean.data;
				}
			});
		}, "json");
	}
}

</script>
</body>
</html>
