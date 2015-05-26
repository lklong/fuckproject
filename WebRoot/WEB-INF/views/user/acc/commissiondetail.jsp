<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>推荐奖励明细</title>
</head>
<body>
<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	推荐奖励明细<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">推荐奖励明细</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="body_center2">
			<div class="mingxi">
			</div>
			<div class="mingxitable0 mt10">
				<table class="mingxitable">
					<tr class="mingxitableth">
						<th width="150">用户账户</th>
						<th width="100">提成级别</th>
						<th width="200">提成比例(基础比例x级别比例)</th>
						<th width="200">获得提成金</th>
						<th width="300">记录时间</th>
					</tr>
					<tbody>
					<c:forEach items="${commissionRecords }" var="commissionRecord">
						<tr><td>${commissionRecord.userName }</td>
						<td>${commissionRecord.level }</td>
						<td>
						<c:choose>
							<c:when test="${commissionRecord.level==0 }">
								${commissionRecord.innerEmployeePorportion }% x 100% (公司员工)
							</c:when>
							<c:otherwise>
								${commissionRecord.basePorportion }% x ${commissionRecord.commissionPorportion }%
							</c:otherwise>
						</c:choose>
						</td>
						<td>${commissionRecord.commissionMoney }</td>
						<td><fmt:formatDate value="${commissionRecord.addDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
					</c:forEach>
					</tbody>
				</table>
				
			</div>
			<div class="ddtablefooter mt10">
					<div class="ddpage fr mr20">
						<jsp:include page="../../include/page.jsp">
							<jsp:param name="request" value="url"/>
							<jsp:param name="requestUrl" value="/user/acc/showCommissionRecord"/>
						</jsp:include>
					</div>
				</div>
		</div>
     </div>
            <br style="clear:both;" />
        </div>
    </div>
	<div class="clear"></div>
</body>
</html>