<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:forEach items="${page.datas }" var="e">
	<div class="pingLunCommandBox">
    	<div class="commandLeft">
        	<a href="javascript:void(0);"><img src="${e.avatar}" height="80" width="80" /></a>
            <p>${e.username }</p>
        </div>
        <div class="commandRight">
        	<div><span><fmt:formatDate value="${e.addTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </span><span style="float: left;">评分：</span><span style="float: left;" class="data-score fl10" data-score="${e.score }"></span></div>
				<div class="mt10">${e.content }</div>
		</div>
	</div>
</c:forEach>

<div class="clear"></div>
<div class="ddpage fr mt20">
	<jsp:include page="../../include/page.jsp">
		<jsp:param name="request" value="ajax"/>
		<jsp:param name="requestForm" value="evaluateForm"/>
	</jsp:include>
</div>