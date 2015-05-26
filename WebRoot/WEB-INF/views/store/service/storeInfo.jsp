<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pageLeftBox">
   	<div class="plbInside">
       	<div class="mt15 plbImg"><img width="120" height="120" src="${store.logoPath}" /></div>
<!--            <div class="plbInfo"> -->
<!--            	<div class="plbInfoKey">信　　誉：</div> -->
<!--                <div class="plbInfoValue"><span class="ml10 xinyuml levelPoint">${store.levelPoint }</span></div> -->
<!--            </div> -->
           <div class="plbInfo">
           	<div class="plbInfoKey">店　　家：</div>
               <div class="plbInfoValue">${store.storeName }</div>
           </div>
           <div class="plbInfo">
           	<div class="plbInfoKey">好 评 率 ：</div>
               <div class="plbInfoValue"><span class="ce81268">100%</span></div>
           </div>
           <div class="plbInfo">
           	<div class="plbInfoKey">商品总数：</div>
               <div class="plbInfoValue"><span>${store.commodityOnSaleTotal }</span></div>
           </div>
           <div class="plbInfo">
           	<div class="plbInfoKey">联系方式：</div>
               <div class="plbInfoValue">
               	<c:if test="${not empty store.QQ }">
		         	<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${store.QQ }&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${store.QQ}:52" alt="点这里给我发消息" /></a>
		        </c:if>
		        <c:if test="${not empty store.aliWangWang }">
		         	<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${store.aliWangWang}&site=cntaobao&s=2&charset=utf-8" ><img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid=${store.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a>
		        </c:if>
               </div>
           </div>
           <%-- <div class="plbInfo" >
           	<div class="marked" id="storeFav"><a href="javascript:void(0)" onclick="favoritestore(${store.ID});">收藏本店</a></div>
           </div> --%>
       </div>
   </div>