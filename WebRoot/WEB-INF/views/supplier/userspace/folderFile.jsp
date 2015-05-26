<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="ml30 mt20  c666 over_hid f14">
	<span class="fl ml10"> <input class="ver_ali mt2" type="checkbox" onclick="zgselectAll(this);" id="selectAll"/></span><label class="fl ml5" for="selectAll">全选</label> <a href="javascript:void(0);" onclick="batchDeleteFile();"><span class="ml10 fl"> 批量删除 </span></a>
</div>
<div class="fl" style="width: 850px;height: 300px;" id="fileUL">
	<ul class="tupiankj ml10 f14">
		<c:forEach items="${page.datas }" var="userFile">
			<li>
				<div>
					<a href="${userFile.filePath}" target="_blank"><img src="${userFile.image100}" height="100" width="100"/></a>
				</div>
				<div class="over_hid mt5">
					<span class="fl ml10"><input class="ver_ali mt2" type="checkbox" value="${userFile.fileID}"/></span><a href="javascript:void(0);" onclick="deleteFile(${userFile.fileID})"><span class="ml10 fl"> 删除 </span></a>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>
<div class="ddpage fr mr20">
	<jsp:include page="../../include/page.jsp">
		<jsp:param name="request" value="ajax"/>
		<jsp:param name="requestForm" value="folderFileForm"/>
	</jsp:include>
</div>
<script type="text/javascript">
zhigu.pageAjaxSuccess = function(data){
	$("#loadFolderFile").html(data);
}
function deleteFile(fileID){
	confirmDialog("确认删除此文件？",function(){
		ajaxSubmit("/supplier/space/deleteUserFile",{"fileID":fileID},function(data){
			dialog(data.msg,function(){
				if(data.error==0)loadFolderFile();
			})
		},"json");
	});
}
function batchDeleteFile(){
	var fileID = [];
	$("#fileUL input[type='checkbox']:checked").each(function(){
		fileID.push($(this).val());
	});
	if(fileID.length==0){
		dialog("请选择文件！");
		return;
	}
	confirmDialog("确认删除此文件？",function(){
		ajaxSubmit("/supplier/space/deleteUserFile",{"fileID":fileID},function(data){
			dialog(data.msg,function(){
				if(data.error==0)loadFolderFile();
			})
		},"json");
	});
}
//checkbox全选
function zgselectAll(obj){
	if($(obj).is(":checked")){
		$("#fileUL input:checkbox").attr("checked", true); 
	}else{
		$("#fileUL input:checkbox").attr("checked", false); 
	}
}
</script>
