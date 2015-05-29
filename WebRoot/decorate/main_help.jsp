<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html >
<html >
<head>
<base href="${applicationScope.basePath}" />
<title>智谷同城货源网－帮助中心-<sitemesh:write property='title' /></title>

<jsp:include page="/decorate/include/header-head.jsp" />
<sitemesh:write property='head' />
<style>
pre {
	white-space: pre-wrap; /* css-3 */
	white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
	white-space: -pre-wrap; /* Opera 4-6 */
	white-space: -o-pre-wrap; /* Opera 7 */
	word-wrap: break-word; /* Internet Explorer 5.5+ */
}
</style>
</head>

<body>
	<jsp:include page="/decorate/include/header-body.jsp" />
	<!--** 文章主体 **-->
	<div class="articleBody">
		<!--** 左侧导航 **-->
		<div class="articleLeft">
			<div class="articleHead">智谷帮助中心</div>
			<div class="artLeftInside">
				<dl>
					<dt>
						<em class="helpIcon_1"></em><a href="javascript:void(0);">新手指南</a>
					</dt>
					<c:forEach items="${cementContentAll}" var="cc">
						<c:if test="${cc.type==1}">
							<dd>
<%-- 								<a href="/help/cemment?id=${cc.id }">${cc.title}</a> --%>
								<a href="javascript:void(0);">${cc.title}</a>
							</dd>
						</c:if>
					</c:forEach>
					<!--   <dd><a href="/help/userregister">会员注册</a></dd>
                <dd><a href="/help/storeregister">供应商注册</a></dd>
                <dd><a href="/help/security">账号密码</a></dd>
                <dd><a href="/help/buyerhandle">买家入门</a></dd>
                <dd><a href="/help/sellerenter">卖家入门</a></dd> -->
				</dl>
				<dl>
					<dt>
						<em class="helpIcon_1"></em><a href="javascript:void(0);">配送与支付</a>
					</dt>
					<c:forEach items="${cementContentAll}" var="cc">
						<c:if test="${cc.type==2}">
							<dd>
<%-- 								<a href="/help/cemment?id=${cc.id }">${cc.title}</a> --%>
							<a href="javascript:void(0);">${cc.title}</a>
							</dd>
						</c:if>

					</c:forEach>
					<!--  <dd><a href="/help/proxy">代发方式</a></dd>
                <dd><a href="/help/pay">支付方式</a></dd>
                <dd><a href="/help/contact">联系客服</a></dd>
                <dd><a href="/help/recharge">充值付款</a></dd> -->
				</dl>
				<dl>
					<dt>
						<em class="helpIcon_1"></em><a href="javascript:void(0);">关于我们</a>
					</dt>
					<c:forEach items="${cementContentAll}" var="cc">
						<c:if test="${cc.type==3}">
							<dd>
								<a href="/help/cemment?id=${cc.id }">${cc.title}</a>
							</dd>
						</c:if>

					</c:forEach>
					<!--  <dd><a href="/help/company">公司简介</a></dd>
                <dd><a href="/help/contactour">联系我们</a></dd>
                <dd><a href="/help/recruit">团队招聘</a></dd> -->
				</dl>
				<dl>
					<dt>
						<em class="helpIcon_1"></em><a href="javascript:void(0);">友情链接</a>
					</dt>
					<dd>
						<a href="http://www.ickd.cn/" target="_blank">快递查询</a>
					</dd>
				</dl>
			</div>
		</div>
		<!--** 右侧内容 **-->
		<sitemesh:write property='body' />

		<br style="clear: both" />
	</div>
	<jsp:include page="include/footer.jsp" />
</body>
</html>
