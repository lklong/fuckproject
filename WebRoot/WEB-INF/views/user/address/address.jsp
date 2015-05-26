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
					<div class="dizhibox2 mt20 pt20">
						<div style="padding: 10px 50px;">
							<input value="添加收货地址" onclick="window.location.href='/user/address/set';" type="button" class="liinput"/><br/><br/>
						</div>
						<table>
							<tr>
								<th width="100px">收货人</th>
								<th width="150px">所在地区</th>
								<th width="200px">具体收货地址</th>
								<th width="50px">邮编</th>
								<th>电话/手机</th>
								<th></th>
								<th>操作</th>
							</tr>
							<c:forEach var="ad" items="${list}">
								<tr>
									<td>${ad.name}</td>
									<td>${ad.province}${ad.city}${ad.district}</td>
									<td align="left">${ad.street}</td>
									<td>${ad.postcode}</td>
									<td><c:choose>
											<c:when test="${ad.phone!='' && ad.phone!=null}">
                        			${ad.phone}
                        		</c:when>
											<c:otherwise>
                        			${ad.tel}
                        		</c:otherwise>
										</c:choose></td>
									<td><c:choose>
											<c:when test="${ad.isDefault==1}">
                        			默认地址
                        		</c:when>
											<c:when test="${ad.isDefault!=1}">
												<a href="javascript:void(0)" onclick="setDefault(${ad.ID})">设为默认</a>
											</c:when>
										</c:choose></td>
									<td><a href="/user/address/set?addressId=${ad.ID}">修改</a><a onclick="del(${ad.ID})">删除</a></td>
								</tr>
							</c:forEach>
						</table>
						<p>最多保存10个有效地址</p>
					</div>
				</div>

			</div>
			<br style="clear: both;" />
		</div>
	</div>
	<script type="text/javascript">
$().ready(function(){
	var addressID = "${ad.ID}";
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
			var url = addressID?"user/address/modify":"user/address/add";
			ajaxSubmit($(form).attr("action"), $("#addForm").serialize(), function(msgBean){
				if(msgBean.code == zhigu.code.success){
					layer.msg(msgBean.msg, 1, f5);
				}else{
					layer.alert(msgBean.msg);
				}
			},"json");
		}
		
	})
	var pro = "${ad.province}";
	var city = "${ad.city}";
	if(pro == "")
		pro = "四川省";
	if(city == "")
		city = "成都市";
	new PCAS("province", "city", "district",pro,city,"${ad.district}");
})
//设置默认
function setDefault(addressID){
	ajaxSubmit("user/address/default", "addressID=" + addressID, function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.msg(msgBean.msg, 1, f5);
		}else{
			layer.alert(msgBean.msg);
		}
	},"json");
}
//删除收货地址
function del(addressID){
	$.layer({
	    shade: [0.5,'#000'],
	    area: ['auto','auto'],
	    dialog: {
	        msg: '确认要删除收货地址？',
	        btns: 2,                    
	        type: 4,
	        btn: ['确定','取消'],
	        yes: function(){
	        	_del();
	        }
	    }
	});
	function _del(){
		ajaxSubmit("user/address/del", "addressID=" + addressID, function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg, 1, f5);
			}else{
				layer.alert(msgBean.msg);
			}
		},"json");
	}
}
</script>
</body>
</html>