<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/jinhuoche.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.corner.js"></script>
<title>购物车</title>
</head>
<body>
	<div style="height: 54px;"></div>
	<div class="webpage">
		<div class="gytop mt10 lh40">
			<p class="jinhuotishi c666 ml20 fl">进货车的商品可保存30天，请尽快下单购买</p>
			<p class="jinhuojiesuan c666 fr">
				已选商品（不含运费）：<strong class="cff5200 mr10">¥</strong><strong class="cff5200 mr10" id="totalMoney2"></strong> <input class="mr20 cp" type="button"
					onclick="confirm()" value="结算" />
			</p>
			<div class="clear"></div>
		</div>
		<table class="gytable">
			<tr class="gyth c333">
				<th width="450">
					<div>
						<input type="checkbox" onclick="zhigu.allCheckBoxClick(this);"  class="fl ml10 mr5" id="allChoose">
						<label class="fl mr10" for="allChoose">全选</label>
					</div> 货品
				</th>
				<th width="200">规格</th>
				<th width="150">价格</th>
				<th width="100">库存</th>
				<th width="100">数量</th>
				<th width="90">小计</th>
				<th width="100">操作</th>
			</tr>
			<c:forEach items="${shoppingCartList }" var="sc" varStatus="scStatus">
				<tr class="gynamebox lh50">
					<td colspan="7">
						<input class="fl mr5 ml10 ckbox" onclick="zhigu.storeCheckBoxClick(this);" value="${sc.storeId}"  type="checkbox" />
						<div class="gongying fl">
							<span class="gongyingname0">供应商：</span> 
							<span class="gongyingname1"> 
								<a class="gynamea c666 mr10" href="store/index?storeId=${sc.storeId}" target="_blank">${sc.storeName }</a> 
								<c:if test="${not empty sc.QQ }">
									<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${sc.QQ }&site=qq&menu=yes">
									<img border="0" src="http://wpa.qq.com/pa?p=2:${sc.QQ}:52" alt="点这里给我发消息" /></a>
								</c:if>
								 <c:if test="${not empty sc.aliWangWang }">
									<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${sc.aliWangWang}&site=cntaobao&s=2&charset=utf-8"><img border="0"
										src="http://amos.im.alisoft.com/online.aw?v=2&uid=${sc.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a>
								</c:if>
							</span>
						</div>
						<div class="clear"></div></td>
				</tr>
				<c:forEach items="${sc.item }" var="item" varStatus="itemStatus">
					<tr class="gytxtbox">
						<td><input onclick="zhigu.itemCheckBoxClick(this);" name="itemCheckBox" class="jinhuocheck fl ml10 mr10 ckbox sckbox${sc.storeId } ibox"
							cmid="${item.goods.id}" cv="${item.goodsSku.id }" value="${item.id }" <c:if test="${item.checked }"> checked="checked" </c:if>
							id="ck_${scStatus.count }_${itemStatus.count}" type="checkbox" />
							<div class="gyimg fl">
								<a class="c666" href="goods/detail?goodsId=${item.goods.id}" target="_blank"><img src="${item.goods.image300}" /></a>
							</div>
							<div class="gymiao fl ml10">
								<a class="c666" href="goods/detail?goodsId=${item.goods.id}" target="_blank">${item.goods.name}</a>
							</div>
							<div class="clear"></div></td>
						<td title="${item.goodsSku.propertyStrName }">${empty item.goodsSku.propertyStrName?'-':item.goodsSku.propertyStrName }</td>
						<td><fmt:formatNumber pattern="#0.00" value="${item.goodsSku.price }" /></td>
						<td>${item.goodsSku.amount }</td>
						<td class="modifynum">
							<div class="modifydiv">
								<a class="fl tc" href="javascript:void(0);" onclick="zhigu.addBuynum($(this).parent().find(':[name=buynum]')[0],-1);">-</a> <input
									name="buynum" itemid="${item.id}" class="modinum fl quantify" type="text" subkey="${scStatus.count }"
									data-repertory="${item.goodsSku.amount}" id="quantity_${item.id }" key="${scStatus.count }_${itemStatus.count}" maxlength="5"
									unit="${item.goodsSku.price }" value="${item.quantity }" onblur="this.value=(this.value == '' ? 0 : parseInt(this.value,10));"
									onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /> <a class="fl tc"
									href="javascript:void(0)" onclick="zhigu.addBuynum($(this).parent().find(':[name=buynum]')[0],1);">+</a>
								<div class="clear"></div>
							</div>
						</td>
						<td><strong class="cff5200">￥</strong> <strong class="cff5200" id="subTotal_${scStatus.count }_${itemStatus.count}"></strong></td>
						<td class="caozuo">
							<ul>
									<li id="favourite${item.goods.id}"><a href="javascript:void(0)" onclick="addFavouriteGoods(${item.goods.id});">收藏</a></li>
								<li><a href="javascript:void(0)" onclick="del(${item.id})">删除</a></li>
							</ul>
						</td>
					</tr>
				</c:forEach>
				<tr class="gytxtfoot">
					<td colspan="8">
						<p class="fr mr10">
							店铺合计（不含运费）：<strong class="cff5200">¥</strong><strong class="cff5200 totalStore" id="totalStore_${scStatus.count }"></strong>
						</p>
						<div class="clear"></div>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div class="gyzong lh40 mt10">
			<input type="checkbox" onclick="zhigu.allCheckBoxClick(this);" class="fl mt13 ml20 mr5 ckbox" id="allChoose">
			 <label class="fl mr10" for="allChoose">全选</label> 
			 <span class="delsuoxuan fl mr10"><a href="javascript:void(0)" onclick="del('')">删除所选</a></span> 
			 <span class="fl" onclick="addFavouriteGoodsBatch();" style="cursor: pointer;">批量收藏</span>
			<div class="fr">
				<div class="gyzongleft fl fwbold f14 c666">
					<span>数量总计<strong class="zongprice1 cff5200 ml10 mr10" id="totalQuantity"></strong>件
					</span> <span>货品金额总计（不含运费）：</span> <strong class="zongprice2 cff5200">￥</strong><strong class="zongprice3 cff5200 f18" id="totalMoney"> </strong>
				</div>
				<input type="button" onclick="confirm()" value="结算" class="gynext fl mr20 mt5 w100 ml10 cp">
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
		<form action="user/order/confirm" method="post" id="confirmForm"></form>
	</div>
	<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}
$(function(){
	zhigu.cartCount();
	// 绑定修改购物车商品数量操作
	$("input[name='buynum']").each(function(){
		$(this).change(function(){
			zhigu.updateCartGoodsQuantity(this);
		});
	});
})
// 服务器请求，修改购物车商品数量
zhigu.updateCartGoodsQuantity = function(buynum_obj){
	var $buynum = $(buynum_obj);
	var id =parseInt($buynum.attr("itemid")); 
	var quantity =parseInt($(buynum_obj).val()); 
	if(quantity<=0){
		layer.alert("商品数量不能小于1 ！");
		return;
	}
	var repertory = $buynum.data("repertory");
	if(repertory<quantity){
		layer.alert("商品库存不足！");
		return;
	}
	ajaxSubmit("/user/cart/updateGoodsQuantity",{"id":id,"quantity":quantity},function(msgBean){
		if(msgBean.code==zhigu.code.success){
			zhigu.cartCount();
		}else{
			layer.msg(msgBean.msg,2,f5);
		}
	});
}
// 添加购买数量
zhigu.addBuynum = function(buynum_obj,addnum){
	var $buynum = $(buynum_obj);
	var repertory = $buynum.data("repertory");
	var num = parseInt($buynum.val())+addnum;
	if(num<1){
		num = 1;
	}else if(num>repertory){
		num = repertory;
	}
	$buynum.val(num);
	zhigu.updateCartGoodsQuantity(buynum_obj);
}
// 服务器请求，选中状态修改(param[] = id:isChecked)
zhigu.updateIsChecked = function(param){
	if(!param||param.length==0){
		return;
	}
	ajaxSubmit("/user/cart/checked",{"idAndIsChecked":param},function(result){
		//f5();
		if(result.code==1){
			zhigu.cartCount();
			return true;
		}else{
			dialog(result.msg,function(){
				f5();
			});
			return false;
		}
	});
}
zhigu.itemCheckBoxClick = function(obj){
	var toIschecked = $(obj).prop("checked")?1:0;
	var param = $(obj).val()+":"+toIschecked;
	zhigu.updateIsChecked(param);
}
zhigu.storeCheckBoxClick = function(obj){
	var toIschecked = $(obj).prop("checked")?1:0; 
	var itemCheckBox = {};
	if(toIschecked==1){
		// 获取未被选中的项
		itemCheckBox = $(".sckbox"+$(obj).val()).not(":checked");
		itemCheckBox.prop("checked",true);
	}else{
		itemCheckBox = $(".sckbox"+$(obj).val()+":checked");
		itemCheckBox.prop("checked",false);
	}
	var param = [];
	itemCheckBox.each(function(){
		param.push($(this).val()+":"+toIschecked);
	});
	zhigu.updateIsChecked(param);
}
zhigu.allCheckBoxClick = function(obj){
	var toIschecked = $(obj).prop("checked")?1:0; 
	var itemCheckBox = {};
	if(toIschecked==1){
		// 获取未被选中的项
		itemCheckBox = $("input[name='itemCheckBox']").not(":checked");
		$("input:checkbox").prop("checked",true);
	}else{
		itemCheckBox = $("input[name='itemCheckBox']:checked");
		$("input:checkbox").prop("checked",false);
	}
	var param = [];
	itemCheckBox.each(function(){
		param.push($(this).val()+":"+toIschecked);
	});
	zhigu.updateIsChecked(param);
}
//quantityTotal  数量总计
//moneyTotal  价钱总计
//统计
zhigu.cartCount = function(){
	//先清零，再计算
	$(".totalStore").html("0.00");
	$("#totalQuantity").html("0");
	$("#totalMoney").html("0.00");
	$("#totalMoney2").html("0.00");
	
	$(".quantify").each(function(){
		var quan = parseInt($(this).val(), 10);//数量
		var key = $(this).attr("key");//key,定位
		var subkey = $(this).attr("subkey");
		var unit = parseFloat($(this).attr("unit"));//单价
		//小计
		var sub = parseFloat(quan * unit);
		$("#subTotal_" + key).html(sub.toFixed(2));
		
		//店铺总计
		var st = $("#totalStore_" + subkey).html();//原值
		$("#totalStore_" + subkey).html((parseFloat(st) + sub).toFixed(2));
		
		 //商品勾选
		if($("#ck_" + key).attr("checked") == "checked"){
			$("#totalQuantity").html(parseInt($("#totalQuantity").html(), 10) + quan);
			$("#totalMoney").html((parseFloat($("#totalMoney").html()) + sub).toFixed(2));
			$("#totalMoney2").html((parseFloat($("#totalMoney2").html()) + sub).toFixed(2));
		}
	});
}
//删除商品，如果item为，则表示删除所选商品
function del(item){
	var data = "";//传递的参数
	if(item == null || item == ""){
		$(".ibox").each(function(){
			if($(this).attr("checked") == "checked"){
				if(data != "")
					data += "&";
				data += "items="+$(this).val();
			}
		});
	}else{
		data = "items="+item;
	}
	if(data == ""){
		layer.alert("请选择需要删除的商品");
		return;
	}
	confirmDialog("确定删除选择商品？", function(){
		ajaxSubmit("/user/cart/delete", data, function(msgBean){
			if(msgBean.code == zhigu.code.success){
				f5();
			}else{
				layer.alert(msgBean.msg);
			}
		});
	});
}
//确认订单
function confirm(){
	//封装字串表单
	var para = "";
	var go = true;
	$(".ibox").each(function(){
		if($(this).attr("checked") == "checked"){
			var ck = $(this).val();
			var quantity = parseInt($("#quantity_" + ck).val());
			var rep = parseInt($("#quantity_" + ck).data("repertory"));
			if(rep < quantity){
				dialog("存在库存不足商品");
				go = false;
			}
			if(quantity != 0)
				para += "<input type='hidden' name='customValue' value='" + (ck + ":" + quantity) + "'>"
		}
	});
	if(!go)
		return;
	var totalQuantity = parseInt($("#totalQuantity").html());
	if(totalQuantity == 0 || para == ""){
		dialog("请选择、填写需要结算商品与数量");
		return ;
	}
	$("#confirmForm").append(para);
	//	$("#confirmForm").submit();
	window.location.href="/user/order/confirm";
}
//收藏商品
function addFavouriteGoods(goodsID){
	$.ajax({
		url:"user/favourite/addFavouriteGoods",
		data:{"goodsID":goodsID},
		dataType:"json",
		success:function(msgBean){
			if(msgBean.code == zhigu.code.success){
				$("#favourite"+goodsID).html("已收藏");
				layer.msg(msgBean.msg, 1, f5);
			}else{
				layer.alert(msgBean.msg);
			}
		},
		error:function(){
			dialog("商品ID:"+goodsID+" 添加收藏失败！",null,null,null,null);
		}
	});
};
// 批量添加
function addFavouriteGoodsBatch(){
	var count = 0;
	$(".gytxtbox input:checkbox").each(function(){
		if ($(this).attr("checked")) {
			addFavouriteGoods($(this).attr("cmid"));
			count ++;
		}
	});
	if(count==0){
		layer.msg("请选择商品！");
	}
}
</script>
</body>
</html>