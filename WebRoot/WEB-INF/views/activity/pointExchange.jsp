<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>积分兑换</title>
<link type="text/css" rel="stylesheet" rev="stylesheet" href="/css/pointExchange.css" />
</head>
<body style="background-color:#ffffff;">
<!--** 顶部banner **-->
<div class="jfTopBanner"></div>
<!--** 登录状态下显示用户头像，积分 **-->
<c:if test="${!empty sessionScope.sessionUser}">
	<div class="userJiFen">
		<div class="ujfInside">
			<div class="ujfImg disnone"><img src="${sessionScope.sessionUser.avatar}" height="140" width="140" /></div>
			<div class="ujfInfo">
				<p><font size="+2">${sessionUser.username }</font></p>
			</div>
		</div>
	</div>
</c:if>
<div class="jfTitle">智谷会员积分介绍</div>
<div class="jfBody">
	<p>1.充值可得1：1积分</p>
	<p>2.在智谷同城货源网上购买商品可得100：1积分，购买服务可得1：1积分</p>
	<p>3.从即日起到1月10日注册成功即送<font color="#ff3300"><strong>150</strong></font>积分（成功注册判定条件必须实名认证），推荐成功一个即送<font color="#ff3300"><strong>200</strong></font>积分（成功注册判定条件必须实名认证）</p>
    <p><a href="user/recharge" class="abg_red">去充值获得积分</a><a href="http://www.zhiguw.com" class="abg_yellow">去购物获得更多积分</a><a href="http://www.zhiguw.com/register" class="abg_red">去注册</a><a href="http://www.zhiguw.com/user/recommend" class="abg_red">去推荐</a></p>
</div>
<!--** 兑换商品列表 **-->
<div class="jfTitle">精选积分兑换商品（兑完即止）</div>
<div class="jfTitle">
	<span class="fl">积分排序：</span>
	<span style="margin-top: 10px;" class="<c:choose><c:when test="${page.orderBy==10 }">sortUp_2</c:when><c:otherwise>sortUp_1</c:otherwise></c:choose>"  onclick="sort(10);"></span>
	<span style="margin-top: 10px;" class="<c:choose><c:when test="${page.orderBy==11 }">sortDown_2</c:when><c:otherwise>sortDown_1</c:otherwise></c:choose>" onclick="sort(11);"></span>
</div>
<div class="jfList">
	<div class="jfListInside">
		<c:forEach items="${pointExchangeGoods }" var="pg">
			<div class="jfListBoxes">
				<div style="height: 220px;"><a href="activity/pointGoodsDetails?pointGoodsID=${pg.id }"><img src="${pg.picture}"  width="220" height="220"/></a></div>
				<h3><a href="activity/pointGoodsDetails?pointGoodsID=${pg.id }">${pg.name }</a></h3>
				<p>库存：<font color="#00a000">${pg.repertory }</font><span class="fr disnone">价值：￥<font color="#ff3300"><strong>${pg.money }</strong></font></span></p>
				<p>需<font size="+1" color="#ff4400"> ${pg.needPoint } </font>积分 (${pg.pointTypeLabel})</p>
				<c:if test="${ pg.repertory >0}" >
					<a href="javascript:void(0);" class="abg_red" onclick="pointExchange(${pg.id},this)" title="${pg.name }">兑换</a>
				</c:if>
				<c:if test="${ pg.repertory <1}" >
					<a href="javascript:void(0);" class="abg_gray" >已兑换结束</a>
				</c:if>
			</div>
		</c:forEach>
	</div>
	<div class="ddpage fr mt20">
		<jsp:include page="../include/page.jsp">
			<jsp:param name="request" value="url"/>
			<jsp:param name="requestUrl" value="activity/pointExchangePage?orderBy=${page.orderBy }"/>
		</jsp:include>
	</div>
	<br style="clear:both;" />
</div>
<div id="infoInputDiv" class="easyui-dialog" closed="true" modal="true" title="信息填写" style="width:500px;height:370px;">
	<div class="duihuanbox">
	<form id="savePointExchangeForm">
	<p class="red">* 请准确填写收货地址，否则可能收不到兑换物品。</p>
	<p><span>兑换：</span ><d id="changeGood"></d></p>
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
function pointExchange(id,obj){
	$("#changeGood").html($(obj).prop("title"));
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
function sort(orderBy){
	window.location.href='activity/pointExchangePage?orderBy='+orderBy;
}
</script>
</body>
</html>
