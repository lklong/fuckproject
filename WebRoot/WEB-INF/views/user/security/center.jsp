<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>安全设置</title>
</head>
<body>
	<div class="rightContainer fr">
		<h4 class="ddtitle">安全设置</h4>
		<!--// 内容框 //-->
		<div class="rc_body">
			<div id="userContents" class="userContents">
				<table cellpadding="0" cellspacing="0" class="user-form-table">
					<tr class="user-form-tr">
						<td style="width: 10%"><em class="set-icon si-pwd"></em></td>
						<td style="width: 80%"><p>安全性高的密码可以使账号更安全。建议您设置包含数字和字母、长度6位以上的密码，并定期更换。
							</p>
							<p>
								密码强度:<strong class="ce81268">强</strong>
							</p></td>
						<td style="width: 10%"><a
							href="/user/security/updateLoginpwd" class="edit-user-photo">
								<c:choose>
									<c:when test="${empty auth.password}">
										<input type="button" value="设置" />
									</c:when>
									<c:otherwise> 修改 </c:otherwise>
								</c:choose>
						</a></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="user-form-table">
					<tr class="user-form-tr">
						<td style="width: 10%"><em class="set-icon si-phone"></em></td>
						<td style="width: 80%"><p>绑定手机后，您可以免费享受智谷同城货源网的短信提示服务，同时可用于找回账户登录密码和支付密码。</p>
							<p>
								<c:if test="${not empty auth.phone }">
									<span>已绑定手机：<strong class="ce81268">${auth.phone }</strong></span>
								</c:if>
								<c:if test="${empty auth.phone }">
									<span><strong class="ce81268" style="color: red">未绑定</strong></span>
								</c:if>
							</p></td>
						<td style="width: 10%"><a href="user/security/phone"
							class="edit-user-photo"> <c:choose>
									<c:when test="${empty auth.phone }">
										<input type="button" value="设置" />
									</c:when>
									<c:otherwise> 修改 </c:otherwise>
								</c:choose>
						</a></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="user-form-table">
					<tr class="user-form-tr">
						<td style="width: 10%"><em class="set-icon si-mail"></em></td>
						<td style="width: 80%"><p>绑定邮箱后，您可以免费享受同城货源网的邮件提示服务，同时可用于找回账户登录密码和支付密码。</p>
							<p>
								<c:if test="${not empty auth.email }">
									<span>已绑定邮箱：<strong class="ce81268">${auth.email }</strong></span>
								</c:if>
								<c:if test="${empty auth.email }">
									<span><strong class="ce81268" style="color: red">未设置</strong></span>
								</c:if>
							</p></td>
						<td style="width: 10%"><a href="user/security/email"
							class="edit-user-photo"> <c:choose>
									<c:when test="${empty auth.email }">
										<input type="button" value="设置" />
									</c:when>
									<c:otherwise> 修改 </c:otherwise>
								</c:choose>
						</a></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="user-form-table">
					<tr class="user-form-tr">
						<td style="width: 10%"><em class="set-icon si-money"></em></td>
						<td style="width: 80%"><p>余额付款、确认收货、账户充值提现时使用。用于保障账户资金安全。
							</p>
							<p>
								<c:if test="${not empty account.payPasswd }">
									<span><strong class="ce81268">已设置</strong></span>
								</c:if>
								<c:if test="${empty account.payPasswd }">
									<span><strong class="ce81268" style="color: red">未设置</strong></span>
								</c:if>
							</p></td>
						<td style="width: 10%"><a href="user/security/paymentpwd"
							class="edit-user-photo"><c:choose>
									<c:when test="${empty account.payPasswd }">
										<input type="button" value="设置" />
									</c:when>
									<c:otherwise> 修改 </c:otherwise>
								</c:choose></a></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="user-form-table">
					<tr class="user-form-tr">
						<td style="width: 10%"><em class="set-icon si-bank"></em></td>
						<td style="width: 80%"><p>账户提现申请账户转入银行卡，余额提现。</p>
							<p>
								<c:if test="${not empty account.bankNo }">
									<span>已绑定银行卡：<strong class="ce81268">${account.bankNo }</strong></span>
								</c:if>
								<c:if test="${empty account.bankNo }">
									<span><strong class="ce81268" style="color: red">未绑定</strong></span>
								</c:if>
							</p></td>
						<td style="width: 10%"><a href="user/security/bank"
							class="edit-user-photo"> <c:choose>
									<c:when test="${empty account.bankNo }">
										<input type="button" value="绑定" />
									</c:when>
									<c:otherwise> 修改 </c:otherwise>
								</c:choose>
						</a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>