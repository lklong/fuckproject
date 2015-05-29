<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html >
<head>
<base href="${applicationScope.basePath}" />

<title>店铺公告</title>
</head>

<body>
	<div class="rightContainer">
		<!--// 标题 //-->
		<h3 class="rc_title">
			店铺公告<a href="user/home">我的主页</a>
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<!--// tab切换条 //-->
			<div id="userCommTab" class="userCommTab">
				<ul>
					<li><a href="javascript:void(0);" class="uctSelected">店铺公告</a></li>
				</ul>
			</div>
			<div id="userContents" class="userContents">
				<!--// 内容1 //-->
				<div class="body_center2" id="alldd">
					<ul class=" mt30 ml30 c666 f14 dpallzl">
						<li>店铺公告：</li>
						<li style="font-size: 12px;font-family: 黑体; ">
							提示：
							<ul>
								<li>1.店铺公告可设置为活动公告内容;</li>
								<li>2.上传图片最宽不得超过<strong style="color: red;">1188px</strong>;</li>
							</ul>
						</li>
						<li style="margin-left: -30px;">
							<div class="jibenform" >
							 	<div class="tupianright fl" style="border:none;">
								 	<jsp:include page="../../ueditor/index_desc.jsp"></jsp:include>
								 </div>
							</div>
						 	<div class="clear"></div>
						 	<input type="hidden" value="${storeID }" id="storeID"/>
				 		</li>
					 	<li class="baochun"><a onclick="add();">保存</a></li>
					</ul>
				</div>
			</div>
			<br style="clear: both;" />
		</div>
	</div>
	<div class="clear"></div>
<script type="text/javascript">
function  add(){
  	var content = UE.getEditor('editor').getPlainTxt();
  	 var storeID = $("#storeID").val();
        $.post("/supplier/storeNotice/addStoreNotice",{storeID:storeID,content:content},function(msgBean){
 		if(msgBean.code ==zhigu.code.success){
 			 alert("发布成功!");
			 setTimeout("changePage()", 100);
 		}else{
	    	alert(msgBean.msg);
		}
  }); 
} 
function changePage(){
	parent.layer.closeAll();
	window.location = "/supplier/storeNotice/storeNoticeList";	
}
</script>
</body>
</html>
