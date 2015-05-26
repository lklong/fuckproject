<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${properties }" var="p" varStatus="pv">
	<c:if test="${!p.sell }">
		<div class="jibenform servicePropertity">
			<!-- 属性名 -->
			<c:choose>
				<c:when test="${p.required }">
					<div class="title">
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
								<input index="${pv.index }" type="checkbox" value="${v.id }" pid="${p.id }" pname="${p.name }" vid="${v.id }" vname="${v.name }"/>${v.name }
							</div>
						</c:forEach>
					</div>
					<div class="clear"></div>
				</c:when>
				<c:when test="${!p.mult && !p.input}">
				 <div class="select_prop">
					<select index="${pv.index }" pid="${p.id }" pname="${p.name }" style="width: 180px;">
						<option value="">请选择</option>
						<c:forEach items="${p.values }" var="v">
							<c:set var="flag" value="0" />
							<c:forEach items="${goods.properties }" var="p">
								<c:if test="${v.id == p.propertyValueId }">
									<option value="${v.id }" selected="selected">${v.name }</option>
									<c:set var="flag" value="1" />
								</c:if>
							</c:forEach>
							<c:if test="${flag == 0 }">
								<option value="${v.id }">${v.name }</option>
							</c:if>
						</c:forEach>
					</select>
					</div>
					<div class="clear"></div>
				</c:when>
				<div id="input_prop_attr">
				<c:when test="${p.input}">
						<input index="${pv.index }" class="can_input" pid="${p.id }" pname="${p.name }"/><em>提示：系统默认为货号加上您的店铺名称，提高检索效率</em>
				</c:when>
				</div>
				<div class="clear"></div>
				
			</c:choose>
		</div>
	</c:if>
</c:forEach>