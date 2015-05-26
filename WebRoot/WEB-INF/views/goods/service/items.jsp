<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
	<c:forEach items="${page.datas }" var="g">
			<li>
			<div class="gerenkonjinkka">
				<div class="gerenimgkkka">
					<a href="goods/detail?goodsId=${g.id }"><img src="${g.image300}" style="max-width:214px;max-height: 214px; "/></a>
				</div>
			</div>
			<div class="gerenkonInfo">
				<div class="c000 f14 fwbold mt10"><a href="goods/detail?goodsId=${g.id }">${g.name }</a></div>
				<div class="mt5 f12">
				单价：<font color="#ff4400" size="2">￥<strong>${g.minPrice }</strong></font>
				</div>
			</div>
			</li>
		
	</c:forEach>
</ul>

<div class="clear"></div>
<div style="width:600px; margin:0 auto;">
	<div class="ddpage mt20">
		<jsp:include page="../../include/page.jsp">
			<jsp:param name="request" value="ajax"/>
			<jsp:param name="requestForm" value="goodsForm"/>
		</jsp:include>
	</div>
</div>
<div class="clear"></div>