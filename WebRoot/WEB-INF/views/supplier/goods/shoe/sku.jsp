<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sku-box-bg">
	<c:set value="0" var="pvindex"></c:set>
	<c:forEach items="${properties }" var="p" varStatus="pv">
		<c:if test="${p.sell }">
			<div class="yanse-sku-div skudiv${pvindex }" label="${p.name }">
				<div class="title2">
					<strong class="color-red"> * </strong>${p.name }：
				</div>
				<ul class="yanse-sku-ul">
					<c:forEach items="${p.values }" var="v" varStatus="vs">
						<li>
							<input type="checkbox" class="yansecheck fl mt5" index="${vs.index }" name="sku_ck_${pv.index }" value="${v.id }" pid="${p.id }" pname="${p.name }" vid = "${v.id }" vname="${v.name }" />
			                <label class="yansetxt fl ml10 mt3" for="yanse1">${v.name }</label>
			                <input class="yansetext fl ml10" index="${vs.index }" type="text" value="${v.name }" onkeyup="this.value=this.value.replace(/[-;:]/g,'');cchange(${pvindex },this)" maxlength="5"/>
			            </li>
					</c:forEach>
				</ul>
			</div>
			<c:set value="${pvindex + 1 }" var="pvindex"></c:set>
   		</c:if>
   	</c:forEach>
   	<br style="clear:both" />
</div>
