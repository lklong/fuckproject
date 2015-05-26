<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>

<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	卖家订单<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">卖家订单</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="body_center2"  id="alldd">
<!-----------------------------------------------订单时间---------------------------------------------------->
		<div class="dingdanxinxi mt10 f12 pt10">
			<form action="supplier/order" method="post" id="orderSearchForm">
				<div class="dingdanxinxi1 pl20">
					<div class="dingdanhao2">
						<p class="fl">订单编号：</p>
						<input class="fl" type="text" name="orderNO" value="${oc.orderNO }" />
						<div class="clear"></div>	
					</div>
					<div class="dingdanhao2">
						<p class="fl">商品名称：</p>
						<input class="fl" type="text" name="commodityName" value="${oc.goodsName }"/>
						<div class="clear"></div>
					</div>
					<div class="dingdanhao2">
						<p class="fl">买家名称：</p>
						<input class="fl" type="text" name="username" value="${oc.username }"/>
						<div class="clear"></div>	
					</div>
					<div class="dingdanhao2">
						<p class="fl">订单状态：</p>
						<select class="fl" name="status" id="status">
							<option value="0">全部</option>
							<option value="1">待付款</option>
							<option value="2">待发货</option>
							<option value="3">待确认收货</option>
							<option value="4">交易成功</option>
							<option value="9">交易关闭</option>
						</select>
						<div class="clear"></div>	
					</div>
					<!-- <div class="dingdanhao2">
						<p class="fl">评价状态：</p>
						<select>
							<option>全部</option>
							<option>需我评价</option>
							<option>我已评价</option>
							<option>对方已评</option>
							<option>双方已评</option>
						</select>
						<div class="clear"></div>	
					</div>
					<div class="dingdanhao2">
						<p class="fl">物流服务：</p>
						<select>
							<option>全部</option>
							<option>货到付款</option>
						</select>
						<div class="clear"></div>	
					</div>
					<div class="dingdanhao2">
						<p class="fl">售后服务：</p>
						<select>
							<option>全部</option>
							<option>买家投诉</option>
							<option>我已投诉</option>
							<option>退款中</option>
						</select>
						<div class="clear"></div>	
					</div> -->
					<div class="dingdanhao0 fl">
					   <p class="fl">订单时间：</p>
					   <input class="jcDate fl mr10" type="text" id="date1" name="startDateStr" value="<fmt:formatDate value="${oc.startDate }" pattern="yyyy-M-d"/>"/>
					   <span>到</span> 
					   <input class="jcDate fl ml10" type="text" id="date2" name="endDateStr" value="<fmt:formatDate value="${oc.endDate }" pattern="yyyy-M-d"/>"/>
					   <div class="clear"></div>
				   </div>
					<div class="clear"></div>
				</div>
				<div class="search0 mt10">
					<input type="submit" class="cp" value="搜索" />
					<!-- <input type="button" value="批量导出" /> -->
				</div>
			</form>
		</div> 
<!-----------------------------------------------订单状态---------------------------------------------------->
		<div class="jinsan f12 lh25 pl20 mt10">
			<ul>
				<li class="fl <c:if test="${oc.status == 0 }">dingdanselect</c:if>"><a href="supplier/order?status=0">全部订单</a></li>
				<li class="fl <c:if test="${oc.status == 1 }">dingdanselect</c:if>"><a href="supplier/order?status=1">待付款</a></li>
				<li class="fl <c:if test="${oc.status == 2 }">dingdanselect</c:if>"><a href="supplier/order?status=2">待发货</a></li>
				<li class="fl <c:if test="${oc.status == 3 }">dingdanselect</c:if>"><a href="supplier/order?status=3">待确认</a></li>
				<!-- <li class="fl"><a href="#">退款中</a></li>
				<li class="fl"><a href="#">需要评价</a></li> -->
				<li class="fl <c:if test="${oc.status == 4 }">dingdanselect</c:if>"><a href="supplier/order?status=4">交易完成</a></li>
				<li class="fl <c:if test="${oc.status == 9 }">dingdanselect</c:if>"><a href="supplier/order?status=9">交易关闭</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<div class="zhuantaitable">
<!-----------------------------------------------table标题---------------------------------------------------->
			<table class="ddtableth c999">
				<tr>
					<th width="300">货品</th>
					<th width="60">单价(元)</th>
					<th width="50">数量</th>
					<th width="100">交易状态</th>
					<th width="140">买家</th>
					<th width="100">操作</th>
					<th width="150">实收款(元)</th>
					<th width="100">评价</th>
				</tr>
			</table>
<!-----------------------------------------------订单操作---------------------------------------------------->
			<div class="ddcaozuo mb10">
				<div class="yimaicaozuol fl">
					<input class="fl ml20 mr5" type="checkbox" id="selectall" />
					<label class="fl mr10" for="selectall">全选</label>
				   
<!-- 					<input type="checkbox" id="guanbi" class="ver_ali" /> -->
<!-- 					<label for="guanbi" class="c666">不显示已关闭的订单</label> -->
				</div>
				<div class="yimaicaozuor fr mr20">
			   		<jsp:include page="../../include/page-mini.jsp">
						<jsp:param name="request" value="form"/>
						<jsp:param name="requestForm" value="orderSearchForm"/>
					</jsp:include>
				</div>
				<div class="clear"></div>
			</div>
<!-----------------------------------------------多个商品---------------------------------------------------->
			<c:forEach items="${orders }" var="o">
				<table class="yimaichutable lh20">
					 <tr class="yimaichutabletop lh35">
						<td colspan="8">
							<div class="yimaichu fl ml10 c666">
								<input type="checkbox" />
								<span>订单号：${o.orderNO }</span>
							</div>
							<div class="chengjiaotime0 fl ml20 c666">
								<span>下单时间:<fmt:formatDate value="${o.orderTime }" pattern="yyyy-MM-dd HH:mm"/> </span>
							</div>
							<div class="clear"></div>
						</td>
					</tr>
					<tr class="yimaichucenter">
						<td>
							<table class="yimaichuduotable">
								<c:forEach items="${o.details }" var="od">
									<tr>
										<td width="300">
											<div class="ddcenterimg fl ml10 mt10">
												<a target="_blank" href="goods/detail?goodsId=${od.goodsID}"><img src="${od.goodsPic}" /></a>
											</div>
											<div class="yimaichumiaoshu fl ml10 mt10 lh20">
												<a target="_blank" href="goods/detail?goodsId=${od.goodsID}">${od.goodsName }</a>
												<div class="yscm c999">
													${od.propertystrname }
												</div>
											</div>
											<div class="clear"></div>
										</td>
										<td width="60" class="tc">
											<p class="fwbold c999">${od.unitPrice }</p>
										</td>
										<td width="50" class="tc">
											<p class="c999">${od.quantity }</p>
										</td>
										<td  width="100" class="tc">
											${o.statusLabel }
										</td>
									</tr>
								</c:forEach>
							</table>
						</td>
						<td width="140" class="maijiaxinxi tc" >
							<p class="mt10"><a href="javascript:void(0)">${o.username }</a></p>
						</td>
						<td width="100" class="tc c999">
							<p><a href="supplier/order/detail?orderID=${o.ID}">详情</a></p>
						</td>	
						<td width="150" class="tc">
							<p class="fwbold c666"><fmt:formatNumber value="${o.payableMenoy}" pattern="#0.00"/> </p>
							<p class="c999">(代发、物流：${o.agentMoney} +${o.logisticsMoney })</p>
						</td>
						<td  class="ellipsis tc" style="width: 100px;" title="${o.comment}">${o.comment}</td>
					</tr>
				</table>
			</c:forEach>
			<div class="ddtablefooter mt10">
				<div class="ddcaozuo">
					<div class="yimaicaozuol">
						<input class="fl ml20 mr5" type="checkbox" id="selectall" />
						<label class="fl mr10" for="selectall">全选</label>
					   
<!-- 						<input type="checkbox" id="guanbi2"  class="ver_ali"/> -->
<!-- 						<label for="guanbi2">不显示已关闭的订单</label> -->
					</div>
					<div class="ddpage fr mr20">
						<jsp:include page="../../include/page.jsp">
							<jsp:param name="request" value="form"/>
							<jsp:param name="requestForm" value="orderSearchForm"/>
						</jsp:include>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div> 
	<div id="blackbg"></div>
	</div>
     </div>
            <br style="clear:both;" />
        </div>
    </div>
	<div class="clear"></div>
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