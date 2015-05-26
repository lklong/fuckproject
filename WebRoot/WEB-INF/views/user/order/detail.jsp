<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/wangshang.css" rel="stylesheet" type="text/css" />
<title>订单详情</title>
</head>
<body>
<div class="body_center2 fl p10 ml10 f12"  id="alldd">
<!-----------------------------------------------订单信息---------------------------------------------------->
		<div class="jinsan f12 lh25 pl20">
        	<ul>
            	<li class="dingdanselect fl mr5"><a href="#">订单详情</a></li>
            </ul>
            <div class="clear"></div>
        </div>
        <div class="ddxxbox pt10 lh25 c666">
        	<div class="ddxxboxl">
            	<h4 class="f14">买家信息</h4>
                <div>
                	<p class="ddxxtt">订单号：</p>
                    <p>${order.orderNO }</p>
                    <div class="clear"></div>
                </div>
                <div>
                	<p class="ddxxtt">收货人：</p>
                    <p>${order.consignee }</p>
                    <div class="clear"></div>
                </div>
                <div>
                	<p class="ddxxtt">收货地址：</p>
                    <p><span>${order.address }</span></p>
                    <div class="clear"></div>
                </div>
                <div>
                	<p class="ddxxtt">手机：</p>
                    <p>${order.phone }</p>
                    <div class="clear"></div>
                </div>
                <div>
                	<p class="ddxxtt">备注：</p>
                    <p>${order.comment }</p>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="ddxxboxl">
            	<h4 class="f14">卖家信息</h4>
                <div>
                	<p class="ddxxtt">供应商：</p>
		                    <p><a href="store/index?storeId=${order.storeID}" target="_blank">${order.storeName }</a></p>
                    <div class="clear"></div>
                </div>
            </div> 
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
        <table class="ddxxtable tc lh30">
        	<tr class="ddxxth c333">
            	<th width="100">商品图片</th>
            	<th width="250">商品名</th>
            	<th width="250">规格</th>
                <th width="150">单价(元)</th>
                <th width="100">数量</th>
                <th width="150">货品状态</th>
                <th width="100">货品总价(元)</th>
            </tr>
            <c:forEach items="${order.details }" var="od">
	            <tr>
	            	<td>
	                	<div class="ddxximg mt10">
		                	<a href="goods/detail?goodsId=${od.goodsID}" target="_blank"><img src="${od.goodsPic}" /></a>
	                	</div>
	                </td>
	                <td>
	                	<div class="ddxximgmiao  mt10">
		                		<a href="goods/detail?goodsId=${od.goodsID}" target="_blank">${od.goodsName }</a>
	                    </div>
	                </td>
	                <td>${od.propertystrname }</td>
	                <td>${od.unitPrice }</td>
	                <td>${od.quantity }</td>
	                <td>${order.statusLabel }</td>
	                <td><fmt:formatNumber pattern="#0.00" value="${od.unitPrice * od.quantity}"/>
	            </tr>
<!-- 	            <div> -->
<%-- 					<form id="${od.goodsID}From"> --%>
<%-- 						订单详情ID：<input type ="text" name="orderDetailId" id="orderDetailId" value="${od.ID}"> --%>
<!-- 						<input type="radio" name="score" class="score" value = "1" />1 -->
<!-- 						<input type="radio" name="score" class="score" value = "2" />2 -->
<!-- 						<input type="radio" name="score" class="score" value = "3" />3 -->
<!-- 						<input type="radio" name="score" class="score" value = "4" />4 -->
<!-- 						<input type="radio" name="score" class="score" value = "5" />5 -->
						
<!-- 						<textarea id='content' name="content" style='width:400px;height:110px;margin-top:10px;'maxlength='500'></textarea> -->
						 
<!-- 						<input type='button' onclick='addEvaluate()' value='提交评论' /> -->
<!-- 					 </form> -->
<!-- 				</div> -->
            </c:forEach>
        </table>
        <div class="ddxxfukuan fr mt10 mr20 lh30 c666">
        	<div>代发、物流费：<strong class="ddxxdaifafei">￥<fmt:formatNumber pattern="#0.00" value="${order.agentMoney + order.logisticsMoney}"/></strong></div>
            <div>实付款 ：<strong class="cff5200 f16">￥<fmt:formatNumber pattern="#0.00" value="${order.actuallyPayMenyoy}"/> </strong></div>
        </div>
        <div class="clear"></div>
        <div class="ddxxliuyan pl10">
        	<h4 class="lh30 f16 c333">买家留言</h4>
            <p class="c666">${order.leavelMessage }</p>
        </div>
        <div class="clear"></div>
        <div class="ddxxliuyan pl10">
        	<h4 class="lh30 f16 c333">物流信息</h4>
            <p class="c666">物流公司：${order.logisticsName } &nbsp;&nbsp;&nbsp;&nbsp;运单号码：${order.logisticsNO }</p>
            <div id="progress" class="mt20"></div>
        </div>
    </div>
    <div class="clear"></div>
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