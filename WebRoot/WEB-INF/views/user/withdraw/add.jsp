<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>提现申请</title>
</head>
<body>
	<div class="body_center2 fl p10 ml10">
		<div class="chongzhititle">
			<h4>提现申请</h4>
		</div>

		<div class="shezhimima2" style="min-height: 400px;">
			<div class="shemiform">
				<p>提现说明：</p>
				<p>1.提现申请提交后需要等待审核，审核成功后进行转账，此过程需要2-3个工作日。如果未到账请联系客服。</p>
				<p>2.申请提现后，申请金额将从账户中扣除，如果最后提现失败该金额将退回账户。</p>
				<br />
				<br />
				<table>
					<tr><td>账户可用余额：</td><td>${account.normalMoney}</td></tr>
					<tr><td>卡主：</td><td>${account.bankCardMaster}</td></tr>
					<tr><td>提现绑定银行卡：</td><td><c:if test="${empty account.bankNo}"><a href="/user/security/bank" style="color:red">( 无 ) 去绑定 >> </a></c:if> ${account.bankNo}</td></tr>
					<tr><td>银行卡所属银行：</td><td>${account.bankName}</td></tr>
					<tr><td colspan="2">------------------------------------------------</td></tr>
					<tr><td>提现金额：</td><td><input id="withdraMoney" class="shoujitxt fl" type="text"
						autocomplete="off" onkeyup="zhigu.cmn.restrictInputMoney(this);" /></td></tr>
					<tr><td>支付密码：</td><td><input class="shoujitxt fl" type="password" id="payPasswd"
						autocomplete="off" /></td></tr>
						<tr><td></td><td><input class="shemenext cp mt10" type="button" value="提交申请"
					onclick="save();" /></td></tr>
				</table>
				<div class="clear"></div>
				
			</div>
		</div>
	</div>
	<div class="clear"></div>
	<script type="text/javascript">
		function save(){
			var params = {};
			params.money = $("#withdraMoney").val();
			params.payPasswd = zhigu.encodeBase64($("#payPasswd").val());
			if(params.money<100){
				layer.alert("提现金额必须是100以上");
				return false;
			}
			$.post("/user/withdraw/add",params,function(msgBean){
				if(msgBean.code==zhigu.code.success){
					layer.msg(msgBean.msg,2,function(){
						window.location.href = "/user/withdraw";
					})
				}else{
					layer.alert(msgBean.msg);
				}
			},"json");
		}
	</script>
</body>
</html>