<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>推广用户提成</title>

</head>

<body >
<!-- //功能条// -->
<div class="sysInfoBar">
	<h3>提成说明：</h3>
	<p>1.提成只对本公司订单进行；</p>
	<p>2.用于提成金支付的钱从公司账户里扣除；</p>
	<p>3.公司员工提成比：订单商品价格 x公司员工提成比 分配给推荐人是公司员工，公司员工作为顶级处理；</p>
	<p>4.基础提成比：订单商品价格 x 基础提成比 用于分配给该消费用户的上三级推荐人；</p>
	<p>5.一级提成比：为该消费用户直接推荐人获得提成比例；二、三级提成比为该用户的上上级、上上上级推荐人；</p>
	<p>6.推荐人获得提成金：订单商品价格 x 基础提成比 x 对应级别的提成比；</p>
	<p>7.没有推荐人时不进行提成金分配。</p>
</div>  
<table cellpadding="0" cellspacing="0" class="sysCommonTable">
	<tr>
		<th>制度</th>
		<th>比例</th>
	</tr>
	<tr><td>公司员工提成比：</td><td><input value="${commissionPorportion.innerEmployeePorportion }" id="innerEmployeePorportion" class="mustNumber" style="width:40px;" maxlength="2"/> %</td></tr>
	<tr><td>基础提成比：</td><td><input value="${commissionPorportion.basePorportion }" id="basePorportion" class="mustNumber" style="width:40px;" maxlength="2"/> %</td></tr>
	<tr><td>一级提成比：</td><td><input value="${commissionPorportion.firstPorportion }" id="firstPorportion" class="mustNumber" style="width:40px;" maxlength="2"/> %</td></tr>
	<tr><td>二级提成比：</td><td><input value="${commissionPorportion.secondPorportion }" id="secondPorportion" class="mustNumber" style="width:40px;" maxlength="2"/> %</td></tr>
	<tr><td>三级提成比：</td><td><input value="${commissionPorportion.thirdPorportion }" id="thirdPorportion" class="mustNumber" style="width:40px;" maxlength="2"/> %</td></tr>
	<tr><td colspan="2"><input type="button" value="保存" onclick="savePorportion();" class="sysSubmit" /></td></tr>
</table>
<script type="text/javascript">
$(function(){
	$(".mustNumber").on("keyup",function(){
			var val = $(this).val();
			var after = val.replace(/[^0-9]/g,"");
			$(this).val(after);
		});
})
function savePorportion(){
	var innerEmployeePorportion = parseInt($("#innerEmployeePorportion").val());
	var basePorportion = parseInt($("#basePorportion").val());
	var firstPorportion =  parseInt($("#firstPorportion").val());
	var secondPorportion =  parseInt($("#secondPorportion").val());
	var thirdPorportion =  parseInt($("#thirdPorportion").val());
	if(innerEmployeePorportion>20){
		dialog("公司员工提成比不能大于20%！");
		return;
	}
	if(basePorportion>20){
		dialog("基础提成比不能大于20%！");
		return;
	};
	if(firstPorportion+secondPorportion+thirdPorportion!=100){
		dialog("一级提成比+二级提成比+三级提成比 必须为100%！");
		return;
	};
	confirmDialog("确认保存分配比例？",function(){
		ajaxSubmit("/admin/promotion/saveCommissionPorportion",{"innerEmployeePorportion":innerEmployeePorportion,"basePorportion":basePorportion,"firstPorportion":firstPorportion,"secondPorportion":secondPorportion,"thirdPorportion":thirdPorportion},function(data){
			dialog(data.msg,function(){
				if(data.code==1){
					f5();
				}
			});
		},"json");
	});
}
</script>
</body>
</html>
