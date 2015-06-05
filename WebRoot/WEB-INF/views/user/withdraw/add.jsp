<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>提现申请</title>
<script type="text/javascript" src="/js/3rdparty/layer1.9/layer.js?v=20150505"></script>
</head>
<body>
	<div class="rightContainer fr">
		<h4 class="ddtitle">提现申请</h4>
		<div class="msg-alert" style="padding:10px 10px; height:80px; margin:20px 0;"><span class="gantanhao"></span>
			<p>提现说明：</p>
			<p>1.提现申请提交后需要等待审核，审核成功后进行转账，此过程需要2-3个工作日。如果未到账请联系客服。</p>
			<p>2.申请提现后，申请金额将从账户中扣除，如果最后提现失败该金额将退回账户。</p>
		</div>


				<table cellpadding="0" cellspacing="0" class="user-form-table">
					<tr>
						<td style="width:20%">账户可用余额：</td>
						<td style="width:80%">${account.normalMoney}</td>
					</tr>
					<tr><td>卡主：</td><td>${account.bankCardMaster}</td></tr>
					<tr><td>提现绑定银行卡：</td><td><c:if test="${empty account.bankNo}"><a href="/user/security/bank" style="color:red">( 无 ) 去绑定 >> </a></c:if> ${account.bankNo}</td></tr>
					<tr><td>银行卡所属银行：</td><td>${account.bankName}</td></tr>
					<tr><td>提现金额：</td><td><input id="withdraMoney" class="input-txt" type="text"
						autocomplete="off" onkeyup="zhigu.cmn.restrictInputMoney(this);" /></td></tr>
					<tr><td>支付密码：</td><td><input class="input-txt" type="password" id="payPasswd"
						autocomplete="off" /></td></tr>
						<tr><td></td><td><input class="input-button" type="button" value="提交申请"
					onclick="save();" /></td></tr>
				</table>
</div>
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