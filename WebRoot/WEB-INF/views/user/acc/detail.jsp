<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>收支明细</title>
<link rel="stylesheet" type="text/css" href="css/default/jcDate.css" media="all" />
<script type="text/javascript" src="js/jQuery-jcDate.js"></script>
<script type="text/javascript">
	function _submit(v){
		if(v == 0)
			$("#month").val("");
		$("#accDetailForm").submit();
	}
</script>
</head>
<body>
<div class="rightContainer fr">
    	<h4 class="ddtitle">收支明细</h4>
		<div class="rc_body">
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="body_center2">			
			<div class="mingxi">

					<table cellpadding="0" cellspacing="0" class="user-form-table">
						<tr>
							<td style="width:10%">账户名：</td>
							<td style="width:90%"><span class="fz14 fwb">${userName}</span></td>
						</tr>
						<tr>
							<td>账户金额：</td>
							<td><span class="fz14 fwb color-red">${acc.normalMoney+acc.freezeMoney}</span> 元</td>
						</tr>
						<tr>
							<td>可用金额：</td>
							<td><span class="fz14 fwb color-red">${acc.normalMoney}</span> 元</td>
						</tr>
						<tr>
							<td>冻结金额：</td>
							<td><span class="fz14 fwb color-red">${acc.freezeMoney}</span> 元</td>
						</tr>
					</table>
					<div class="fun-bar">
					<form class="" method="post" id="accDetailForm" action="user/acc/detail">
						<select class="select-txt fl" name="month" id="month" onchange="_submit(1)">
							<option value="">全部</option>
							<option value="1" <c:if test="${month == 1}">selected="selected"</c:if> >最近一个月</option>
							<option value="3" <c:if test="${month == 3}">selected="selected"</c:if> >最近三个月</option>
							<option value="6" <c:if test="${month == 6}">selected="selected"</c:if> >最近半年</option>
						</select>
						<span class="fl ml20">从</span><input type="text" class="jcDate input-txt jcDateIco fl ml20" name="startDate"  value="<fmt:formatDate value='${startDate }' pattern='yyyy-M-d'/>"/>
						<span class="fl ml20">到</span>
						<input type="text" class="jcDate input-txt jcDateIco fl ml20"  name="endDate" value="<fmt:formatDate value='${endDate }' pattern='yyyy-M-d'/>"/>
						<input class="input-button ml20" type="button" onclick="_submit(0)" value="查询" />
						<!-- <input class="mingxibut cp" type="button" value="导出" /> -->
					</form>
					</div>
			</div>
			<div class="mingxitable0 mt10">
				<table cellpadding="0" cellspacing="0" class="user-list-table">
					<tr>
						<th>流水号</th>
						<th>创建时间</th>
						<th>说明</th>
						<th>收入（元）</th>
						<th style="border-right:none;">支出（元）</th>
					</tr>
					<c:forEach var="detail" items="${list}">
					 <tr>
						<td>${detail.sno}</td>
						 <td><fmt:formatDate value="${detail.dealTime}"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" /> </td>
						<td>${detail.dealMatter}</td>
						<td>
							<c:if test="${detail.incomeFlag}">
								+${detail.dealMoney}
							</c:if>
						</td>
						<td>
							<c:if test="${!detail.incomeFlag}">
								-${detail.dealMoney}
							</c:if>
						</td>
					  </tr>
					</c:forEach>
				</table>
				
			</div>
			<div class="ddtablefooter mt10">
					<div class="ddpage fr mr20">
						<jsp:include page="../../include/page.jsp">
							<jsp:param name="request" value="form"/>
							<jsp:param name="requestForm" value="accDetailForm"/>
						</jsp:include>
					</div>
				</div>
		</div>
            	
     </div>
            <br style="clear:both;" />
        </div>
    </div>

 
		<div class="clear"></div>

<script type="text/javascript">
$(function (){
	$("input.jcDate").jcDate({	
		IcoClass : "jcDateIco",
		Event : "click",
		Speed : 100,
		Left : 0,
		Top : 28,
		format : "-",
		Timeout : 100
	});
});	 

</script>
</body>
</html>