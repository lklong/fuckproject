<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>充值</title>
<link href="css/chongzhi.css" rel="stylesheet" type="text/css" />
<link href="css/zuce.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
</head>
<body>
	<div class="rightContainer fr">
		<h4 class="ddtitle">网上充值</h4>
		<!--// 内容框 //-->
		<div class="rc_body">
			<div id="userContents" class="userContents">
				<!--// 内容1 //-->
				<div class="body_center2">
					<div class="zhifubaobox">
						<c:choose>
							<c:when test="${hasPaypasswd }">
								<div class="zhifubaoform">
									<div class="msg-alert">在线充值</div>
									<div class="zfbBox">
										<form action="/user/recharge/pay" id="rechargeForm" method="post" target="_blank">
											<h2 class="mt10">
												您正在为智谷同城货源网账户<font color="#ff3300"><strong> ${auth.username } </strong></font>充值
											</h2>
											<div class="mt10">
												支付金额： <input type="text" id="money" class="input-txt" name="money" onkeyup="zhigu.cmn.restrictInputMoney(this);" /> <span
													class="color-red mt5" id="e_msg"></span>
											</div>
											<div class="mt10">
												充值类型： <span class="mt10"><input type="radio" name="rechargeType" value="1" checked="checked" /></span> <span class="mt10 ml10"><img
													style="margin-bottom: -15px;" src="../img/default/zhifubao.jpg" /></span>
											</div>
											<div class="mt20">
												<input class="chongzhi-input-btn" type="button" onclick="rechargeForm()" value="充值" />
											</div>
										</form>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="chongzhi1">
									<div class="msg-alert">为保障您账户资金安全，请先做以下设置：</div>
									<div class="chongzhibot">
										<p class="czbot1">
											- 您尚未设置支付密码，请先设置：<a href="user/security/paymentpwd" class="default-a">支付密码 >></a>
										</p>
										<p class="czbot2">支付密码：使用账户余额、资金提现、确认收货时使用</p>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
						<br style="clear: both;" />
					</div>
				</div>
			</div>
			<br style="clear: both;" />
		</div>
	</div>
	<script type="text/javascript">
		function rechargeForm() {
			var money = $("#money").val();
			if(zhigu.cmn.moneyReg(money)){
				$("#rechargeForm").submit();
				layer.alert("<a href='/user/acc/rechargelist'>去查看充值信息 >></a>",function(){
					window.location.href = "/user/acc/rechargelist";
				});
			}else{
				$("#e_msg").html("请填写正确的充值金额！");
			}
		}
	</script>
</body>
</html>