<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>订单列表</title>
<link rel="stylesheet" href="css/default/jcDate.css">
<script type="text/javascript" src="js/jQuery-jcDate.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">订单列表</h4>
  <form action="supplier/order" method="post" id="orderSearchForm">
    <div class="fun-bar">
      <div class="fun-bar-div"> <span class="ml15">订单编号：</span> <span>
        <input class="input-txt" type="text" name="orderNO" value="${oc.orderNO }" />
        </span> <span class="ml15">商品名称：</span> <span>
        <input class="input-txt" type="text" name="commodityName" value="${oc.goodsName }"/>
        </span> <span class="ml15">买家名称：</span> <span>
        <input class="input-txt" type="text" name="username" value="${oc.username }"/>
        </span> </div>
      <div class="fun-bar-div"> <span class="ml15">订单状态：</span> <span>
        <select class="select-txt" name="status" id="status">
          <option value="0">全部</option>
          <option value="1">待付款</option>
          <option value="2">待发货</option>
          <option value="3">待确认收货</option>
          <option value="4">交易成功</option>
          <option value="9">交易关闭</option>
        </select>
        </span> <span class="ml15">订单时间：</span> <span>
        <input class="jcDate input-txt" type="text" id="date1" name="startDateStr" value="<fmt:formatDate value="${oc.startDate }" pattern="yyyy-M-d"/>"/>
        </span> <span class="ml15">到</span> <span>
        <input class="jcDate input-txt" type="text" id="date2" name="endDateStr" value="<fmt:formatDate value="${oc.endDate }" pattern="yyyy-M-d"/>"/>
        </span> <span>
        <input type="submit" class="input-button" value="搜索" />
        </span> </div>
    </div>
  </form>
  <div class="fun-bar">
    <ul class="fun-tabs">
      <li <c:if test="${oc.status == 0 }">dingdanselect</c:if>"><a href="supplier/order?status=0">全部订单</a></li>
      <li <c:if test="${oc.status == 1 }">dingdanselect</c:if>"><a href="supplier/order?status=1">待付款</a></li>
      <li <c:if test="${oc.status == 2 }">dingdanselect</c:if>"><a href="supplier/order?status=2">待发货</a></li>
      <li <c:if test="${oc.status == 3 }">dingdanselect</c:if>"><a href="supplier/order?status=3">待确认</a></li>
      <li <c:if test="${oc.status == 4 }">dingdanselect</c:if>"><a href="supplier/order?status=4">交易完成</a></li>
      <li <c:if test="${oc.status == 9 }">dingdanselect</c:if>"><a href="supplier/order?status=9">交易关闭</a></li>
    </ul>
  </div>
  <div class="select-show-bar">
    <input class="fl mt15 ml20" type="checkbox" id="selectall" />
    <label class="fl ml5" for="selectall">全选</label>
    <input type="checkbox" id="guanbi" class="fl mt15 ml20" />
    <label for="guanbi" class="fl ml5">不显示已关闭的订单</label>
    <span class="fr">
    <jsp:include page="../../include/page-mini.jsp">
    <jsp:param name="request" value="form"/>
    <jsp:param name="requestForm" value="orderSearchForm"/>
    </jsp:include>
    </span> </div>
  <table cellpadding="0" cellspacing="0" class="user-list-table">
    <tr>
      <th>货品</th>
      <th>单价(元)</th>
      <th>数量</th>
      <th>交易状态</th>
      <th>买家</th>
      <th>操作</th>
      <th>实收款(元)</th>
      <th>评价</th>
    </tr>
  </table>
  <c:forEach items="${orders }" var="o">
    <table cellpadding="0" cellspacing="0" class="user-list-table blue-border">
      <tr class="table-head-tr">
        <td colspan="8"><span> <span>
          <input type="checkbox" />
          </span> <span>订单号：${o.orderNO }</span> </span> <span class="fr">下单时间:
          <fmt:formatDate value="${o.orderTime }" pattern="yyyy-MM-dd HH:mm"/>
          </span></td>
      </tr>
      <tr>
        <td style="width:60%"><table cellpadding="0" cellspacing="0" class="user-sublist-table">
            <c:forEach items="${o.details }" var="od">
              <tr>
                <td style="width:65%"><span class="fl"> <a target="_blank" href="goods/detail?goodsId=${od.goodsID}"><img height="50" width="50" src="${od.goodsPic}" /></a> </span> <span class="fl mt10 ml10"> <span class="fl">
                  <p><a target="_blank" href="goods/detail?goodsId=${od.goodsID}">${od.goodsName }</a></p>
                  <p>${od.propertystrname }</p>
                  </span> </span></td>
                <td style="width:10%"><p class="color-red">${od.unitPrice }</p></td>
                <td style="width:10%"><p>${od.quantity }</p></td>
                <td style="width:15%"> ${o.statusLabel } </td>
              </tr>
            </c:forEach>
          </table></td>
        <td style="width:10%"><p><a href="javascript:void(0)">${o.username }</a></p></td>
        <td style="width:10%"><p><a href="supplier/order/detail?orderID=${o.ID}" class="default-a">详情</a></p></td>
        <td style="width:15%"><p class="color-red fwb">
            <fmt:formatNumber value="${o.payableMenoy}" pattern="#0.00"/>
          </p>
          <p>(代发、物流：${o.agentMoney} +${o.logisticsMoney })</p></td>
        <td style="width:5%" title="${o.comment}">${o.comment}</td>
      </tr>
    </table>
  </c:forEach>
  <div class="select-show-bar">
    <div class="ddcaozuo">
      <div class="fl">
        <input class="fl mt15 ml20" type="checkbox" id="selectall" />
        <label class="fl ml5" for="selectall">全选</label>
        <input type="checkbox" id="guanbi2"  class="fl mt15 ml20"/>
        <label class="fl ml5" for="guanbi2">不显示已关闭的订单</label>
      </div>
      <div class="fr">
        <jsp:include page="../../include/page.jsp">
        <jsp:param name="request" value="form"/>
        <jsp:param name="requestForm" value="orderSearchForm"/>
        </jsp:include>
      </div>
    </div>
  </div>
</div>
<div id="blackbg"></div>
<script type="text/javascript">
$(function (){
	$("#status").val("${oc.status}");
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