<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商家介绍</title>
</head>
<body>
	<jsp:include page="header.jsp" />

	<div class="shop_info_body">
		<div class="shop_info_inner">
			<div class="head_info">公司档案</div>
			<div class="head_body">
				<div class="body_title">公司简介</div>
				<div class="body_info">
					<h3>
						<div class="fl mr10">${store.storeName }</div>
						<c:if test="${companyAuth != null}"><span class="span_renzheng qiye"></span></c:if>
						<c:if test="${realStoreAuth != null}"><span class="span_renzheng shidi"></span></c:if>
<!-- 						<span class="span_renzheng baozhang"></span> -->
					</h3>
					<p>${store.introduction }</p>
					<div class="body_div">
						<div>
							开店时间：
							<fmt:formatDate value="${store.openStoreDate }" pattern="yyyy-MM-dd" />
						</div>
						<div>商品数量：${storeCommodityNumber + 0 }件</div>
						<div>所在批发市场：${address }</div>
					</div>
				</div>
			</div>

			<div class="head_body">
				<div class="body_title">
					公司认证信息
					<c:if test="${companyAuth == null}">（未认证）</c:if>
				</div>
				<div class="body_info">
					<c:if test="${companyAuth != null}">
						<div class="zhenshi_renzheng"></div>
						<table class="body_table" cellpadding="0" cellspacing="0">
							<tr>
								<td style="width: 10%">企业名称</td>
								<td style="width: 40%">${companyAuth.companyName }</td>
								<td style="width: 10%">企业类型</td>
								<td style="width: 40%">${companyType }</td>
							</tr>
							<tr>
								<td style="width: 10%">工商注册号</td>
								<td style="width: 40%">${companyAuth.regNumber }</td>
								<td style="width: 10%">企业法人</td>
								<td style="width: 40%">${companyAuth.corporation }</td>
							</tr>
							<tr>
								<td style="width: 10%">营业期限</td>
								<td style="width: 40%"><fmt:formatDate value="${companyAuth.businessTerm }" pattern="yyyy-MM-dd" /></td>
								<td style="width: 10%">注册资金</td>
								<td style="width: 40%">${companyAuth.capital }万</td>
							</tr>
							<tr>
								<td style="width: 10%">营业范围</td>
								<td style="width: 40%">${companyAuth.businessScope }</td>
								<td style="width: 10%">注册地址</td>
								<td style="width: 40%">${companyAuth.regProvince }${companyAuth.regCity }${companyAuth.regDistrict }${companyAuth.regStreet }</td>
							</tr>
						</table>
						<ul>
							<li class="rz_img"><img style="max-width:120px" src="${companyAuth.imageSmall}" /></li>
						</ul>
					</c:if>
				</div>
			</div>

			<div class="head_body">
				<div class="body_title">
					实体认证信息
					<c:if test="${realStoreAuth == null}">（未认证）</c:if>
				</div>
				<div class="body_info">
					<c:if test="${realStoreAuth != null}">
						<div class="shidi_renzheng"></div>
						<table class="body_table" cellpadding="0" cellspacing="0">
							<tr>
								<td style="width: 10%">实体地址</td>
								<td style="width: 40%">${realStoreAuth.realStoreAddress }</td>
								<td style="width: 10%">实体名称</td>
								<td style="width: 40%">${realStoreAuth.realStoreName }</td>
							</tr>
							<tr>
								<td style="width: 10%">经营人</td>
								<td style="width: 40%">${realStoreAuth.master }</td>
								<td style="width: 10%">联系电话</td>
								<td style="width: 40%">${realStoreAuth.phone }</td>
							</tr>
						</table>
						<ul>
							<li class="rz_img"><img style="max-width:120px" src="${realStoreAuth.image1 }" /></li>
							<li class="rz_img"><img style="max-width:120px" src="${realStoreAuth.image2 }" /></li>
							<li class="rz_img"><img style="max-width:120px" src="${realStoreAuth.image3 }" /></li>
						</ul>
					</c:if>
				</div>
			</div>
		</div>
	</div>

</body>
</html>