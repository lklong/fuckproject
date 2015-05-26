<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帐户信息</title>
</head>
<body>
<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	帐户信息<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">帐户信息</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
          <div class="body_center2">
		     <div class="zhanghubox pt20">
			<ul>
				<li class="zhanghuli1">
					<div class="zhnamebox cp" title="yl_1B445579">
						<span class="zhanghuname fwbold">${auth.username }</span>
					</div>
					<c:choose>
						<c:when test="${userInfo.realUserAuthFlg==1 }">
							<div class="zhanghurenzheng-jihuo ml10 pr10 cp" title="实名认证">
								<span>已认证</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="zhanghurenzheng ml10 pr10 cp" title="实名认证">
								<span>未认证</span>
							</div>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${hasPayPWD}">
							<div class="zhanghujihuo-jihuo pr10 cp" title="支付密码">
								<span>已激活</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="zhanghujihuo pr10 cp" title="支付密码">
								<span>未激活</span>
							</div>
						</c:otherwise>
					</c:choose>
					
					<c:choose>
						<c:when test="${auth.phone!=null}">
							<div class="zhanghuobd-jihuo cp" title="手机绑定">
								<span>已绑定</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="zhanghuobd cp" title="手机绑定">
								<span>未绑定</span>
							</div>
						</c:otherwise>
					</c:choose>
					<p class="clear"></p>
				</li>
				<li class="keyongjine">可用金额：<span>${acc.normalMoney }</span>元
				</li>
				<li class="dongjiejine">冻结金额：<span>${acc.freezeMoney }</span>元
				</li>
				<li class="jiaoyijilu">交易记录：<a href="user/acc/detail">收支明细>></a>
				</li>
			</ul>
			<div class="zhanghuanniu mt10">
				<a href="user/recharge">
					<input type="button" value="充值" />
				</a>
				<!-- <input type="button" value="提现" /> -->
			</div>
		</div>
	</div>
     </div>
            <br style="clear:both;" />
        </div>
    </div>
<div class="clear"></div>
</body>
</html>