<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html >
<head>
<title>店铺公告</title>
<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
</head>

<body>
	<div class="rightContainer fr">
		<h4 class="ddtitle">
			店铺公告
		</h4>
		<table cellpadding="0" cellspacing="0" class="user-form-table">
			<tr>
				<td>
					<div class="msg-alert">
						<p>温馨提示：</p>
						<p>1.店铺公告可设置为活动公告内容;</p>
						<p>2.上传图片最宽不得超过<strong class="color-red">1188px</strong>;</p>
					</div>
				</td>
			</tr>
			<tr>
				<td><jsp:include page="../../ueditor/index_desc.jsp"></jsp:include></td>
			</tr>
			<tr>
				<td>
				<input type="hidden" value="${storeID }" id="storeID"/>
				<input type="button" class="input-button" onclick="add();" value="保存" />
				</td>
			</tr>
		</table>
</div>
<script type="text/javascript">
function  add(){
  	var content = UE.getEditor('editor').getPlainTxt();
  	if($.trim(content) == ''){
  		layer.alert('不能发布空的内容!');
  		return;
  	}
  	 var storeID = $("#storeID").val();
        $.post("/supplier/storeNotice/addStoreNotice",{storeID:storeID,content:content},function(msgBean){
 		if(msgBean.code ==zhigu.code.success){
 			layer.alert("发布成功!");
			 setTimeout("changePage()", 100);
 		}else{
 			layer.alert(msgBean.msg);
		}
  }); 
} 
function changePage(){
	window.location = "/supplier/storeNotice/storeNoticeList";	
}
</script>
</body>
</html>
