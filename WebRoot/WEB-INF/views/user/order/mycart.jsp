<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link href="/css/default/user.css" rel="stylesheet">
<script type="text/javascript" src="js/3rdparty/layer/layer.min.js"></script>
<title>我的购物车</title>
</head>
<body>
	<div class="shopping-cart-body" id="cart-body">
		<div class="msg-alert">
			<span class="gantanhao"></span>进货车的商品可保存30天，请您尽快确认订单并付款。
		</div>
		<div class="pay-select">
			<span class="fr"> <input class="input-button ml20" type="button" onclick="confirm()" value="结算" />
			</span> <span class="fr mt10">已选商品（不含运费）：<strong class="color-red">¥</strong><strong class="color-red" id="allMoneyCount2"></strong></span>
		</div>
		<table cellpadding="0" cellspacing="0" class="shopping-cart-table">
			<!-- 标题 -->
			<tr>
				<th style="width: 6%"><input type="checkbox" onclick="zhigu.allCheckBoxClick(this);" class="fl mt10 ml10" id="allChoose"> <label
					class="fl ml10" for="allChoose">全选</label></th>
				<th style="width: 30%">货品</th>
				<th style="width: 19%">规格</th>
				<th style="width: 9%">价格</th>
				<th style="width: 9%">库存</th>
				<th style="width: 9%">数量</th>
				<th style="width: 9%">小计</th>
				<th style="width: 9%">操作</th>
			</tr>
			<c:forEach items="${shoppingCartList }" var="sc" varStatus="scStatus">
				<tr class="js-store-tr">
					<td colspan="8">
						<!-- 店铺 -->
						<div class="shop-list-head">
							<span class="ml10">
								 <input onclick="zhigu.storeCheckBoxClick(this);" name="storeCheckBox" value="${sc.storeId}" type="checkbox" />
							</span> 
							<span class="ml30">店铺：</span>
							<span>
								<a class="color-red" href="/store/index?storeId=${sc.storeId}" target="_blank">${sc.storeName }</a>
							</span> 
							<span class="ml20"> 
								<c:if test="${not empty sc.QQ }">
									<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${sc.QQ }&site=qq&menu=yes"> <img style="margin-bottom: -6px; margin-left: 5px;"
										border="0" src="http://wpa.qq.com/pa?p=2:${sc.QQ}:52" alt="点这里给我发消息" /></a>
								</c:if> 
								<c:if test="${not empty sc.aliWangWang }">
									<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${sc.aliWangWang}&site=cntaobao&s=2&charset=utf-8"> <img
										style="margin-bottom: -2px; margin-left: 5px;" border="0"
										src="http://amos.im.alisoft.com/online.aw?v=2&uid=${sc.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a>
								</c:if>
							</span>
						</div> 
						<!-- 商品 --> 
						<c:forEach items="${sc.item }" var="item" varStatus="itemStatus">
							<table cellpadding="0" cellspacing="0" class="shopping-list-table no-border-margin">
								<tr class="js-goods-tr">
									<td style="width: 6%">
										<input onclick="zhigu.itemCheckBoxClick(this);" name="itemCheckBox"
										class="jinhuocheck fl ml10 mr10 ckbox  ibox" data-goods-id="${item.goods.id}" data-sku-id="${item.goodsSku.id }" value="${item.id }"
										<c:if test="${item.checked }"> checked="checked" </c:if> id="ck_${scStatus.count }_${itemStatus.count}" type="checkbox" />
									</td>
									<td style="width: 30%"><a class="fl" href="goods/detail?goodsId=${item.goods.id}" target="_blank"><img height="50" width="50"
											src="${item.goods.image300}" /></a> <a class="fl mt15 ml10" href="goods/detail?goodsId=${item.goods.id}" target="_blank">${item.goods.name}</a></td>
									<td style="width: 19%" title="${item.goodsSku.propertyStrName }">${empty item.goodsSku.propertyStrName?'-':item.goodsSku.propertyStrName }</td>
									<td style="width: 9%"><fmt:formatNumber pattern="#0.00" value="${item.goodsSku.price }" /></td>
									<td style="width: 9%">${item.goodsSku.amount }</td>
									<td style="width: 9%">
										<a class="fl tc" href="javascript:void(0);" onclick="zhigu.addBuynum($(this).parent().find(':[name=buynum]')[0],-1);">-</a> 
										<input name="buynum" class="modinum fl" type="text"   maxlength="5"
											 data-item-id="${item.id}" data-repertory="${item.goodsSku.amount}" data-item-unit-price="${item.goodsSku.price }" value="${item.quantity }"
											onblur="this.value=(this.value == '' ? 0 : parseInt(this.value,10));" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /> 
										<a class="fl tc" href="javascript:void(0)" onclick="zhigu.addBuynum($(this).parent().find(':[name=buynum]')[0],1);">+</a>
									</td>
									<td style="width: 9%">
										<strong class="color-red">￥</strong> <strong class="color-red data-goods-count-price" ></strong>
									</td>
									<td style="width: 9%"><ul>
											<li><a href="javascript:void(0)" onclick="addFavouriteGoods(${item.goods.id});" class="default-a">收藏</a></li>
											<li><a href="javascript:void(0)" onclick="del(${item.id})" class="default-a">删除</a></li>
										</ul></td>
								</tr>
							</table>
						</c:forEach> <!-- 合计-->
						<div class="total-money">
							<span class="fr mr10">店铺合计（不含运费）：
								<strong class="color-red">¥</strong>
								<strong class="color-red totalStore data-store-count-price"></strong>
							</span>
						</div>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div class="shop-list-head">
			<span> <input type="checkbox" onclick="zhigu.allCheckBoxClick(this);" class="ckbox ml10 fl mt15" id="allChoose"> <label
				class="fl ml10" for="allChoose">全选</label>
			</span> <span><a href="javascript:void(0)" onclick="del('')" class="default-a">删除所选</a></span> <span><a href="javascript:void(0)"
				onclick="addFavouriteGoodsBatch();" class="default-a">批量收藏</a></span>
			<div class="fr">
				<span>数量总计<strong class="color-red ml10 mr10" id="allQuantity"></strong>件
				</span> <span>货品金额总计（不含运费）：<strong class="zongprice2">￥</strong><strong class="color-red" id="allMoneyCount"></strong></span> <span><input
					type="button" onclick="confirm()" value="结算" class="gynext input-button ml10" /></span>
			</div>
		</div>
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
	buyNumCheck();
})
// 购买数量检查，只根据选中的商品返回true/false
function buyNumCheck(obj){
	var okflag = true;
	var singleCheck = function(obj){
		var $this = $(obj);
		if($this.val()>$this.data("repertory")){
			if($this.closest(".js-goods-tr").find("input[name='itemCheckBox']").prop("checked")){
				okflag = false;
			}
			$this.addClass("quantify");
		}else{
			$this.removeClass("quantify");
		}
	}
	if(obj){
		singleCheck(obj);
	}else{
		$("input[name='buynum']").each(function(){
			singleCheck(this);
		});
	}
	return okflag;
}
// 服务器请求，修改购物车商品数量
zhigu.updateCartGoodsQuantity = function(buynum_obj){
	var $buynum = $(buynum_obj);
	var id =$buynum.data("item-id"); 
	var quantity =parseInt($(buynum_obj).val()); 
	if(quantity<1){
		layer.alert("商品数量不能小于1 ！");
		return;
	}
	var repertory = $buynum.data("repertory");
// 	if(repertory<quantity){
// 		layer.alert("商品库存不足！剩余库存为："+repertory);
// 		return;
// 	}
	if(buyNumCheck(buynum_obj)){
		$.post("/user/cart/updateGoodsQuantity",{"id":id,"quantity":quantity},function(msgBean){
			if(msgBean.code==zhigu.code.success){
				zhigu.cartCount();
			}else{
				layer.msg(msgBean.msg,2,f5);
			}
		});
	}
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
zhigu.updateIsChecked = function(paramArray){
	if(!paramArray||paramArray.length<1)return;
	$.post("/user/cart/checked",{"idAndIsChecked":paramArray.join()},function(result){
		if(result.code==1){
			zhigu.cartCount();
		}else{
			layer.alert(result.msg,f5);
		}
	});
}
zhigu.itemCheckBoxClick = function(obj){
	var toIschecked = $(obj).prop("checked")?1:0;
	var param = [$(obj).val()+":"+toIschecked];
	zhigu.updateIsChecked(param);
}
zhigu.storeCheckBoxClick = function(obj){
	var toIschecked = $(obj).prop("checked")?1:0; 
	var itemCheckBox = {};
	if(toIschecked==1){
		// 获取未被选中的项
		itemCheckBox = $(obj).closest(".js-store-tr").find("input[name='itemCheckBox']").not(":checked");
		itemCheckBox.prop("checked",true);
	}else{
		itemCheckBox = $(obj).closest(".js-store-tr").find("input[name='itemCheckBox']:checked");
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
		$("#cart-body").find("input[type='checkbox']").prop("checked",true);
	}else{
		itemCheckBox = $("input[name='itemCheckBox']:checked");
		$("#cart-body").find("input[type='checkbox']").prop("checked",false);
	}
	var param = [];
	itemCheckBox.each(function(){
		param.push($(this).val()+":"+toIschecked);
	});
	zhigu.updateIsChecked(param);
}
//购物车统计
zhigu.cartCount = function(){
	//先清零，再计算
	$("#allQuantity").html("0");
	$("#allMoneyCount").html("0.00");
	$("#allMoneyCount2").html("0.00");
	
	var  allQuantity= 0;
	var allMoneyCount=0;
	// 循环处理每一个店铺
	$(".js-store-tr").each(function(){
		var $storeTr = $(this);
		var storeCountPrice = 0;
		// 循环处理店铺里的商品
		$storeTr.find(".js-goods-tr").each(function(){
			var $goodsTr = $(this);
			var $buynumInput = $goodsTr.find("input[name='buynum']");
			var goodsCountPrice = zhigu.cmn.arith($buynumInput.val(),"*",$buynumInput.data("item-unit-price"));
			if($goodsTr.find("input[name='itemCheckBox']").prop("checked")){
				allQuantity = zhigu.cmn.arith(allQuantity,"+",$buynumInput.val());
				storeCountPrice = zhigu.cmn.arith(storeCountPrice,"+",goodsCountPrice);
			}
			$goodsTr.find(".data-goods-count-price").html(goodsCountPrice);
		});
		allMoneyCount = zhigu.cmn.arith(allMoneyCount,"+",storeCountPrice);
		$storeTr.find(".data-store-count-price").html(storeCountPrice);
	});
	$("#allQuantity").html(allQuantity);
	$("#allMoneyCount").html(allMoneyCount);
	$("#allMoneyCount2").html(allMoneyCount);
}
//删除商品，如果item为，则表示删除所选商品
function del(item){
	var data = "";//传递的参数
	if(!item){
		$("input[name='itemCheckBox']:checked").each(function(){
			if(data != ""){
				data += "&";
			}
			data += "items="+$(this).val();
		});
	}else{
		data = "items="+item;
	}
	if(!data){
		layer.alert("请选择需要删除的商品");
		return;
	}
	$.layer({
	    shade: [0.5, '#000'],
	    area: ['auto','auto'],
	    dialog: {
	        msg: '确定删除选择商品？',
	        btns: 2,                    
	        type: 4,
	        btn: ['确定','取消'],
	        yes: function(){
	        	ajaxSubmit("/user/cart/delete", data, function(msgBean){
	    			if(msgBean.code == zhigu.code.success){
	    				f5();
	    			}else{
	    				layer.alert(msgBean.msg);
	    			}
	    		});
	        },
	        no: function(){}
	    }
	});
}
//确认订单
function confirm(){
	if(buyNumCheck()){
		window.location.href="/user/order/confirm";
	}else{
		layer.alert("有库存不足的商品，请修改");
	}
}

//收藏商品
function addFavouriteGoods(goodsID){
	$.post("/user/favourite/addFavouriteGoods",{"goodsID":goodsID},function(msgBean){
		if(msgBean.code == zhigu.code.success){
			$("#favourite"+goodsID).html("已收藏");
			layer.msg(msgBean.msg, 1);
		}else{
			layer.alert(msgBean.msg);
		}
	});
};
// 批量添加
function addFavouriteGoodsBatch(){
	var count = 0;
	$("input[name='itemCheckBox']:checked").each(function(){
		if ($(this).attr("checked")) {
			addFavouriteGoods($(this).data("goods-id"));
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