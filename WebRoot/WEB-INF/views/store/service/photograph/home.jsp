<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" media="all" href="css/basic.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/secondCate.css" />
<title>${store.storeName }</title>
</head>
<body>
<!--** 商家信誉 **-->
<div class="shangJiaTag">
	<div class="sjTagKey">店铺名：</div>
    <div class="sjTagValue">${store.storeName }</div>
    <div class="sjTagImg"><span class="ml10 xinyuml levelPoint">${store.levelPoint }</span></div>
    <div class="sjTagKey">电话：</div>
    <div class="sjTagValue">${store.phone }</div>
    <div class="sjTagValue" style="padding-top:10px;">
    	<c:if test="${not empty store.QQ }">
         	<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${store.QQ }&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${store.QQ}:52" alt="点这里给我发消息" /></a>
        </c:if>
        <c:if test="${not empty store.aliWangWang }">
         	<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${store.aliWangWang}&site=cntaobao&s=2&charset=utf-8" ><img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid=${store.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a>
        </c:if>
    </div>
</div>
<!--** 装修商家主页导航 **-->

<!--** 装修banner **-->
<div class="zhuangXiuBanner" style="background:url('img/photograph/store_top_banner.jpg');"></div>
<!--** 价值观 **-->
<div class="jiaZhiGuan">
	<div class="jzgInside">
    	<div class="txtTitle"><h3>我们的<span class="ce81268">价值观</span></h3><p>精心致力与视觉效果的打造，将视觉引导转化为流量</p></div>
        <div class="imgIntro">
        	<div>
                <p><img src="img/jzg_yuanjing.gif" height="91" width="91" /></p>
                <h3><span class="c333">愿景</span></h3>
                <p>与客户共同成长，您的成功<br />才是我们最大的收获</p>
            </div>
            <div>
                <p><img src="img/jzg_hexin.gif" height="91" width="91" /></p>
                <h3><span class="c333">愿景</span></h3>
                <p>让我们的客户有更好的设计体现，<br />实现视觉的效益转换</p>
            </div>
            <div>
                <p><img src="img/jzg_kehu.gif" height="91" width="91" /></p>
                <h3><span class="c333">愿景</span></h3>
                <p>只有客户的收获才是我们的<br />收获，与您共同成长</p>
            </div>
            <div>
                <p><img src="img/jzg_fuwu.gif" height="91" width="91" /></p>
                <h3><span class="c333">愿景</span></h3>
                <p>为每一位选择我们的客户<br />提供最优质的服务</p>
            </div>
        </div>
    </div>
</div>
<!--** 我们的案例 **-->
<div class="ourCase">
	<div class="jzgInside">
    	<div class="txtTitle"><h3>我们的<span class="ce81268">案例</span></h3></div>
        <div class="caseBox">
        	<c:forEach items="${page.datas }" var="g">
	        	<div class="caseInfo">
	            	<div class="caseImg"><a href="goods/detail?goodsId=${g.id }" target="_blank"><img src="${g.image300}" alt="智谷视觉" height="260" width="260" /></a></div>
	                <div class="caseTxtBar">${g.name }</div>
	                <div class="caseTxtBarBg"></div>
	            </div>
        	</c:forEach>
        </div>
    </div>
</div>
<!--** 我们的优势 **-->
<div class="clear"></div>
<div class="ourAdvant">
	<div class="jzgInside">
    	<div class="txtTitle"><h3>我们的<span class="ce81268">优势</span></h3></div>
        <div><img src="img/photograph/store_foot_banner.jpg" /></div>
    </div>
</div>
<script type="text/javascript">
//收藏店铺
function favoritestore(storeID){
	$.ajax({
		url:"/user/favourite/addFavouriteStore",
		data:{"storeID":storeID},
		dataType:"json",
		cache:false,
		success:function(json){
			if(json.error==0){
				$("#favouriteStore_div1").html("<input type='button' value='已收藏' class='jrdp cp' />");
				$("#favouriteStore_div").html("<input type='button' value='已收藏' class='jrdp cp' />");
			}
			dialog(json.msg,null,null,null,null);
		}
	});
};
</script>
</body>
</html>