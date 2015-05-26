<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript" src="js/jQuery-jcDate.js"></script>
<script type="text/javascript">
	$(function (){
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
		// 图片上传预览
		$("#uploadBusinessImage").click(function(){
			$("#preImageFile").click();
			$("#callBackFun").val("callbackImagePre");
		});
		
		if("${companyAuth.regProvince}"==""){
			new PCAS("regProvince", "regCity", "regDistrict",
					"四川省", "成都市","");
		}else{
			new PCAS("regProvince", "regCity", "regDistrict",
					"${companyAuth.regProvince}", "${companyAuth.regCity}",
					"${companyAuth.regDistrict}");
		}
		if("${companyAuth.companyProvince}"==""){
			new PCAS("companyProvince", "companyCity", "companyDistrict",
						"四川省", "成都市","");
		}else{
			new PCAS("companyProvince", "companyCity", "companyDistrict",
					"${companyAuth.companyProvince}", "${companyAuth.companyCity}",
					"${companyAuth.companyDistrict}");
		}
	});
	function callbackImagePre(json){
		$("#preImage").attr("src","/"+json.url);
		$("#image").val(json.url);
	}
</script>
<style type="text/css">
.textprompt{
	width:140px;
	text-align: center;
}
.dpname{
	width:395px;
	height: 25px;
	line-height: 40px;
}
.dpnameq{
	width: 200px;
	height: 25px;
	line-height: 40px;
}
.red{
	color: red;
}

</style>
<div style="height:20px;"></div>
<c:if test="${companyAuth.approveState == 2}">
<div style="color:red;"> 审核未通过 </div>
<div > 未通过原因：${companyAuth.rejectReason } </div>
</c:if>

<form action="admin/store/saveCompanyAuth" id="companyAuthForm" method="post"> 
		<input name="storeID"  type="hidden" value="${storeID }"/>
		<input name="image" id="image"  type="hidden" value="${companyAuth.image }"/>
		<table cellpadding="4" cellspacing="4" style="width:600px;margin:0 10px; ">
			<tr>
				<td class="textprompt">企业名称：</td>
				<td><input class="dpnameq fl" name="companyName" id="companyName" value="${companyAuth.companyName }"/><span class="msg_companyName" style="color: red;"></span></td>
			</tr>
			<tr>
				<td class="textprompt">企业类型：</td>
				<td>
					<select class="dpnameq fl" name="companyType" id="companyType">
							<c:set var="ct" value="<%=com.zhigu.common.constant.enumconst.CompanyType.values()%>"></c:set>
							<c:forEach var="t" items="${ct }">
								<option value="${t.value}" <c:if test="${t.value==companyAuth.companyType}">selected="selected"</c:if>>${t.name}</option>
							</c:forEach>
						</select><span class="msg_companyType" style="color: red;"></span>
				</td>
			</tr>
			<tr>
				<td class="textprompt">工商注册号：</td>
				<td><input class="dpnameq fl" name="regNumber" id="regNumber" value="${companyAuth.regNumber }"/><span class="msg_regNumber" style="color: red;"></span></td>
			</tr>
			<tr>
				<td class="textprompt">企业法人<br/>（个体工商户业主）：</td>
				<td><input class="dpnameq fl" name="corporation" id="corporation" value="${companyAuth.corporation}"/><span class="msg_corporation" style="color: red;"></span></td>
			</tr>
			<tr>
				<td class="textprompt">营业期限：</td>
				<td>
						<input class="jcDate jcDateIco dpnameq fl "  name="businessTerm" id="businessTerm" readonly="readonly"  value="<fmt:formatDate value="${companyAuth.businessTerm }" pattern="yyyy-MM-dd" />" <c:if test="${companyAuth.perpetual==1 }">style="display:none"</c:if>/>
						<input type="checkbox" name="perpetual" id="perpetual" onclick="hideBusinessTerm();" value="1" <c:if test="${companyAuth.perpetual==1 }">checked="checked"</c:if>/><label for="perpetual">长期</label><span class="msg_businessTerm" style="color: red;"></span>
				</td>
			</tr>
			<tr>
				<td class="textprompt">注册资金：</td>
				<td><input class="dpnameq fl" name="capital" id="capital" value="${companyAuth.capital }" onkeyup="inputReplace(this,/\D/g,9);"></input>万元<span class="msg_capital" style="color: red;"></span></td>
			</tr>
			<tr>
				<td class="textprompt">营业范围：</td>
				<td><textarea class="dpname fl" name="businessScope" id="businessScope"  rows="6" cols="10" style="height: 50px;">${companyAuth.businessScope }</textarea><span class="msg_businessScope" style="color: red;"></span></td>
			</tr>
			<tr>
				<td class="textprompt">注册地址：</td>
				<td>
					<select name="regProvince" id="regProvince" style="width: 130px;" class="dpname"></select>
					<select name="regCity" id="regCity" style="width: 130px;" class="dpname"></select>
					<select name="regDistrict" id="regDistrict"  style="width: 130px;" class="dpname"></select>
					<input name="regStreet" id="regStreet"  value="${companyAuth.regStreet }"  class="dpname" />
					<label class="msg_regAddress" style="color: red;"></label>
				</td>
			</tr>
			<tr>
				<td class="textprompt">经营地址：</td>
				<td>
					<select name="companyProvince" id="companyProvince" style="width: 130px;" class="dpname"></select>
					<select name="companyCity" id="companyCity" style="width: 130px;" class="dpname"></select>
					<select name="companyDistrict" id="companyDistrict" style="width: 130px;" class="dpname"></select>
					<input name="companyStreet" id="companyStreet" value="${companyAuth.companyStreet }" class="dpname" />
					<span class="msg_companyAddress" style="color: red;"> </span>
				</td>
			</tr>
			<tr>
			<td class="textprompt">&nbsp;</td>
				<td><p class="red"> 扫描件或数码件，图片必须清晰。格式：jpg、gif、bmp、png</p></td>
			</tr>
			<tr>
				<td class="textprompt">营业执照：</td>
				<td><img id="preImage" width="160px" height="160px" src="${companyAuth.image }"/><label class="msg_image" style="color:red;"></label></td>
			</tr>
			</table>
		</form>
		<table>
			<tr>
				<td class="textprompt">&nbsp;</td>
				<td>
					<form enctype="multipart/form-data" action="/upload/uploadImageFile" method="post" id="uploadImageFileForm"  target="imgUpload_hidden_frame">
						<div  class="file-box" style="height: 20px;">上传营业执照图 <input type="file"  name="preImageFile"  id="preImageFile" onchange="uploadImageFileForm.submit();" /></div>
						<input name="callBackFun"  id="callBackFun" type="hidden" value="callbackImagePre"/>
					</form>
				</td>
			</tr>
		</table>

<div style="height:60px;background-color:#f0f0f0;padding-top:20px;">
	<div style="margin:0 auto; width:210px;">
	 	<a onclick="saveCompanyAuth()" href="javascript:void(0)" class="sysButonA3"><em></em>&nbsp;&nbsp;&nbsp;保存企业认证信息&nbsp;&nbsp;&nbsp;</a>
	</div>
</div>
<div class="clear"></div>
	<iframe name="imgUpload_hidden_frame" id="imgUpload_hidden_frame" style="display: none"></iframe>
	
	


	
	
	
	