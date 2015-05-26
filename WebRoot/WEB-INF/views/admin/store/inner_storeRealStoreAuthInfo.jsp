<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
	$(function (){
		if("${realStoreAuth.approveState!=null&&(realStoreAuth.approveState==1||realStoreAuth.approveState==2)}"=="true"){
			$("#alldd input").attr("disabled","disabled");
			$("#alldd select").attr("disabled","disabled");
		}
	});
	function callbackImagePre1(json){
		console.log(json);
		$("#preImage1").attr("src","/"+json.url);
		$("#image1").val(json.url);
	}
	function callbackImagePre2(json){
		$("#preImage2").attr("src","/"+json.url);
		$("#image2").val(json.url);
	}
	function callbackImagePre3(json){
		$("#preImage3").attr("src","/"+json.url);
		$("#image3").val(json.url);
	}
</script>
<div style="height:20px;"></div>
<c:if test="${realStoreAuth.approveState == 2}">
<div > 审核未通过 </div>
<div > 未通过原因： ${realStoreAuth.rejectReason }</div>
</c:if>
<form action="admin/store/seveRealStoreAuth" id="realStoreAuthForm" method="post">
	<input name="storeID"  type="hidden" value="${storeID }"/>
	<table cellpadding="4" cellspacing="4" style="width:600px;margin:0 10px; ">
		<tr><td>实体名称：</td><td><input class="dpname fl" placeholder="20个字符内" id="realStoreName" name="realStoreName" value="${realStoreAuth.realStoreName }" maxlength="20"/><label class="msg_realStoreName">${msg_realStoreName}</label></td></tr>
		<tr><td>经营人：</td><td><input class="dpname fl" id="master" placeholder="8个字符内" name="master" value="${realStoreAuth.master }" maxlength="8"/><label class="msg_master"  style="color:red;">${msg_master}</label></td></tr>
		<tr><td>联系电话：</td><td><input class="dpname fl" id="phone" placeholder="格式：区号-座机号" name="phone" value="${realStoreAuth.phone }"/><label class="msg_phone" style="color:red;">${msg_phone}</label></td></tr>
		<tr><td>实体地址：</td><td><input class="dpname fl" id="realStoreAddress" placeholder="40个字符内" name="realStoreAddress" value="${realStoreAuth.realStoreAddress }" maxlength="40"/><label class="msg_realStoreAddress"style="color:red;">${msg_realStoreAddress}</label></td></tr>
		<tr><td><input type="submit" id="sub" style="display:none"/>
						<input type="hidden" name="image1" id="image1" value="${realStoreAuth.image1}"/>
						<input type="hidden" name="image2" id="image2"  value="${realStoreAuth.image2}"/>
						<input type="hidden" name="image3" id="image3"  value="${realStoreAuth.image3}"/></td></tr>
	</table>
</form>

<table cellpadding="4" cellspacing="4" style="width:600px;margin:0 10px; ">
	<tr><td>实体图1：</td>
		<td>
			<form enctype="multipart/form-data" action="/upload/uploadImageFile" method="post" id="uploadImageFileForm1"  target="imgUpload_hidden_frame">
				<img id="preImage1" src="${realStoreAuth.image1}"  width="160px" height="160px"/><label class="msg_image1" style="color:red;">${msg_image1}</label>
				<div  class="file-box">上传实体图1 <input type="file"  name="preImageFile"  id="preImageFile1" onchange="uploadImageFileForm1.submit();" /></div>
				<input name="callBackFun" type="hidden" value="callbackImagePre1"/>
			</form>
		</td>
	</tr>
	<tr><td>实体图2：</td>
		<td>
			<form enctype="multipart/form-data" action="/upload/uploadImageFile" method="post" id="uploadImageFileForm2"  target="imgUpload_hidden_frame">
				<img id="preImage2" src="${realStoreAuth.image2}"  width="160px" height="160px"/><label class="msg_image2" style="color:red;">${msg_image2}</label>
				<div  class="file-box">上传实体图2 <input type="file"  name="preImageFile"  id="preImageFile2" onchange="uploadImageFileForm2.submit();" /></div>
				<input name="callBackFun" type="hidden" value="callbackImagePre2"/>
			</form>
		</td>
	</tr>
	<tr><td>实体图3：</td>
		<td>
			<form enctype="multipart/form-data" action="/upload/uploadImageFile" method="post" id="uploadImageFileForm3"  target="imgUpload_hidden_frame">
				<img id="preImage3" src="${realStoreAuth.image3}"  width="160px" height="160px"/><label class="msg_image3" style="color:red;">${msg_image3}</label>
				<div  class="file-box">上传实体图3 <input type="file"  name="preImageFile"  id="preImageFile3" onchange="uploadImageFileForm3.submit();" /></div>
				<input name="callBackFun" type="hidden" value="callbackImagePre3"/>
			</form>
		</td>
	</tr>
</table>
<div style="height:60px;background-color:#f0f0f0;padding-top:20px;">
	<div style="margin:0 auto; width:180px;">
		 	<a onclick="saveRealStoreAuth()" href="javascript:void(0)" class="sysButonA3"><em></em>&nbsp;&nbsp;&nbsp;保存实体认证信息&nbsp;&nbsp;&nbsp;</a>
	</div>
</div>

<div class="clear"></div>
	<iframe name="imgUpload_hidden_frame" id="imgUpload_hidden_frame" style="display: none"></iframe>

	









