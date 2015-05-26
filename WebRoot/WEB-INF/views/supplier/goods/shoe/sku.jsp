<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="guigebox fl">
	<c:set value="0" var="pvindex"></c:set>
	<c:forEach items="${properties }" var="p" varStatus="pv">
		<c:if test="${p.sell }">
			<div class="yanse skudiv skudiv${pvindex }" label="${p.name }">
				<div class="title2">
					<strong class="fr">*</strong><p class="fr">${p.name }：</p>
					<div class="clear"></div>
				</div>
				<ul>
					<c:forEach items="${p.values }" var="v" varStatus="vs">
						<li>
							<input type="checkbox" class="yansecheck" index="${vs.index }" name="sku_ck_${pv.index }" value="${v.id }" pid="${p.id }" pname="${p.name }" vid = "${v.id }" vname="${v.name }" />
			                <label class="yansetxt" for="yanse1">${v.name }</label>
			                <input class="yansetext" index="${vs.index }" type="text" value="${v.name }" onkeyup="this.value=this.value.replace(/[-;:]/g,'');cchange(${pvindex },this)" maxlength="5"/>
			                <div class="clear"></div>
			            </li>
					</c:forEach>
				</ul>
				<div class="clear"></div>
			</div>
			<c:set value="${pvindex + 1 }" var="pvindex"></c:set>
   		</c:if>
   	</c:forEach>
</div>
<div class="clear"></div>
