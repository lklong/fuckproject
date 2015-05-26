<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<p class="shuxingtishi">填错宝贝属性，可能会引起宝贝下架，影响您的正常销售。请认真准确填写！</p>
<c:forEach items="${properties }" var="p" varStatus="pv">
	<c:if test="${!p.sell }">
		<div class="shuxingtxt">
			<!-- 属性名 -->
			<c:choose>
				<c:when test="${p.required }">
					<div class="shuxingtitle">
		                <strong>*</strong><p id="property_${pv.index }" requ="true">${p.name }：</p>
		                <div class="clear"></div>
		            </div>
				</c:when>
				<c:otherwise>
					<p class="shuxingtitle" id="property_${pv.index }" requ="false">${p.name }：</p>
				</c:otherwise>
			</c:choose>
			
			<!-- 属性值 -->
			<c:choose>
				<c:when test="${p.mult }">
					<div class="liuxingbox fl checkboxpro" requ="${p.required }">
						<c:forEach items="${p.values }" var="v">
							<div class="liuxing">
								<input index="${pv.index }" key="${p.id }:${v.id }" type="checkbox" value="${v.id }" pid="${p.id }" pname="${p.name }" vid="${v.id }" vname="${v.name }"/>${v.name }
							</div>
						</c:forEach>
					</div>
					<div class="clear"></div>
				</c:when>
				<c:when test="${!p.mult && !p.input}">
					<select index="${pv.index }" pid="${p.id }" pname="${p.name }">
						<option value="">请选择</option>
						<c:forEach items="${p.values }" var="v">
							<option key="${p.id }:${v.id }" value="${v.id }">${v.name }</option>
						</c:forEach>
					</select>
					<div class="clear"></div>
				</c:when>
				<c:when test="${p.input}">
					<input index="${pv.index }" class="only_input" pid="${p.id }" pname="${p.name }"/><!-- <em>提示：系统默认为货号加上您的店铺名称，提高检索效率</em> -->
					<div class="clear"></div>
				</c:when>
			</c:choose>
		</div>
	</c:if>
</c:forEach>