<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>帐户信息</title>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">帐户信息</h4>
  <!--// 内容框 //-->
  <div class="rc_body">
    <div id="userContents" class="userContents">
     <table cellpadding="0" cellspacing="0" class="user-form-table">
     	<tr>
     		<td style="width:10%;"><span class="">${auth.username }</span></td>
     		<td style="width:90%;"><c:choose>
                <c:when test="${userInfo.realUserAuthFlg==1 }">
                  <div class="" title="实名认证"> <span>已认证</span> </div>
                </c:when>
                <c:otherwise>
                  <div class="" title="实名认证"> <span>未认证</span> </div>
                </c:otherwise>
              </c:choose>
              <c:choose>
                <c:when test="${hasPayPWD}">
                  <div class="" title="支付密码"> <span>已激活</span> </div>
                </c:when>
                <c:otherwise>
                  <div class="" title="支付密码"> <span>未激活</span> </div>
                </c:otherwise>
              </c:choose></td>
     	</tr>
     	<tr>
     		<td>&nbsp;</td>
     		<td><c:choose>
                <c:when test="${auth.phone!=null}">
                  <div class="" title="手机绑定"> <span>已绑定</span> </div>
                </c:when>
                <c:otherwise>
                  <div class="" title="手机绑定"> <span>未绑定</span> </div>
                </c:otherwise>
              </c:choose></td>
     	</tr>
     	<tr>
     		<td>可用金额：</td>
     		<td><span class="fz14 fwb color-red">${acc.normalMoney }</span>元</td>
     	</tr>
     	<tr>
     		<td>冻结金额：</td>
     		<td><span class="fz14 fwb color-red">${acc.freezeMoney }</span>元</td>
     	</tr>
     	<tr>
     		<td>交易记录：</td>
     		<td><a href="user/acc/detail" class="default-a">收支明细</a></td>
     	</tr>
     	<tr>
     		<td>&nbsp;</td>
     		<td><input type="button" value="充值" class="input-button" /><!-- <input type="button" value="提现" /> --></td>
     	</tr>
     </table>
    </div>
  </div>
</div>
</body>
</html>