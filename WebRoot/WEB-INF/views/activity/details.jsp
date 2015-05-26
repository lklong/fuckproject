<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品详情</title>
<link href="js/3rdparty/raty-2.7.0/jquery.raty.css" rel="stylesheet" type="text/css" >
<link href="css/jinhuoche.css" rel="stylesheet" type="text/css" />
<style type="text/css">
#description img{
max-width: 975px;
}
</style>
<script type="text/javascript" src="js/mz-packed.js"></script>
<link type="text/css" rel="stylesheet" rev="stylesheet" href="/css/pointExchange.css" />
</head>

<body >
<!--<div class="shopInfoTop"></div>-->
<div class="goodsDetailsBody">
	<div class="goodsBodyInside">
		<div class="detailsLeft">
			<div class="goodsImgTxtBox">
				<div class="gitbLeft">
					<div class="gitbImgBox">
						<span>
						<a href="${pointGoods.picture }" class="MagicZoom" id="MagicZoom">
							<img src="${pointGoods.picture}" style="max-height:398px;max-width:398px;" />
						</a>
						</span>
					</div>
					<ul class="gitbThumbImgList">
							<li>
		   						<a href="${pointGoods.picture }" rel="MagicZoom" rev="${pointGoods.picture }">
		   							<img src="${pointGoods.picture}" width="58" height="58" />
		   						</a>
		   					</li>
					</ul>
				</div>
				<div class="gitbRight">
					<h3>${pointGoods.name }</h3>
					<div class="priceDiv">
						<div class="priceTxt">需要积分：</div>
						<div class="priceNum"><span class="ff3300"><font size="+2"><strong>${pointGoods.needPoint }</strong></font></span></div>
						<div class="priceAlert">${pointGoods.pointTypeLabel }</div>
					</div>
					<table>
						<tr>
							<td width="20%">剩余数量：</td>
							<td width="80%"><font color="#ff3300">${pointGoods.repertory }</font>件</td>
						</tr>
					</table>
					<div class="gitbButns">
						<c:choose>
							<c:when test="${pointGoods.status == 1&&pointGoods.repertory>0}">
								<div class="prbKey"><h3><a class="comBtn_red" href="javascript:void(0)" onclick="pointExchange(${pointGoods.id });" ><em></em>立即兑换</a></h3></div>
							</c:when>
							<c:otherwise>
								<a class="comBtn_gray" href="javascript:void(0)"><em></em>该商品兑换结束</a>
							</c:otherwise>
						</c:choose> 
					</div>
				</div>
			</div>
			<!--** 切换条 **-->
			<div class="infoSelectBar">
				<ul class="infoSelectList">
					<li style="cursor: pointer;" onclick="selTab(this,'baseInfo')" class="infoSelectedLi">商品详情</li>
				</ul>
				<div class="infoSelectBg"></div>
			</div>
			<!--** 基本信息表格 **-->
			<div class="selTab baseInfo">
				<br style="clear:both" />
				<div class="mt10" id="description">
					${pointGoods.details }
				</div>
			</div>
			
		</div>
	</div>
	<br style="clear:both" />
</div>
<div id="infoInputDiv" class="easyui-dialog" closed="true" modal="true" title="信息填写" style="width:500px;height:370px;">
	<div class="duihuanbox">
	<form id="savePointExchangeForm">
	<p class="red">* 请准确填写收货地址，否则可能收不到兑换物品。</p>
	<p><span>兑换：</span >${pointGoods.name }</p>
	<p><span>收货人姓名：</span><input name="name" id="name" maxlength="8"/></p>
	<p><span>收货人地址：</span><input name="address" id="address" maxlength="100"/></p>
	<p><span>收货人电话：</span><input name="phone" id="phone" maxlength="11"/></p>
	<p><span>邮政编码：</span><input name="postCode" id="postCode" maxlength="6"/></p>
	<input id="sub_exchangeId" name="exchangeId" type="hidden"/>
	<p><input type="button"  value="确定" class="duihuanbtn" onclick="savePointExchange();"/></p>
	</form>
	</div>
</div>
<script type="text/javascript">
function pointExchange(id){
	zhigu.cmn.ajax({
		url:"user/address/getDefaultAddress",
		success:function(address){
			if(address){
				$("#name").val(address.name);
				$("#address").val(address.province+address.city+address.district+address.street);
				$("#phone").val(address.phone);
				$("#postCode").val(address.postcode);
			}
		}
	});
	$("#sub_exchangeId").val(id);
	$("#infoInputDiv").dialog("open");
	$("#infoInputDiv").dialog("move",{top:$(document).scrollTop() +150});  
}
function savePointExchange(){
	var flg = true;
	$("#savePointExchangeForm input").each(function(){
		if(!$(this).val()&&flg){
			flg = false;
			return false;
		}
	});
	if(!flg){
		alert("请填写完整信息！");
		return;
	}
	confirmDialog("确认兑换该物品？将扣除积分。",function(){
		ajaxSubmit("/user/savePointExchange",$("#savePointExchangeForm").serialize(),function(data){
			dialog(data.msg,function(){
				if(data.code==1)f5();
			});
		});
	});
}
</script>
</body>
</html>