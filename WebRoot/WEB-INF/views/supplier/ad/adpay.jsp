<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单支付</title>
<link href="css/jinhuoche.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/global.js"></script>
<!-- <script type="text/javascript" src="js/ad/adpay.js"></script> -->
<script type="text/javascript">

</script>
</head>
<body>
<div style="margin-left: 170px">
<div style="height:54px;"></div>
    	<div class="zfcenter0 mt10 p10">
        	<h2 class="zztcshouyin pl10 c666">您正在使用同城货源平台付款</h2>
               <h3  class="zztcshouyin pl10 c666">商家名称： 智谷商城</h3> 
                <div style="display: block;" >
                    <input type="hidden" id="id" name="id" value="${id}"/>
	                    <table class="zfcentertabledan c666" id="${adOrder.adid}" style="text-align:center;line-height: 30px">
	                        <tr class="zfcenterth" >
	                            <th width="150">开始日期</th>
	                            <th width="150">结束日期</th>
	                            <th width="200">单价</th>
	                            <th width="110">金额</th>
	                        </tr>
	                         <tr id="show">
	                        </tr>
	                    </table>
                </div>
            </div>
     </div>

     <div style="margin-top: 50px;margin-left: 251px" >
          
                <div class="zfcenteryue lh30 c666 mt10 ml50 mt20">
                    <div class="zfcenteryuetitle mb10 f16 fwbold">
                    <div class="zfcenteryuetitle mb10 f16 fwbold" >
                        <div class="fl">您的账户余额：<span class="cff5200 ml5 mr5" id="totalMoney"></span>元</div>
                      
                        
                        <a href="user/recharge" target="_blank">
	                        <input type="button"  value="充值" class="fl ml50 cp"/>
                        </a>
                         <br>
  <div class="zfcenteryuer fl" style="margin-top: 10px">　支付: ￥<span class="cff5200 mr5" ></span></div>
                    </div>
                 </div>
                    <div class="mb20 mt40">
                            <p class="zfcenterchong fl fwbold mr10" id="password" name="${msg}">支付密码:</p>
                            <form method="post" id="sellFrom" name="sellFrom">
                             <input class="zfchongtext fl" type="password" name="paymentPwd" id="paymentPwd" autocomplete="off"/>
                              <input id="adorderid" type="hidden"  name="id"  value="${id}">
                              <input type="hidden" id="totalMoney1" value="">
                              <input type="hidden" id="orderMoney" value="" >
                            </form>
                            <a class="nomima fl ml10" href="user/security/paymentpwd" target="_blank">没有支付密码？</a>
                            <input class="centerchongb mt40 fwbold cp" style="margin-left:-350px;margin-top:70px" onclick="return _submit()" id="submit" type="submit" value="确认支付" />
              </div> 
   </div>
</div>
    <script type="text/javascript" src="js/jinhuoche.js"></script>
    <script type="text/javascript">
    	$().ready(function(){
    		getAdInfo();
    		var msg = "${msg}";
    		if(msg != ""&& msg!="success")
    			dialog(msg);
    	});	
  
    	function _submit(){
    	var paymentPwd = $("#paymentPwd").val();
		var totalMoney = $("#totalMoney1").val();
		var orderMoney = $("#orderMoney").val();
		if(paymentPwd == ""){
			dialog("请输入支付密码");
			return false;
		}
		if(parseFloat(orderMoney) > parseFloat(totalMoney)){
			dialog("帐户余额不足，请充值");
			return false;
		}
		}
    </script>
    <script type="text/javascript">
     function getAdInfo (){
		var id=$("#id").val();
		var url="Admanage/user/loadAdInfo?id="+id;
		$.getJSON(url,function(json){
			                var html="";
				                   html+="<td>"+new Date(json.adpay.startDate).format('yyyy-MM-dd')+"</td>"
		                        	 +"<td>"+new Date(json.adpay.endDate).format('yyyy-MM-dd')+" </td>"
		                           +"<td>"+toDecimal(json.adpay.price)+"</td>"
		                           +"<td>"+toDecimal(json.adpay.calculatePrice)+"元</td>"
		                           
			    $("#show").html(html);
				$(".zfcenteryuer.fl .cff5200.mr5").text(toDecimal(json.adpay.calculatePrice));
				$("#totalMoney1").val(toDecimal(json.acc.normalMoney));
				$("#orderMoney").val(toDecimal(json.adpay.calculatePrice));
				$("#totalMoney").text(toDecimal(json.acc.normalMoney));
				$("#totalMoney1").val(toDecimal(json.acc.normalMoney));
		});
		}
     
    $("#submit").click(function(){
		var val={
				 orderMoney:$("#orderMoney").attr("value"),
				 id:$("#adorderid").val(),
				paymentPwd:$("#paymentPwd").val()
		}
		$.post("Admanage/user/payAdOrder",val,function(msgBean){
			var oid=msgBean.data;
			if(msgBean.code ==zhigu.code.success){
				      dialog("付款成功");
				   setTimeout("changePage("+oid+")", 1000);
			}else{
	    			dialog(msgBean.msg);
			}
		})
	})
     
	function changePage(oid){
    window.location.href="supplier/ad/paysuccess?id="+oid;
    }
     function toDecimal(x) {  
         var f = parseFloat(x);  
         if (isNaN(f)) {  
             return false;  
         }  
         var f = Math.round(x*100)/100;  
         var s = f.toString();  
         var rs = s.indexOf('.');  
         if (rs < 0) {  
             rs = s.length;  
             s += '.';  
         }  
         while (s.length <= rs + 2) {  
             s += '0';  
         }  
         return s;  
     } 
    </script>
</body>
</html>