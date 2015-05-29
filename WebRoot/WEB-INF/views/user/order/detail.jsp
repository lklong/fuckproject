<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>订单详情</title>
</head>
<body>
<div class="rightContainer fr"  id="alldd"> 
  <!-----------------------------------------------订单信息---------------------------------------------------->
  <h4 class="ddtitle">订单信息</h4>
  <table cellpadding="0" cellspacing="0" class="user-form-table">
    <tr>
      <td style="width:10%">订单号：</td>
      <td style="width:90%">${order.orderNO }</td>
    </tr>
    <tr>
      <td>收货人：</td>
      <td>${order.consignee }</td>
    </tr>
    <tr>
      <td>收货地址：</td>
      <td>${order.address }</td>
    </tr>
    <tr>
      <td>手机：</td>
      <td>${order.phone }</td>
    </tr>
    <tr>
      <td>备注：</td>
      <td>${order.comment }</td>
    </tr>
  </table>
  <h4 class="ddtitle">供应商信息</h4>
  <table cellpadding="0" cellspacing="0" class="user-form-table">
    <tr>
      <td style="width:10%">供应商：</td>
      <td style="width:90%"><a href="store/index?storeId=${order.storeID}" target="_blank">${order.storeName }</a></td>
    </tr>
  </table>
  <h4 class="ddtitle">订单商品列表</h4>
  <table cellpadding="0" cellspacing="0" class="user-list-table">
    <tr>
      <th>商品图片</th>
      <th>商品名</th>
      <th>规格</th>
      <th>单价(元)</th>
      <th>数量</th>
      <th>货品状态</th>
      <th>货品总价(元)</th>
    </tr>
    <c:forEach items="${order.details }" var="od">
      <tr>
        <td><a href="goods/detail?goodsId=${od.goodsID}" target="_blank"><img height="50" width="50" src="${od.goodsPic}" /></a></td>
        <td><a href="goods/detail?goodsId=${od.goodsID}" target="_blank">${od.goodsName }</a></td>
        <td>${od.propertystrname }</td>
        <td>${od.unitPrice }</td>
        <td>${od.quantity }</td>
        <td>${order.statusLabel }</td>
        <td><fmt:formatNumber pattern="#0.00" value="${od.unitPrice * od.quantity}"/>
      </tr>
    </c:forEach>
  </table>
  <table cellpadding="0" cellspacing="0" class="user-list-table">
    <tr>
      <th>代发、物流费：</th>
      <th>实付款 ：</th>
    </tr>
    <tr>
      <td><strong class="color-red">￥
        <fmt:formatNumber pattern="#0.00" value="${order.agentMoney + order.logisticsMoney}"/>
        </strong></td>
      <td><strong class="color-red">￥
        <fmt:formatNumber pattern="#0.00" value="${order.actuallyPayMenyoy}"/>
        </strong></td>
    </tr>
  </table>
  <table cellpadding="0" cellspacing="0" class="user-form-table">
    <tr>
      <td>买家留言</td>
      <td>${order.leavelMessage }</td>
    </tr>
  </table>
  <table cellpadding="0" cellspacing="0" class="user-form-table">
    <tr>
      <td>物流信息</td>
      <td>物流公司：${order.logisticsName } &nbsp;&nbsp;&nbsp;&nbsp;运单号码：${order.logisticsNO }
        <div id="progress" class="mt20"></div></td>
    </tr>
  </table>
</div>
<script type="text/javascript">
    	$(function(){
    		var data = "${order.logisticsProgress}";
    		if(data.length == 0){
    			ajaxSubmit("logistics/query", "orderID=${order.ID}", function(r){
    				data = r;
    			},null,false);
    		}
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
				$("#progress").html("暂无记录....");
			}else{
				$("#progress").html(html);
			}
    	});
    	function addEvaluate(){
    		var score =  $("input:radio[name='score']:checked").val();
    		if(score == null){
    			alert("请选择评分！");
    			return;
    		}
    		var content = $("#content").val();
    		if($("#content").val() == null ||$("#content").val()==""){
    			alert("请填写评价内容！");
    			return;
    		}
    		var orderDetailId = $("#orderDetailId").val();
    		alert(orderDetailId);
    		ajaxSubmit("/user/goods/addEvaluate", {"orderDetailId":orderDetailId,"score":score,"content":content},function(msgBean){
    			if(msgBean.code==zhigu.code.success){
    				layer.msg(msgBean.msg);
    			}else{
    				layer.alert(msgBean.msg);
    			}
    		});
    	}
    </script>
</body>
</html>