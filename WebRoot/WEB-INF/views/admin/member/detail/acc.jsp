<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="tableActBar">
	<div class="fl">账户金额： <span><font color="#ff1100" size="+1">${acc.normalMoney + acc.freezeMoney }</font> </span>元 &nbsp;&nbsp;&nbsp;&nbsp;</div>  
	<div class="ml20 fl">可用金额：<span><font color="#ff4400" size="+1">${acc.normalMoney } </font></span>元&nbsp;&nbsp;&nbsp;&nbsp;</div> 
	<div class="ml20 fl">冻结金额：<span><font color="#ff4400" size="+1">${acc.freezeMoney } </font></span>元&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>

<div class="sysIndH3">收支详情</div>

	<table class="sysCommonTable" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <th>流水号</th>
	        <th>创建时间</th>
	        <th>说明</th>
	        <th>收入（元）</th>
	        <th>支出（元）</th>
	    </tr>
	    <c:forEach items="${page.datas }" var="detail">
		    <tr>
              	<td>${detail.serialNO}</td>
              	 <td><fmt:formatDate value="${detail.dealTime}"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" /> </td>
                  <td>${detail.dealMatter}</td>
                  <td>
                  	<c:if test="${detail.type==1}">
                  		+${detail.dealMoney}
                  	</c:if>
                  </td>
                  <td>
                  	<c:if test="${detail.type==0}">
                  		-${detail.dealMoney}
                  	</c:if>
                  </td>
                </tr>
	    </c:forEach>
	</table>
	<c:if test="${fn:length(page.datas) == 0 }">
		<p class="zanwu">暂无交易记录!</p>
	</c:if>
	
<div class="dataPager">
	<div class="ddpage" style="float: none;">
		<jsp:include page="../../../include/page.jsp">
			<jsp:param name="request" value="ajax"/>
			<jsp:param name="requestForm" value="accPageForm"/>
		</jsp:include>
	</div>
</div>
