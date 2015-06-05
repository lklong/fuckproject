<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link href="css/default/jcDate.css" rel="stylesheet">
<link href="/css/default/goods.css" rel="stylesheet">
<link href="js/3rdparty/raty-2.7.0/jquery.raty.css" rel="stylesheet">
<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
<title>买家订单</title>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">买家订单</h4>
  <form action="/user/order" id="orderSearchForm">
    <div class="fun-bar">
      <div>
		<span class="mr5">订单编号：</span>
		<span class="ml10">
        <input class="input-txt" type="text" name="orderNO" value="${oc.orderNO }" />
        </span>
		<span class="mr5 ml15">商品名称：</span>
		<span class="ml10">
        	<input class="input-txt" type="text" name="goodsName" value="${oc.goodsName }" />
        </span>
		<span class="mr5 ml15">店铺名：</span>
		<span class="ml10">
        	<input class="input-txt" type="text" name="storeName" value="${oc.storeName }" />
        </span>
	  </div>
      <div class="mt10">
      	<span class="mr5">交易状态：</span> <span class="ml10">
        <select class="select-txt " name="status" id="status">
          <option value="0">全部</option>
          <option value="1">待付款</option>
          <option value="2">待发货</option>
          <option value="3">待确认收货</option>
          <option value="4">交易成功</option>
          <option value="9">交易关闭</option>
        </select>
        </span> </div>
      <div class="mt10"> <span class="mr5">成交时间：</span> <span class="ml10">
        <input class="jcDate input-txt" type="text" id="date1" name="startDateStr" value="<fmt:formatDate value="${oc.startDate }" pattern="yyyy-M-d"/>" />
        </span> <span class="mr5 ml15">到</span> <span class="ml10">
        <input class="jcDate input-txt" type="text" id="date2" name="endDateStr" value="<fmt:formatDate value="${oc.endDate }" pattern="yyyy-M-d"/>" />
        </span> <span class="ml10">
        <input type="hidden" id="pageNo" name="pageNo" />
        <input type="button" value="搜索" onclick="zhigu.orderSearch();" class="input-button" />
        </span> </div>
    </div>
  </form>
  <div class="fun-bar">
    <ul class="fun-tabs">
      <li>订单状态：</li>
      <li <c:if test="${empty oc.status || oc.status == 0 }">class="zhuangtaiselect"</c:if>><a
					href="javascript:status(0)">全部</a></li>
      <li <c:if test="${oc.status == 1 }">class="zhuangtaiselect"</c:if>><a
					href="javascript:status(1)">待付款</a></li>
      <li <c:if test="${oc.status == 2 }">class="zhuangtaiselect"</c:if>><a
					href="javascript:status(2)">待发货</a></li>
      <li <c:if test="${oc.status == 3 }">class="zhuangtaiselect"</c:if>><a
					href="javascript:status(3)">待确认收货</a></li>
      <li <c:if test="${oc.status == 4 }">class="zhuangtaiselect"</c:if>><a
					href="javascript:status(4)">交易完成</a></li>
      <li <c:if test="${oc.status == 9 }">class="zhuangtaiselect"</c:if>><a
					href="javascript:status(9)">交易关闭</a></li>
    </ul>
  </div>
  <table cellpadding="0" cellspacing="0" class="user-list-table">
    <tr>
      <th style="width:40%">商品</th>
      <th style="width:10%">评论</th>
      <th style="width:15%">总金额(元)</th>
      <th style="width:15%">订单状态</th>
      <th style="width:20%" class="no-right-border">交易操作</th>
    </tr>
  </table>

        <c:set var="countDownIndex" value="0" />
        <c:forEach items="${orders }" var="o">
          <table cellpadding="0" cellspacing="0" class="user-list-table txt-center">
            <tr>
              <th colspan="6"
									style="border-right: none; text-align: left; line-height: 60px;"> <span class="ml10 fl">
                <input type="checkbox"
										class="_cbox" value="${o.ID }" data-orderno="${o.orderNO }"
										status="${o.status }" />
                </span> <span class="ml10 fl">订单号：${o.orderNO }</span> <span class="ml30 fl">店铺：<a
										href="store/index?storeId=${o.storeID}" target="_blank">${o.storeName }</a></span> <span class="ml30 fl mt20">
                <c:if
											test="${not empty o.QQ }"> <a target="_blank"
												href="http://wpa.qq.com/msgrd?v=3&uin=${o.QQ }&site=qq&menu=yes"> <em class="qq-kefu-top" title="点这里给我发消息"></em> </a> </c:if>
                <c:if test="${not empty o.aliWangWang }"> <a target="_blank"
												href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${o.aliWangWang}&site=cntaobao&s=2&charset=utf-8"> <em class="wangwang-kefu-top" title="点这里给我发消息"></em> </a> </c:if>
                </span> <span class="fr mr10 color-gray">下单时间：
                <fmt:formatDate
											value="${o.orderTime }" pattern="yyyy-MM-dd HH:mm:ss" />
                </span> </th>
            </tr>
            <tr>
              <td style="width: 40%"><c:forEach items="${o.details }"
										var="od">
                  <table cellpadding="0" cellspacing="0" class="user-list-table">
                    <tr>
                      <td style="width: 10%"><a
													href="goods/detail?goodsId=${od.goodsID}" target="_blank"><img
														height="50" width="50" src="${od.goodsPic}" /></a></td>
                      <td style="width: 50%"><a
													href="goods/detail?goodsId=${od.goodsID}" target="_blank">${od.goodsName }</a></td>
                      <td style="width: 20%"><span class="ml10 fwb color-red">
                        <fmt:formatNumber
															value="${od.unitPrice }" pattern="#0.00" />
                        </span></td>
                      <td style="width: 20%"><span class="ml10">${od.quantity }</span></td>
                    </tr>
                  </table>
                </c:forEach></td>
              <td style="width: 10%"><c:if test="${o.status ==4 }"> <a class="add_comment"
											href="/user/order/goods/comment/${o.ID}">添加评论</a> </c:if></td>
              <td style="width: 15%"><span class="fwb color-red">
                <fmt:formatNumber
											value="${o.payableMenoy}" pattern="#0.00" />
                </span>
                <c:if test="${o.agentMoney>0}">
                  <p class="c999"> (代发：
                    <fmt:formatNumber value="${o.agentMoney + 0}" pattern="#0.00" />
                    ) </p>
                </c:if>
                <c:if test="${o.logisticsMoney>0}">
                  <p class="c999"> (运费：
                    <fmt:formatNumber value="${o.logisticsMoney + 0}"
												pattern="#0.00" />
                    ) </p>
                </c:if></td>
              <td style="width: 10%">${o.statusLabel }</td>
              <td style="width: 10%"><c:if test="${o.status ==3 }">
                  <div id="ckwl" oid="${o.ID }" load="false">
                    <div> <a href="javascript:void(0);">查看物流</a> </div>
                    <div class="wldt f12 c333 disnone" id="ckwlnr">
                      <div class="wldtl lh30  pr10 pl10">
                        <ul>
                          <li 			class="fl"><span>物流公司：${o.logisticsName }</span></li>
                          <li 			class="fl ml10"><span>运单号码：${o.logisticsNO }</span></li>
                        </ul>
                      </div>
                      <div class="wldtr">
                        <div class="wldttalbe  pl10"> <img alt="" src="img/loading.gif"> </div>
                      </div>
                    </div>
                  </div>
                </c:if></td>
              <td style="width: 15%"><c:choose>
                  <c:when test="${o.status == 1 }">
                    <p>离订单失效还有:</p>
                    <p data-orderno="${o.orderNO }"
												class='countDown countDown${countDownIndex }'
												time="<fmt:formatDate value='${o.orderTime }' pattern='yyyy,MM,dd,HH,mm,ss'/>"></p>
                    <c:set var="countDownIndex" value="${countDownIndex + 1 }">
                    </c:set>
                    <p class="mt5"> <a href="javascript:void(0)"
													onclick="orderPayment('${o.orderNO}')" class="edit-user-photo">立即付款</a> </p>
                    <p class="mt5"> <a href="javascript:void(0)"
													onclick="cancel('${o.orderNO}')" class="edit-user-photo">取消订单</a> </p>
                  </c:when>
                  <c:when test="${o.status == 3 }">
                    <p class="mt5"> <a href="javascript:void(0)"
													onclick="confirmReceipt(${o.ID})" class="edit-user-photo">确认收货</a> </p>
                  </c:when>
                </c:choose>
                <p class="mt5"> <a href="user/order/detail?orderID=${o.ID}" target="_blank"
											class="edit-user-photo">订单详情</a> </p>
                <%--  <c:if test="${o.status == 9 }">
										 <p><a href="javascript:void();" onclick="deleteOrder(${o.ID});" class="default-a">删除订单</a></p>
									</c:if> --%></td>
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
            <jsp:param name="request" value="function" />
            <jsp:param name="functionName" value="zhigu.orderSearch" />
            </jsp:include>
          </div>
        </div>
      </div>

<form id="evaluateForm">
  <input type="hidden" name="goodsId" id="evaluateForm_goodsId">
  <input type="hidden" name="orderDetailId"
			id="evaluateForm_orderDetailId">
  <input type="hidden"
			name="score" id="evaluateForm_score">
  <input type="hidden"
			name="content" id="evaluateForm_content">
</form>
<script type="text/javascript" src="js/jQuery-jcDate.js"></script> 
<script type="text/javascript" language="javascript"
		src="js/3rdparty/raty-2.7.0/jquery.raty.js"></script> 
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
	
	$("#ckwl").click(function() {
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
				layer.alert(msgBean.msg,f5);
			}else{
				layer.alert(msgBean.msg);
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
	layer.prompt({
	    title: '确认收货',
	    formType: 1 //prompt风格，支持0-2
	}, function(pass){
		var params = {};
		params.payPasswd = zhigu.encodeBase64(pass);
		params.orderID = orderID;
		ajaxSubmit("user/order/confirmReceipt", params, function(msgBean){
			if(msgBean.code==zhigu.code.success){
				layer.alert(msgBean.msg,reloadCurrentPage);
			}else{
				layer.alert(msgBean.msg)
			}
		}, "json");
	});
}
//批量付款
function batchPay(){
	var size = $(".dingdantopl input:checkbox[checked][status='1']").size();
	
	if(size == 0){
		layer.alert("请选择需要支付的订单");
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
	layer.confirm('确认删除该订单？', {
	    btn: ['确定','取消']
	}, function(){
		$.post("/user/order/delOrder",{"orderID":orderID},function(msgBean){
			if(msgBean.code==zhigu.code.success){
				layer.alert(msgBean.msg,reloadCurrentPage);
			}else{
				layer.alert(msgBean.msg);
			}
		});
	}, function(){
	    
	});
}
</script>
</body>
</html>