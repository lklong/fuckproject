<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<body>
<table id="addForm" cellpadding="0" cellspacing="0" class="user-form-table">
				<tr>
					<td>&nbsp;</td>
					<td><label class="color-red" id="error"></label></td>
				</tr>
				<tr>
					<td><span color="color-red"> * </span>收货人姓名：</td>
					<td>
						<input name="ID" value="${address.ID }" type="hidden" id="addressId">
      					<input class="tjtext1 fl" name="name" value="${address.name }" type="text" />
      					<span class="errorMsg color-red"></span>
					</td>
				</tr>
				<tr>
					<td><span color="color-red"> * </span>手机号码： </td>
					<td>
						<input class="tjtext1 fl" name="phone" value="${address.phone }" type="text" />
						<span class="errorMsg color-red"></span>
					</td>
				</tr>
				<tr>
					<td><span color="color-red"> * </span>所在地区：</td>
					<td>
						<select name="province" id="province"></select>
					    <select name="city" id="city"></select>
					    <select name="district" id="district"></select>
					    <span class="errorMsg color-red"></span>
					</td>
				</tr>
				<tr>
					<td><span color="color-red"> * </span>街道地址：</td>
					<td>
						<input class="tjtext2 fl" name="street" value="${address.street }" type="text" />
      					<span class="errorMsg color-red"></span>
					</td>
				</tr>
				<tr>
					<td>邮政编码： </td>
					<td>
						<input class="tjtext1 fl" name="postcode" value="${address.postcode }" type="text" />
	      				<span class="errorMsg color-red"></span>
      				</td>
				</tr>
				<tr>
					<td>电话号码：</td>
					<td>
					<input class="tjtext2 fl" type="text" name="tel" value="${address.tel }" />
					<span class="errorMsg color-red"></span>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
					<input id="tjcheck1" name="isDefault"  <c:if test="${address.isDefault == 1 }">checked="checked"</c:if> value="1" type="checkbox" />
					<label for="tjcheck1" >设置为默认地址</label>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><input class="input-button" type="button"  onclick="submitAddr();" value="保存"/>
				</tr>
</table>
<script type="text/javascript">
		$(function() {
			var pro = "${address.province}";
			var city = "${address.city}";
			if(pro == "")
				pro = "四川省";
			if(city == "")
				city = "成都市";
			new PCAS("province","city","district",pro,city,"${address.district}");
		});
var submitAddr = function(){
	var url = "";
	//var params = zhigu.cmn.formToObj("#addForm");
	var params = {};
	if($("#addressId").val()){
		params.ID = $("#addressId").val();
		url = "user/address/modify";
	}else{
		url = "user/address/add";
	}
	$(".errorMsg").html("");
	// 数据验证
	var checkFlg = true;
	params.name = $("#addForm input[name='name']").val();
	if(!(params.name && params.name.length<=32)){
 		//$("#addForm input[name='name']").errorMsg("请填写正确的用户名");
		$("#addForm input[name='name']").next(".errorMsg").html("请填写正确的用户名");
		checkFlg = false;
	}
	params.phone = $("#addForm input[name='phone']").val();
	if(!(params.phone && zhigu.verify.phoneReg(params.phone))){
		$("#addForm input[name='phone']").next(".errorMsg").html("请填写正确的手机号");
		checkFlg = false;
	}
	params.province = $("#province").val();
	params.city = $("select[name='city']").val();
	params.district = $("#district").val();
	if(!params.district){
		$("#district").next(".errorMsg").html("请选择地区");
		checkFlg = false;
	}
	params.street = $("#addForm input[name='street']").val();
	if(!(params.street && params.street.length<126)){
		$("#addForm input[name='street']").next(".errorMsg").html("请填写街道地址");
		checkFlg = false;
	}
	params.postcode = $("#addForm input[name='postcode']").val();
	params.tel = $("#addForm input[name='tel']").val();
	params.postcode = $("#addForm input[name='postcode']").val();
	params.isDefault = $("#addForm input[name='isDefault']").prop("checked")?1:0;
	if(!checkFlg)return;
	ajaxSubmit(url, params, function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.msg(msgBean.msg,2,f5);
		}else{
			$("#error").html(msgBean.msg);
		}
	},"json");
}
	</script>
</body>
</html>