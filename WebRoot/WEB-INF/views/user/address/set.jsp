<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<script type="text/javascript" src="js/pca.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收货地址</title>
</head>
<body>

	<div class="rightContainer">
		<!--// 标题 //-->
		<h3 class="rc_title">
			收货地址<a href="user/home">我的主页</a>
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<!--// tab切换条 //-->
			<div id="userCommTab" class="userCommTab">
				<ul>
					<li><a href="javascript:void(0);" class="uctSelected">收货地址</a></li>
				</ul>
			</div>
			<div id="userContents" class="userContents">
				<!--// 内容1 //-->
				<div class="dengjibox pt10">
					<div class="dizhibox">
						<div class="dizhitxt0" style="margin-left: 38px;">
							<c:choose>
								<c:when test="${not empty address.ID }">
									<h4 class="dizhih4">修改收货地址</h4>
								</c:when>
								<c:otherwise>
									<h4 class="dizhih4">新增收货地址</h4>
								</c:otherwise>
							</c:choose>
							<p class="dizhip" style="height: 25px;">
								<span class="dizhispan"></span>*号为必填选项
							</p>
							<div class="clear"></div>
						</div>
						<c:set var="method" value="add" />
						<form  id="addForm">
							<div class="dizhitxt">
								<p class="dizhititle">
									<span class="dizhixing">*</span> 收货人姓名：
								</p>
								<c:if test="${not empty address.ID }">
									<input type="hidden" name="ID" value="${address.ID }">
								</c:if>
								<input type="text" name="name" placeholder="最多 32个字符" value="${address.name}" />
							</div>

							<div class="dizhitxt">
								<p class="dizhititle">
									<span class="dizhixing">*</span> 手机号码：
								</p>
								<input type="text" name="phone" value="${address.phone}" />
							</div>
							<div class="dizhitxt">
								<p class="dizhititle">
									<span class="dizhixing">*</span> 所在地区：
								</p>
								<select class="mr10" name="province" id="province" style="width: 130px;"></select> 
								<select class="mr10" name="city" id="city" style="width: 130px;"></select> 
								<select name="district" id="district" style="width: 130px;"></select>
							</div>
							<div class="dizhitxt">
								<p class="dizhititle">
									<span class="dizhixing">*</span> 具体收货地址：
								</p>
								<textarea class="fl mr10" name="street" placeholder="最多128个字符" style="resize: none; width: 270px;">${address.street}</textarea>
							</div>
							<p class="dizhitxt" display="block">
								<p class="dizhititle">邮政编码：</p>
								<input type="text" class="mr10" style="height: 25px; line-height: 25px; margin-bottom: 20px" name="postcode" value="${address.postcode}" />
								<label class="error">${msg_postcode}</label>
							</p>
							<div class="dizhitxt">
								<p class="dizhititle">电话号码：</p>
								<input type="text" name="tel" value="${address.tel}" /><label class="error">${msg_tel}</label>
							</div>
							<div class="dizhitxt">
								<p class="dizhititle">设为默认：</p>
								<input type="checkbox" class="mr10" value="1" <c:if test="${address.isDefault == 1 }">checked="checked"</c:if> name="isDefault" /><strong>设置为默认收货地址</strong>
							</div>
							<input class="dizhisub cp" type="submit" value="保存" /><label class="error">${msg_msg}</label>
						</form>
					</div>
				</div>

			</div>
			<br style="clear: both;" />
		</div>
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
				number:true,
			},
			phone:{
				mobilePhone:true,
				required:true,
			}
		},
		submitHandler:function(form){
			var addressID = "${address.ID}";
			var url = addressID?"/user/address/modify":"/user/address/add";
			ajaxSubmit(url, $("#addForm").serialize(), function(msgBean){
				if(msgBean.code == zhigu.code.success){
					layer.msg(msgBean.msg, 1, function(){
						window.location.href = "/user/address";
					});
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