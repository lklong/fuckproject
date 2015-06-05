<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="js/validate/validate.css" />
<script type="text/javascript" src="js/pca.js"></script>
<script type="text/javascript" src="js/validate/jquery.validate.js"></script>
<script type="text/javascript" src="js/validate/message_cn.js"></script>
<script type="text/javascript" src="js/validate/additional-methods.js"></script>
<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
<title>收货地址</title>
</head>
<body>

	<div class="rightContainer fr">
		<h4 class="ddtitle">收货地址</h4>
		<c:set var="method" value="add" />
		<form  id="addForm">
		<table cellpadding="0" cellspacing="0" class="user-form-table">
				<tr>
					<td><c:choose>
								<c:when test="${not empty address.id }">
									<h4>修改收货地址</h4>
								</c:when>
								<c:otherwise>
									<h4>新增收货地址</h4>
								</c:otherwise>
							</c:choose></td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2"><div class="msg-alert"><span class="gantanhao"></span>*号为必填选项</div></td>
				</tr>
				<tr>
					<td style="width:15%"><span class="color-red">*</span> 收货人姓名：</td>
					<td style="width:85%"><c:if test="${not empty address.id }">
									<input type="hidden" name="id" value="${address.id }">
								</c:if>
								<input class="input-txt" type="text" name="name" placeholder="最多 32个字符" value="${address.name}" /></td>
				</tr>
				<tr>
					<td><span class="color-red">*</span> 手机号码：</td>
					<td><input class="input-txt" type="text" name="phone" value="${address.phone}" /></td>
				</tr>
				<tr>
					<td><span class="color-red">*</span> 所在地区：</td>
					<td><select class="select-txt" name="province" id="province"></select>
<select class="select-txt" name="city" id="city"></select>
<select name="district" id="district" class="select-txt"></select></td>
				</tr>
				<tr>
					<td><span class="color-red">*</span> 具体收货地址：</td>
					<td><textarea class="fl mr10" name="street" placeholder="最多128个字符" >${address.street}</textarea></td>
				</tr>
				<tr>
					<td> 邮政编码：</td>
					<td><input type="text" class="input-txt" name="postcode" value="${address.postcode}" /><label
								class="error">${msg_postcode}</label></td>
				</tr>
				<tr>
					<td> 电话号码：</td>
					<td><input class="input-txt" type="text" name="tel" value="${address.tel}" /><label class="error">${msg_tel}</label></td>
				</tr>
				<tr>
					<td> 是否默认：</td>
					<td><input type="checkbox" id="isDefault"  class="mr10" <c:if test="${address.defaultFlag}">checked="checked"</c:if> />
							<label for="isDefault"><strong>设置为默认收货地址</strong></label>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><input class="input-button" type="submit" value="保存" /><label class="error">${msg_msg}</label></td>
				</tr>
			</table>
		</form>
		
	</div>
	<script type="text/javascript">
$().ready(function(){
	$("#addForm").validate({
		rules:{
			name:{
				maxlength:32,
				required:true,
			},
			street:{
				required:true,
				minlength:2,
				maxlength:128
			},
			postcode:{
				postCode:true,
				number:true
			},
			district:{
				required:true,
			},
			tel:{
				tel:true,
// 				required:true,
				//number:true,
			},
			phone:{
				mobilePhone:true,
				required:true,
			}
		},
		submitHandler:function(form){
			var addressId = "${address.id}";
			var default_addr = 0;
			if($("#isDefault")[0].checked){
				 default_addr = 1;
			}
			var url = addressId?"/user/address/modify":"/user/address/add";
			var param = $("#addForm").serialize()+"&defaultFlag="+default_addr;
			ajaxSubmit(url, param, function(msgBean){
				if(msgBean.code == zhigu.code.success){
					layer.alert(msgBean.msg);
					setTimeout(function(){
						window.location.href = "/user/address";
					},3000);
				}else{
					layer.alert(msgBean.msg);
				}
			},"json");
		}
		
	})
	var pro = "${address.province}";
	var city = "${address.city}";
	if(pro == "")
		pro = "四川省";
	if(city == "")
		city = "成都市";
	new PCAS("province", "city", "district",pro,city,"${address.district}");
	
	
})
</script>
</body>
</html>