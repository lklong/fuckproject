<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" >
<link href="css/jcDate.css" rel="stylesheet" type="text/css" media="all" />
<script src="/js/3rdparty/layer/extend/layer.ext.js" type="text/javascript"></script>
<title>订单列表</title>
</head>
<body>
<h3 class="sysIndH3">订单概况</h3>
<table cellpadding="0" cellspacing="0" class="sysCommonTable">
	<tr>
		<th>共订单</th>
		<th>待付款</th>
		<th>待发货</th>
		<th>待确认收货</th>
		<th>交易完成</th>
		<th>交易关闭</th>
	</tr>
	<tr>
		<td>${stat.sum }</td>
		<td>${stat.waitPay }</td>
		<td>${stat.waitSend }</td>
		<td>${stat.waitConfirm }</td>
		<td>${stat.success }</td>
		<td>${stat.cancel }</td>
	</tr>
</table>
<h3 class="sysIndH3">交易总计</h3>
<table cellpadding="0" cellspacing="0" class="sysCommonTable">
	<tr>
		<th>商品价格总计</th>
		<th>代发费用总计</th>
		<th>物流费用总计</th>
		<th>完成订单商品价格总计</th>
		<th>完成订单代发费用总计</th>
		<th>完成订单物流费用总计</th>
	</tr>
	<tr>
		<td>${stat.money }</td>
		<td>${stat.agentMoney }</td>
		<td>${stat.logisticsMoney }</td>
		<td>${stat.money4 }</td>
		<td>${stat.agentMoney4 }</td>
		<td>${stat.logisticsMoney4 }</td>
	</tr>
</table>
<!-- //功能条// -->
<form method="post" action="admin/order/index" id="orderSearchForm">
<div class="sysContBar">
	<div class="sysCBBox">
		<div>订单状态</div>
		<div>
			<select class="sysComSelect" name="status" id="status">
				<option value="0">全部</option>
				<option value="1">待付款</option>
				<option value="2">待发货</option>
				<option value="3">待确认收货</option>
				<option value="4">交易成功</option>
				<option value="9">交易关闭</option>
			</select>
		</div>
		<div>订单号：</div>
		<div><input class="sysCommonInput" type="text" name="orderNO" value="${oc.orderNO }"/></div>
		<div>店铺名：</div>
		<div><input class="sysCommonInput" type="text" name="storeName" value="${oc.storeName }"/></div>
		<div>商品名称：</div>
		<div><input class="sysCommonInput" type="text" name="commodityName" value="${oc.goodsName }"/></div>
		<div>买家名称：</div>
		<div><input class="sysCommonInput" type="text" /></div>
		<div>成交时间：</div>
		<div><input class="jcDate sysCommonInput" type="text" id="date1" name="startDate" readonly="readonly" value="<fmt:formatDate value="${oc.startDate }" pattern="yyyy-MM-dd"/>" /></div>
		<div>-</div>
		<div><input class="jcDate sysCommonInput" type="text" id="date2" name="endDate" readonly="readonly" value="<fmt:formatDate value="${oc.endDate }" pattern="yyyy-MM-dd"/>" /></div>
		<div><input class="sysSubmit" type="submit" value="查找" /></div>
	</div>
</div>
</form>

<table class="sysCommonTable _memOrderList" cellspacing="0" cellpadding="0">
   	<thead>
   		<tr>
           	<th><input onclick="allSelect(this)" type="checkbox" id="selectall"  /></th>
			<th>订单号</th>
			<th>商品名称</th>
			<th>单价</th>
			<th>数量</th>
			<th>总价格</th>
			<th>买家名称 </th>
			<th>店铺名称</th>
			<th>下单时间</th>
			<th>状态</th>
			<th>操作</th>
			<th>备注</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${orders }" var="o" varStatus="ovs">
			<tr >
				<td><input type="checkbox" id="cbox_${ovs.count }" class="_cbox" type="checkbox" value="${o.ID }" ono="${o.orderNO }" phone="${o.phone }" cg="${o.consignee }" log="${o.logisticsName }" status="${o.status}" ad="${o.address }"/></td>
				<td>${o.orderNO }</td>
				<td>
					<c:forEach items="${o.details }" var="od" varStatus="vs">
						<c:if test="${vs.index != 0 }">
							<hr style="border:0;background-color:#dedede;height:1px;">
						</c:if>
						<span title="${od.goodsName }"> ${od.goodsName }</span>
					</c:forEach>
				</td>
				<td>
					<c:forEach items="${o.details }" var="od" varStatus="vs">
						<c:if test="${vs.index != 0 }">
							<hr style="border:0;background-color:#dedede;height:1px;">
						</c:if>
						<fmt:formatNumber pattern="#0.00" value="${od.unitPrice}"/>
					</c:forEach>
				</td>
				<td>
					<c:forEach items="${o.details }" var="od" varStatus="vs">
						<c:if test="${vs.index != 0 }">
							<hr style="border:0;background-color:#dedede;height:1px;">
						</c:if>
						${od.quantity }
					</c:forEach>
				</td>
				<td>
					
					<ul style="line-height:13px;">
						<li><span style="color: red;"><b><fmt:formatNumber pattern="#0.00" value="${o.payableMenoy }"/></b></span></li>
						<li>
							<span style="color: gray;">(含代发：${o.agentMoney }，物流：${o.logisticsMoney })</span>
						</li>
					</ul>
				</td>
				<td>${o.username }</td>
				<td>${o.storeName }</td>
				<td><fmt:formatDate value="${o.orderTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
				<td><p>${o.statusLabel }</p></td>
				<td style="text-align: left;">
                  				<a href="admin/order/detail?orderID=${o.ID}" class="sysButonA1"><em></em>详情</a>
	            	<c:if test="${o.status == 2 }">
						<a href="javascript:void(0);" class="sysButonA3" onclick="shipments('cbox_${ovs.count }',${o.ID })"><em></em>发货 </a>
	            	</c:if>
	            	<c:if test="${o.status == 1 }">
						<a href="javascript:void(0);" class="sysButonA3" onclick="modifyMoney(${o.ID},${o.logisticsMoney })"><em></em>改价</a>
					</c:if>
               </td>
               <td title="${o.comment }" ><div style="width:80px !important;height:30px" class="ellipsis">${o.comment }</div></td>
			</tr>
       	</c:forEach>
	</tbody>
</table>
<div class="dataPager">
	<div class="ddpage">
			<jsp:include page="../../include/page.jsp">
				<jsp:param name="request" value="form"/>
				<jsp:param name="requestForm" value="orderSearchForm"/>
			</jsp:include>
	</div>
</div>
<script type="text/javascript" language="javascript" src="js/3rdparty/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/jQuery-jcDate.js"></script>
<script type="text/javascript" src="js/admin/shipments.js"></script>
<script type="text/javascript">
$(function(){
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
	// 所有订单、个人所辖订单都使用此页面
	$("#orderSearchForm").prop("action",window.location.href.replace(/\?.*$/, ''));
});

//修改物流价格事件
//<zy> 改_1
//2014-12-26 16:07
function modifyMoney(oid,omoney){
	
	layer.prompt({title: '请输入订单金额（含物流、代发费）：'}, function(val){
		_price(val);
	});
	
	function _price(val){
		if(val != null && !zhigu.cmn.moneyReg(val)){
			layer.msg('请填写正确的价格！', 2, 3);
			return;
		}
		ajaxSubmit("/admin/order/modifyMoney", "oid="+oid+"&money="+val, function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg, 1, f5);
			}else{
				layer.alert(msgBean.msg);
			}
		}, "json");
	};
}
</script>
</body>
</html>