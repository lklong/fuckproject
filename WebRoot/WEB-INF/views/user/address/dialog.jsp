<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<table id="addForm" cellpadding="0" cellspacing="0" class="user-form-table fz12">
		<tr>
			<td style="width:20%">&nbsp;</td>
			<td style="width:80%"><label class="color-red" id="error"></label></td>
		</tr>
		<tr>
			<td style="width:20%"><font color="color-red"> * </font>收货人姓名：</td>
			<td style="width:80%">
			<input type="hidden" value="${address.id }" id="addressId">
			<input class="input-txt" name="name" value="${address.name }" type="text" />
			<span class="errorMsg color-red"></span>
			</td>
		</tr>
		<tr>
			<td><font color="color-red"> * </font>手机号码：</td>
			<td><input class="input-txt" name="phone" value="${address.phone }" type="text" />
			<span class="errorMsg color-red"></span>
			</td>
		</tr>
		<tr>
			<td><font color="color-red"> * </font>所在地区：</td>
			<td>
			<select class="select-txt" name="province" id="province"></select>
			<select class="select-txt" name="city" id="city"></select>
			<select class="select-txt" name="district" id="district"></select>
			<span class="errorMsg color-red"></span>
			</td>
		</tr>
		<tr>
			<td><font color="color-red"> * </font>街道地址：</td>
			<td><input class="input-txt" name="street" value="${address.street }" type="text" />
			<span class="errorMsg color-red"></span>
			</td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;邮政编码：</td>
			<td><input class="input-txt" name="postcode" value="${address.postcode }" type="text" />
			<span class="errorMsg color-red"></span>
			</td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;电话号码：</td>
			<td><input class="input-txt" type="text" name="tel" value="${address.tel }" />
			<span class="errorMsg color-red"></span>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input id="defaultFlag" <c:if test="${address.defaultFlag }">checked="checked"</c:if>  type="checkbox" />
			<label for="defaultFlag">设置为默认地址</label>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input class="input-button" type="button" onclick="submitAddr();" value="保存" />
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
		params.id = $("#addressId").val();
		url = "user/address/modify";
	}else{
		url = "user/address/add";
	}
	
	$(".errorMsg").html("");
	// 数据验证
	var checkFlg = true;
	params.name = $("#addForm input[name='name']").val();
	if(!(params.name && params.name.length<=32)){
		$("#addForm input[name='name']").closest("tr").find(".errorMsg").html("请填写正确的用户名");
		checkFlg = false;
	}
	params.phone = $("#addForm input[name='phone']").val();
	if(!(params.phone && zhigu.verify.phoneReg(params.phone))){
		$("#addForm input[name='phone']").closest("tr").find(".errorMsg").html("请填写正确的手机号");
		checkFlg = false;
	}
	params.province = $("#province").val();
	params.city = $("select[name='city']").val();
	params.district = $("#district").val();
	if(!params.district){
		$("#district").closest("tr").find(".errorMsg").html("请选择地区");
		checkFlg = false;
	}
	params.street = $("#addForm input[name='street']").val();
	if(!params.street){
		$("#addForm input[name='street']").closest("tr").find(".errorMsg").html("请填写街道地址");
		checkFlg = false;
	}
	params.postcode = $("#addForm input[name='postcode']").val();
	params.tel = $("#addForm input[name='tel']").val();
	params.defaultFlag = $("#defaultFlag").prop("checked");
	if(!checkFlg)return;
	$.post(url, params, function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.closeAll();
			layer.msg(msgBean.msg);
			loadAddress();
		}else{
			$("#error").html(msgBean.msg);
		}
	},"json");
}
	</script>
</body>
</html>