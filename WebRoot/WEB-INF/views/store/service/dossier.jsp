<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" media="all" href="css/basic.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/secondCate.css" />
<title>装修服务详情</title>
</head>
<body>
<!--** 装修商家主页导航 **-->
<jsp:include page="../../store/service/menu.jsp"></jsp:include>
<div class=""></div>
<!--** 当前位置 **-->
<!--** 详情页主体 **-->
<div class="webpage pageMain">
	<jsp:include page="../../store/service/storeInfo.jsp"></jsp:include>
    <div class="pageRightBox">
    	<div class="sbjieshao">
		<div class="right_sider">
			<h4 class="jj_h4 f16">公司简介</h4>

			<div class="papa ml20 mt20">
				<h4 class="mb20">${companyAuth.companyName }</h4>
				<p class="gsjs">${introduction }</p>
				<div class="rz_table mt10">
					<div>开店时间：${openStoreDate }</div>
					<div>商品数量：${store.commodityOnSaleTotal }</div>

					<p class="clear pt10">所在批发市场：${address }</p>
				</div>
			</div>
			<div class="clear"></div>
			<!----------------------------------------------------认证信息--------------------------------------------------->
			<div class="rz_wrap mt10">
				<h4 class="jj_h4 f16">认证信息</h4>
				<div class="rz_table_1">
					<h4>企业身份认证信息 
						<c:choose>
							<c:when test="${companyAuth.status!=2}"><span class="red">*未认证</span></c:when>
						</c:choose>
						</h4>
					<c:if test="${companyAuth.status==2}">
					<table>
						<tr>
							<td class="bg_col">企业名称</td>
							<td>${companyAuth.companyName }</td>
							<td class="bg_col">企业类型</td>
							<td>${companyType }</td>
						</tr>
						<tr>
							<td class="bg_col">工商注册号</td>
							<td>${companyAuth.regNumber }</td>
							<td class="bg_col">企业法人</td>
							<td>${companyAuth.corporation }</td>
						</tr>
						<tr>
							<td class="bg_col">营业期限</td>
							<td><fmt:formatDate value="${companyAuth.businessTerm}"  pattern="yyyy-MM-dd"/></td>
							<td class="bg_col">注册资金</td>
							<td>${companyAuth.capital}</td>
						</tr>
						<tr>
							<td class="bg_col">营业范围</td>
							<td>${companyAuth.businessScope}</td>
							<td class="bg_col">注册地址</td>
							<td>${companyAuth.regProvince}-${companyAuth.regCity}-${companyAuth.regDistrict}-${companyAuth.regStreet}</td>
						</tr>
						<tr>
							<td class="bg_col">经营地址</td>
							<td>${companyAuth.companyProvince}-${companyAuth.companyCity}-${companyAuth.companyDistrict}-${companyAuth.companyStreet}</td>
						</tr>
					</table>
					<ul>
						<li class="rz_img"><img src="${companyAuth.imageSmall}" /></li>
					</ul>
					</c:if>
					<div class="clear"></div>
				</div>
				<div class="rz_table_1">
					<h4>实体认证信息
						<c:choose>
							<c:when test="${realStoreAuth.status!=2}"><span class="red">*未认证</span></c:when>
						</c:choose>
					</h4>
					<c:if test="${realStoreAuth.status==2}">
					<table>
						<tr>
							<td class="bg_col">实体名称</td>
							<td>${realStoreAuth.realStoreName}</td>
							<td class="bg_col">经营人</td>
							<td>${realStoreAuth.master }</td>
						</tr>
						<tr>
							<td class="bg_col">联系电话</td>
							<td>${realStoreAuth.phone }</td>
							<td class="bg_col">实体地址</td>
							<td>${realStoreAuth.realStoreAddress }</td>
						</tr>
					</table>
					<ul>
						<li class="rz_img"><img src="${realStoreAuth.image1 }" />
							<p>照片1</p></li>
						<li class="rz_img"><img src="${realStoreAuth.image2 }" />
							<p>照片1</p></li>
						<li class="rz_img"><img src="${realStoreAuth.image3 }" />
							<p>照片1</p></li>
					</ul>
					</c:if>
					<div class="clear"></div>
				</div>
			</div>
		</div>
	</div>
    </div>
	<br style="clear:both;" />
</div>
<!--** 左侧信息和右侧商品详情 **-->
<div class="webpage goodsInfoBox">
	<div class="gibLeft">
        <!--** 目前不需要被隐藏起来 **-->
    	<div class="gibChuHuo disnone">
			<div class="gibCHInside">
            	<a href="#" target="_blank" class="gibCHCur">出货量</a>
                <a href="#" target="_blank">收藏量</a>
            </div>
            <br /><br />
            <dl>
            	<dt><a href="#" target="_blank"><img src="img/pic_demo3.jpg" height="73" width="73" /></a></dt>
                <dd><a href="#" target="_blank">美丽雅0019212</a></dd>
                <dd><span class="ce81268">¥52.00 - ¥102.00 </span></dd>
                <dd>已出货 <span class="cff5200">3506</span> 笔</dd>
            </dl>
            <dl>
            	<dt><a href="#" target="_blank"><img src="img/pic_demo3.jpg" height="73" width="73" /></a></dt>
                <dd><a href="#" target="_blank">美丽雅0019212</a></dd>
                <dd><span class="ce81268">¥52.00 - ¥102.00 </span></dd>
                <dd>已出货 <span class="cff5200">3506</span> 笔</dd>
            </dl>
            <dl>
            	<dt><a href="#" target="_blank"><img src="img/pic_demo3.jpg" height="73" width="73" /></a></dt>
                <dd><a href="#" target="_blank">美丽雅0019212</a></dd>
                <dd><span class="ce81268">¥52.00 - ¥102.00 </span></dd>
                <dd>已出货 <span class="cff5200">3506</span> 笔</dd>
            </dl>
            <dl>
            	<dt><a href="#" target="_blank"><img src="img/pic_demo3.jpg" height="73" width="73" /></a></dt>
                <dd><a href="#" target="_blank">美丽雅0019212</a></dd>
                <dd><span class="ce81268">¥52.00 - ¥102.00 </span></dd>
                <dd>已出货 <span class="cff5200">3506</span> 笔</dd>
            </dl>
            <dl>
            	<dt><a href="#" target="_blank"><img src="img/pic_demo3.jpg" height="73" width="73" /></a></dt>
                <dd><a href="#" target="_blank">美丽雅0019212</a></dd>
                <dd><span class="ce81268">¥52.00 - ¥102.00 </span></dd>
                <dd>已出货 <span class="cff5200">3506</span> 笔</dd>
            </dl>
		</div>
        <div class="gibHotSale disnone">
        	<div>更多热销</div>
          	<dl>
            	<dt><a href="#" target="_blank"><img src="img/pic_demo4.jpg" height="158" width="158" /></a></dt>
                <dd><a href="#" target="_blank">美丽雅0019212</a></dd>
                <dd><span class="ce81268">¥52.00 - ¥102.00 </span></dd>
            </dl>
            <dl>
            	<dt><a href="#" target="_blank"><img src="img/pic_demo4.jpg" height="158" width="158" /></a></dt>
                <dd><a href="#" target="_blank">美丽雅0019212</a></dd>
                <dd><span class="ce81268">¥52.00 - ¥102.00 </span></dd>
            </dl>
            <dl>
            	<dt><a href="#" target="_blank"><img src="img/pic_demo4.jpg" height="158" width="158" /></a></dt>
                <dd><a href="#" target="_blank">美丽雅0019212</a></dd>
                <dd><span class="ce81268">¥52.00 - ¥102.00 </span></dd>
            </dl>
            <dl>
            	<dt><a href="#" target="_blank"><img src="img/pic_demo4.jpg" height="158" width="158" /></a></dt>
                <dd><a href="#" target="_blank">美丽雅0019212</a></dd>
                <dd><span class="ce81268">¥52.00 - ¥102.00 </span></dd>
            </dl>
            <dl>
            	<dt><a href="#" target="_blank"><img src="img/pic_demo4.jpg" height="158" width="158" /></a></dt>
                <dd><a href="#" target="_blank">美丽雅0019212</a></dd>
                <dd><span class="ce81268">¥52.00 - ¥102.00 </span></dd>
            </dl>
        </div>
    </div>
</div>
<div class="clear"></div>
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