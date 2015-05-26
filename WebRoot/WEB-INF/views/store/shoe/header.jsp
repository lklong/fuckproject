<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--** 顶部商家信息 **-->
<div class="shopInfoTop">
	<div class="intoTopInside">
		<div class="infoTopLeft">
			<div class="infoTopImg">
				<a href="store/index?storeId=${store.ID}"><img src="${store.logoPath}" height="75" width="75" /></a>
			</div>
			<div class="infoTopText">
				<h3><a style="font-size:24px;font-weight:blod;" href="store/index?storeId=${store.ID}">${store.storeName }</a></h3>
				<p style="font-size:12px;">直达域名：${store.domain }.zhiguw.com</p>
				<p style="font-size:12px;">等级：<span class="ml10 xinyuml levelPoint">${store.levelPoint }</span></p>
			</div>
		</div>
		<div class="infoTopRight">
				<a style="display:none;" href="javascript:void(0)" onclick="addFav();">添加到收藏夹</a>
				<a id="wsc" class="add_shop" href="javascript:void(0)" onclick="favoStore(${store.ID})" >收藏店铺</a>
				<a id="ysc" class="add_shop" href="javascript:void(0)" >已收藏</a>
				<p style="font-size:16px;padding-top:40px;font-weight:blod;">
				<strong>
					<c:if test="${not empty store.phone }">TEL：${store.phone }</c:if>&nbsp;&nbsp;&nbsp;&nbsp;
					<c:if test="${not empty store.QQ  }">QQ：${store.QQ }
						<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${store.QQ }&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${store.QQ}:52" alt="点这里给我发消息" /></a>
					</c:if>
					<c:if test="${not empty store.aliWangWang }">
						旺旺：${store.aliWangWang }
						<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${store.aliWangWang}&site=cntaobao&s=2&charset=utf-8">
							<img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid=${store.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a>
					</c:if>
				</strong>
				</p>
			<table border="0" cellspacing="0" cellpadding="0" style="display:none;">
				<tr>
					<!-- 个人认证 -->
					<td  id="geren_renzheng_area" >&nbsp;&nbsp;</td>
					<!-- 店铺认证 -->
					<c:if test="${store.realStoreAuth==1 }"><td><span id="dianpu_renzheng"></span>&nbsp;&nbsp;</td></c:if>
					<!-- 企业认证 -->
					<c:if test="${store.companyAuth==1 }"><td><span id="qiye_renzheng"></span>&nbsp;&nbsp;</td></c:if>
				</tr>
			</table>
		</div>
		<div class="shopTopNav">
			<div class="shopNavInside">
				<ul>
					<li><a href="store/index?storeId=${store.ID}">店铺首页</a></li>
					<li><a href="store/intro?storeId=${store.ID}">商家介绍</a></li>
					<li><a href="store/notice?storeId=${store.ID }">商家公告</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function addFav() { // 加入收藏夹 
	var sURL = window.location.href; 
	var sTitle = document.title;
	try{ 
		window.external.addFavorite(sURL, sTitle);
	} catch (e){
		try{ 
			window.sidebar.addPanel(sTitle, sURL, "");
		} catch (e){ 
			alert("加入收藏失败，请使用Ctrl+D进行添加");
		 }
	}
}
$(function(){
	/* 禁用在线咨询 */
	$('#qq_hover').remove();
	
	
	$.get("/store/info",{"storeId":"${store.ID}"},function(msgBean){
		if(msgBean.code==zhigu.code.success){
			if(msgBean.data.isRealUserAuth){
				$("#geren_renzheng_area").prepend("<span id='geren_renzheng'></span>");
			}
		}
	});
	if (zhigu.isLogin=='true') {
		ajaxSubmit("/user/favourite/query", {"fID":"${store.ID}","type":1}, function(msgBean){
			if(msgBean.code==zhigu.code.success){
				if(msgBean.data){
					$("#wsc").hide();
					$("#ysc").show();
				}else{
					$("#wsc").show();
					$("#ysc").hide();
				}
			}
		});
	}else{
		$("#wsc").show();
		$("#ysc").hide();
	}
})
</script>