<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/jcDate.css" rel="stylesheet" type="text/css" media="all" />
<link href="js/3rdparty/raty-2.7.0/jquery.raty.css" rel="stylesheet" type="text/css" >
<title>买家订单</title>
</head>
<body>
<div class="rightContainer">
		<!--// 标题 //-->
		<h3 class="rc_title">
			买家订单<a href="user/home">我的主页</a>
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<!--// tab切换条 //-->
			<div id="userCommTab" class="userCommTab">
				<ul>
					<li><a href="javascript:void(0);" class="uctSelected">买家订单</a></li>
				</ul>
			</div>
			<div id="userContents" class="userContents">
				<!--// 内容1 //-->
				<div class="body_center2" id="alldd">
		<!-----------------------------------------------订单时间---------------------------------------------------->
		<!-- <div class="jinsan f12 lh25 pl20">
			<ul>
				<li class="dingdanselect fl mr5"><a href="#">近三个月订单</a></li>
				<li class="fl"><a href="#">三个月前订单</a></li>
			</ul>
			<div class="clear"></div>
		</div> -->
		<div class="dingdanxinxi mt10 f12 pt10">
			<form action="/user/order"  id="orderSearchForm">
				<div class="dingdanxinxi1">
					<div class="dingdanhao fl ml30">
						<p class="fl">订单号：</p>
						<input class="fl" type="text" name="orderNO" value="${oc.orderNO }"/>
						<div class="clear"></div>
					</div>
					<div class="dingdanhao fl">
						<p class="fl">货品名称：</p>
						<input class="fl" type="text" name="goodsName" value="${oc.goodsName }"/>
						<div class="clear"></div>
					</div>
					<div class="dingdanhao fl">
						<p class="fl">店铺名：</p>
						<input class="fl" type="text" name="storeName" value="${oc.storeName }"/>
						<div class="clear"></div>
					</div>
					<div class="dingdanhao fl">
						<p class="fl">交易状态：</p>
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
					<div class="clear"></div>
				</div>
				<div class="dingdanxinxi2 mt10 pl20 lh30">
					<div class="dingdanhao fl">
						<p class="fl">成交时间：</p>
						<input class="jcDate fl mr10" type="text" id="date1" name="startDateStr" value="<fmt:formatDate value="${oc.startDate }" pattern="yyyy-M-d"/>"/>
						<div class="guodu fl fwryh">~</div>
						<input class="jcDate fl ml10" type="text" id="date2" name="endDateStr" value="<fmt:formatDate value="${oc.endDate }" pattern="yyyy-M-d"/>"/>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
				<div class="dingdansearch mt10">
					<input type="hidden"  id="pageNo" name="pageNo"/>
					<input type="button" value="搜索"  onclick="zhigu.orderSearch();"/>
				</div>
			</form>
		</div>
		<!-----------------------------------------------订单状态---------------------------------------------------->
		<div class="zhuangtai1 pl20 mt10">
			<ul>
				<li class="c999 mt10">订单状态：</li>
				<li <c:if test="${empty oc.status || oc.status == 0 }">class="zhuangtaiselect"</c:if>><a href="javascript:status(0)">全部</a></li>
				<li <c:if test="${oc.status == 1 }">class="zhuangtaiselect"</c:if>><a href="javascript:status(1)">待付款</a></li>
				<li <c:if test="${oc.status == 2 }">class="zhuangtaiselect"</c:if>><a href="javascript:status(2)">待发货</a></li>
				<li <c:if test="${oc.status == 3 }">class="zhuangtaiselect"</c:if>><a href="javascript:status(3)">待确认收货</a></li>
<!-- 				<li><a href="javascript:status(1)">等待评价</a></li> -->
				<li <c:if test="${oc.status == 4 }">class="zhuangtaiselect"</c:if>><a href="javascript:status(4)">交易完成</a></li>
				<li <c:if test="${oc.status == 9 }">class="zhuangtaiselect"</c:if>><a href="javascript:status(9)">交易关闭</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<div class="zhuantaitable">
			<!-----------------------------------------------table标题---------------------------------------------------->
			<table class="ddtableth c999">
				<tr>
					<th width="400">货品</th>
					<th width="100">单价(元)</th>
					<th width="60">数量</th>
					<th width="40">评价</th>
					<th width="100">总金额(元)</th>
					<th width="100">订单状态</th>
					<th width="200">交易操作</th>
				</tr>
			</table>
			<div class="clear"></div>
		</div>
		<!-----------------------------------------------订单---------------------------------------------------->
		<c:set var="countDownIndex" value="0"/>
		<c:forEach items="${orders }" var="o">
			<table class="ddtable0 lh20">
				<tr class="ddtabletop lh35">
					<td colspan="7">
						<div class="dingdantopl fl ml10 c999">
							<input type="checkbox" class="_cbox" value="${o.ID }" data-orderno="${o.orderNO }" status="${o.status }"/> <span>订单号：${o.orderNO }</span> <span>|</span>
							<span>店铺：</span> 
									<a href="store/index?storeId=${o.storeID}" target="_blank">${o.storeName }</a> 
							<span>|</span>
							 <c:if test="${not empty o.QQ }">
							  	<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${o.QQ }&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${o.QQ}:52" alt="点这里给我发消息" /></a>
							 </c:if>
							 <c:if test="${not empty o.aliWangWang }">
							  	<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${o.aliWangWang}&site=cntaobao&s=2&charset=utf-8" ><img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid=${o.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a>
							 </c:if>
						</div>
						<div class="dingdantopr fr mr10 c999">
							<span>下单时间：</span> <span><fmt:formatDate value="${o.orderTime }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
						</div>
						<div class="clear"></div>
					</td>
				</tr>
				<tr class="ddcenter">
					<td>
						<table class="duotable" style="border-right: 1px solid #DDDDDD;">
							<c:forEach items="${o.details }" var="od">
								<tr>
									<td width="400">
										<div class="ddcenterimg fl ml10 mt10">
												<a href="goods/detail?goodsId=${od.goodsID}" target="_blank"><img src="${od.goodsPic}" /></a>
										</div>
										<div class="ddimgmiaoshu fl ml10 mt10 lh20">
											<a href="goods/detail?goodsId=${od.goodsID}" target="_blank">${od.goodsName }</a>
										</div>
										<div class="clear"></div>
									</td>
									<td width="100" class="tc fwbold c999"><fmt:formatNumber value="${od.unitPrice }" pattern="#0.00"/> </td>
									<td width="60" class="tc">
										<p class="c999">${od.quantity }</p>
									</td>
								</tr>
							</c:forEach>
						</table>
					</td>
					<%-- <td width="40"><c:if test="${o.status ==4 }"><a class="add_comment" href="/goods/comment/${o.ID}">添加评论</a></c:if></td> --%>
					<td width="60" class="tc_padding"><c:if test="${o.status ==4 }"><a class="add_comment" href="/user/order/goods/comment/${o.ID}">添加评论</a></c:if></td>
					<td width="100" class="tc">
						<strong class="cff5200">
							<fmt:formatNumber value="${o.payableMenoy}" pattern="#0.00"/>
						</strong>
						
						<c:if test="${o.agentMoney>0}"><p class="c999">(代发：<fmt:formatNumber value="${o.agentMoney + 0}" pattern="#0.00"/>)</p></c:if>
						<c:if test="${o.logisticsMoney>0}"><p class="c999">(运费：<fmt:formatNumber value="${o.logisticsMoney + 0}" pattern="#0.00"/>)</p></c:if>
						<!-- <p class="c999">
							共<span>1</span>款<span>1</span>件
						</p> -->
					</td>
					<td width="100" class="tc">
						<p class="c333 fwbold">${o.statusLabel }</p>
						<c:if test="${o.status ==3 }">
							<div id="ckwl" oid="${o.ID }" load="false" >
								<div><a href="javascript:void(0);" >查看物流</a></div>
								 <div class="wldt f12 c333 disnone" id="ckwlnr">
									<div class="clear"></div>  
									<div class="wldtl lh30  pr10 pl10">
										<ul>
											<li class="fl"><span>物流公司：${o.logisticsName }</span></li>
											<li class="fl ml10"><span>运单号码：${o.logisticsNO }</span></li>
										</ul>
										<div class="clear"></div>
									</div>
									<div class="wldtr">
									  
										<div class="wldttalbe  pl10">
											<img alt="" src="img/loading.gif">
										</div>
									</div>
									<div class="clear"></div>
								</div>	
								</div>
						</c:if>
					</td>
					<td width="180" class="caozuol tc c999">
						<c:choose>
							<c:when test="${o.status == 1 }">
								<p>离订单失效还有:</p>
								<p data-orderno="${o.orderNO }" class='countDown countDown${countDownIndex }' time="<fmt:formatDate value='${o.orderTime }' pattern='yyyy,MM,dd,HH,mm,ss'/>"></p>
								<c:set var="countDownIndex" value="${countDownIndex + 1 }"></c:set>
								
								<p><a href="javascript:void(0)" onclick="orderPayment('${o.orderNO}')">立即付款</a></p>	
								<p><a href="javascript:void(0)" onclick="cancel('${o.orderNO}')">取消订单</a></p>	
							</c:when>
							<c:when test="${o.status == 2 }">
								<p><a href="javascript:void(0)" onclick="cancel('${o.orderNO}')">取消订单</a></p>	
							</c:when>
							<c:when test="${o.status == 3 }">
								<p><a href="javascript:void(0)" onclick="confirmReceipt(${o.ID})">确认收货</a></p>	
							</c:when>
						</c:choose>
						<p><a href="user/order/detail?orderID=${o.ID}" target="_blank">订单详情</a></p>	
						<c:if test="${o.status == 9 }">
							<p><a href="javascript:void();" onclick="deleteOrder(${o.ID});">删除订单</a></p>	
						</c:if>
					</td>
					
				</tr>
			</table>
		</c:forEach>
		<div class="ddtablefooter mt10">
			<!-- <div class="ddcaozuo">
				<input class="fl ml10 mr5" type="checkbox" id="selectall2" /> <label
					class="fl mr10" for="selectall2">全选</label> <span
					class="fl c999 mr10">|</span> 
				<select class="daochuanniu fl mt10">
					<option>导出所选订单</option>
				</select>
			</div> -->

			<div class="ddpage fr mr20">
				<jsp:include page="../../include/page.jsp">
					<jsp:param name="request" value="function"/>
					<jsp:param name="functionName" value="zhigu.orderSearch"/>
				</jsp:include>
			</div>
			<div class="clear"></div> 
		</div>
	</div>
				
	 </div>
			<br style="clear:both;" />
		</div>
	</div>




	
	<div class="clear"></div>
<form id="evaluateForm">
	<input type="hidden" name="goodsId" id="evaluateForm_goodsId">
	<input type="hidden" name="orderDetailId" id="evaluateForm_orderDetailId">
	<input type="hidden" name="score" id="evaluateForm_score">
	<input type="hidden" name="content" id="evaluateForm_content">
</form>
<script type="text/javascript" src="js/jQuery-jcDate.js"></script>
<script type="text/javascript" language="javascript" src="js/3rdparty/raty-2.7.0/jquery.raty.js"></script>
<script type="text/javascript">
zhigu.orderSearch = function(pageNo){
	if(pageNo){
		$("#pageNo").val(pageNo);
	}
	window.location.href = zhigu.cmn.formToUrl("#orderSearchForm");
}


var gt = new Array();
var validityTime = 1000 * 60 * 60 * 24 * 1;//订单有效期 1 天
var currentTime = "${nowTime}";
$(document).ready(function(){
	init();
	countDown();
});
//报名倒计时
function init(){
	$(".countDown").each(function(i){
		var dt = $(this).attr("time").split(",");
		
		var t = new Date(dt[0],dt[1] - 1,dt[2],dt[3],dt[4],dt[5]);
		gt[i] = (t.getTime() + validityTime) - currentTime;
	});
}
function countDown(){
	$(".countDown").each(function(i){
		gt[i] = gt[i] - 1000;
		showTime(this,gt[i],i);
	});
	window.setTimeout("countDown()", 1000);
}
function showTime(obj,time,index){
	if(time <= 0){
		cancel2($(obj).data("orderno"));
		return;
	}
	//天
	var day =Math.floor(time / 86400000);
	time -= day * 86400000;
	//时
	var hour = Math.floor(time / 3600000);
	time -= hour * 3600000;
	//分
	var minute = Math.floor(time / 60000);
	time -= minute * 60000;
	//秒
	var second = Math.floor(time / 1000);
	time -= second * 1000;

	if(day < 10)
		day = "0" + day;
	if(hour < 10)
		hour = "0" + hour;
	if(minute < 10)
		minute = "0" + minute;
	if(second < 10)
		second = "0" + second;

	var text = day + "天" + hour + "小时" + minute + "分" + second + "秒";
	$(obj).html(text);
}



$().ready(function (){
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
	
	//查看物流
	
	$("#ckwl").hover(function() {
		if($(this).attr("load") == "false"){
			var _this = this;
			ajaxSubmit("logistics/query", "orderID=" + $(this).attr("oid"), function(data){
				var html = "";
				if(data.length != 0){
					html += "<table class='lh20 tl'>";
					for(var i = 0 ;i < data.length;i++){
						var obj = data[i];
						if(data.length -1 == i)
							html +="<tr class='yqs'><td width='130'>" + obj.time + "</td><td width='250'>" + obj.context + "</td></tr>";
						else
							html +="<tr><td width='130'>" + obj.time + "</td><td width='250'>" + obj.context + "</td></tr>";
					}
					html +="</table>";
				}
				if(html == ""){
					$(_this).find(".wldttalbe").html("暂无记录....");
				}else{
					$(_this).find(".wldttalbe").html(html);
				}
				$(_this).attr("load","true");
			},"json");
		}
		$(this).find("#ckwlnr").show();

	}, function() {

		$("#ckwlnr").hide();

	}
	   
	);
});
function status(sta){
	window.location.href = "user/order?status=" + sta;
}
function orderPayment(orderNo){
	window.location.href="user/order/pay?orderNo=" + orderNo;
}
function cancel(orderNo){
	layer.confirm("确定取消订单？", function(){
		ajaxSubmit("user/order/cancel", {"orderNo":orderNo}, function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg,2,f5);
			}else{
				layer.alert(msgBean.msg,8);
			}
		},"json");
	});
}
function cancel2(orderNo){
		ajaxSubmit("user/order/cancel", {'orderNo':orderNo}, function(){
			reloadCurrentPage();
		},"json");
}
//确认收货
function confirmReceipt(orderID){
	$.layer({
	    shade: [0],
	    area: ['auto','auto'],
		title:"确认收货",
	    dialog: {
	        msg: "支付密码：<input id='payPasswd' type='password'/>",
	        btns: 2,                    
	        type: -1,
	        btn: ['确认','取消'],
	        yes: function(index){
	        	var payPasswd = $("#payPasswd").val();
	        	if(!payPasswd){
	        		layer.msg("请填写支付密码");
	        	}else{
	        		var params = {};
	        		params.payPasswd = zhigu.encodeBase64(payPasswd);
	        		params.orderID = orderID;
	        		ajaxSubmit("user/order/confirmReceipt", params, function(msgBean){
	        			if(msgBean.code==zhigu.code.success){
	        				layer.msg(msgBean.msg,2,reloadCurrentPage);
	        			}else{
	        				layer.alert(msgBean.msg)
	        			}
	    			}, "json");
	        	}
	        	layer.close(index);
	        }, no: function(index){
	        	//layer.close(index);
	        }
	    }
	});
}
//批量付款
function batchPay(){
	var size = $(".dingdantopl input:checkbox[checked][status='1']").size();
	
	if(size == 0){
		dialog("请选择需要支付的订单");
		return ;
	}
	var params = "";
	$(".dingdantopl input:checkbox[checked][status='1']").each(function(index){
		if(index != 0)
			params += "&";
		params += "orderNo=" + $(this).data('orderno');
	});
	window.location.href = "user/order/pay?"+params;
}


function allSelect(obj){
	$("._cbox").attr("checked",$(obj).attr("checked") == "checked");
}

function deleteOrder(orderID){
	layer.confirm("确认删除该订单？",function(){
		$.post("/user/order/delOrder",{"orderID":orderID},function(msgBean){
			if(msgBean.code==zhigu.code.success){
				layer.msg(msgBean.msg,2,reloadCurrentPage);
			}else{
				layer.alert(msgBean.msg);
			}
		});
	});
}
</script>
</body>
</html>