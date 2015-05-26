<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收支明细</title>
<link rel="stylesheet" type="text/css" href="css/jcDate.css" media="all" />
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
<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	收支明细<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">收支明细</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="body_center2">			
			<div class="mingxi">
				<div class="mingxiheader mt10 ml10">
					<div class="mingxiheader">
						<div class="mingxiheader2 fl mt10">
							<p>账户名：${userName}</p>
							<p>账户金额：<strong class="zhanghu1">${acc.normalMoney+acc.freezeMoney}</strong> 元</p>
							<p>可用金额：<strong class="zhanghu1">${acc.normalMoney}</strong> 元</p>
							<p>冻结金额：<strong class="zhanghu1">${acc.freezeMoney}</strong> 元</p>
							<div class="clear"></div>
						</div> 
						<div class="clear"></div>
					</div> 
					<form class="mingxiform mt10" method="post" id="accDetailForm" action="user/acc/detail">
						<select class="fl" style="border:1px solid #666;height:27px;margin-left: 0px;margin-bottom: 5px;width: 127px;" name="month" id="month" onchange="_submit(1)">
							<option value="">全部</option>
							<option value="1" <c:if test="${month == 1}">selected="selected"</c:if> >最近一个月</option>
							<option value="3" <c:if test="${month == 3}">selected="selected"</c:if> >最近三个月</option>
							<option value="6" <c:if test="${month == 6}">selected="selected"</c:if> >最近半年</option>
						</select>
						<div class="clear"></div>
						<input type="text" class="jcDate fl mr10 jcDateIco" style="border:1px solid #666;line-height:27px;margin-left: 0px;" name="startDate"  value="<fmt:formatDate value='${startDate }' pattern='yyyy-M-d'/>"/>
						 
						<span class="fl">~</span>
						<input type="text" class="jcDate fl mr10 jcDateIco" style="border:1px solid #666;line-height:27px;" name="endDate" value="<fmt:formatDate value='${endDate }' pattern='yyyy-M-d'/>"/>
						<input class="mingxibut cp" type="button" onclick="_submit(0)" value="查询" />
						<!-- <input class="mingxibut cp" type="button" value="导出" /> -->
						<div class="clear"></div>
					</form>
					<div class="clear"></div>
				</div>
			</div>
			<div class="mingxitable0 mt10">
				<table class="mingxitable">
					<tr class="mingxitableth">
						<th width="200">流水号</th>
						<th width="150">创建时间</th>
						<th width="300">说明</th>
						<th width="100">收入（元）</th>
						<th width="100">支出（元）</th>
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