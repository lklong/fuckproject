<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="hyglbox2top">
	<div class="lddd  ml30">
		<!--             <input onclick="allSelect(this)" type="checkbox" id="selectall"/> -->
		<!--             <label class="mr10" for="selectall">全选</label> -->
		<!--             <a href="javascript:void(0)" onclick="batchShipments()">批量发货</a> -->
	</div>
	<div class="clear"></div>
</div>

<div class="hyglbox2 lh30 mt10">
	   <div class="hyglbox2table c666">
        	<table class="sysCommonTable _memOrderList"  border="0" cellspacing="0" cellpadding="0">
             	<thead>
            		<tr>
						<th>订单号</th>
						<th>状态</th>
						<th>商品名称</th>
						<th>单价</th>
						<th>数量</th>
						<th>总价格</th>
						<th>买家名称 </th>
						<th>店铺名称</th>
						<th>下单时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.datas }" var="o" varStatus="ovs">
						<tr>
<!-- 							<td><input id="cbox_${ovs.count }" class="_cbox" type="checkbox" value="${o.ID }" ono="${o.orderNO }" phone="${o.phone }" cg="${o.consignee }" log="${o.logisticsName }" status="${o.status}" ad="${o.address }"/></td> -->
							<td>${o.orderNO }</td>
							<td><p>${o.statusLabel }</p></td>
							
							<td>
								<c:forEach items="${o.details }" var="od" varStatus="vs">
									<c:if test="${vs.index != 0 }">
										<hr style="border:0;background-color:#fff;height:1px;">
									</c:if>
									<span title="${od.goodsName }（${od.propertystrname }）"> ${od.goodsName }（${od.propertystrname }）</span>
								</c:forEach>
							</td>
							<td>
								<c:forEach items="${o.details }" var="od" varStatus="vs">
									<c:if test="${vs.index != 0 }">
										<hr style="border:0;background-color:#fff;height:1px;">
									</c:if>
									${od.unitPrice }
								</c:forEach>
							</td>
							<td>
								<c:forEach items="${o.details }" var="od" varStatus="vs">
									<c:if test="${vs.index != 0 }">
										<hr style="border:0;background-color:#fff;height:1px;">
									</c:if>
									${od.quantity }
								</c:forEach>
							</td>
							<td>
								
								<ul style="line-height:13px;">
									<li><span style="color: red;"><b>${o.totalMoney }</b></span></li>
									<li><span style="color: gray;">(含代发：${o.agentMoney }，物流：${o.logisticsMoney })</span></li>
								</ul>
							</td>
							<td>${o.username }</td>
							<td>${o.storeName }</td>
							<td><fmt:formatDate value="${o.orderTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
							<td style="text-align: left;">
                     				<a href="admin/order/detail?orderID=${o.ID}" class="sysButonA1">
		                        	<em></em>详情
		                        </a>
				            	<!--<c:if test="${o.status == 2 }">
									<button class="fenpeibut" onclick="shipments('cbox_${ovs.count }')">发货 </button>
				            	</c:if>-->
			               </td>
						</tr>
		           	</c:forEach>
				</tbody>
			</table>
				
		</div>
	</div>

<div class="dataPager">
	<div class="ddpage">
		<jsp:include page="../../../include/page.jsp">
			<jsp:param name="request" value="ajax" />
			<jsp:param name="requestForm" value="orderPageForm" />
		</jsp:include>
	</div>
</div>