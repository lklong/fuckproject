<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的收藏</title>
<link href="/css/wangshang.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="rightContainer">
		<!--// 标题 //-->
		<h3 class="rc_title">
			我的收藏<a href="user/home">我的主页</a>
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<!--// tab切换条 //-->
			<div id="userCommTab" class="userCommTab">
				<ul>
					<li><a href="javascript:void(0);" class="uctSelected">收藏的商品</a></li>
					<li><a href="/user/favourite/favouritestore" >收藏的店铺</a></li>
				</ul>
			</div>
			<div id="userContents" class="userContents">
				<!--// 内容1 //-->
				<div class="body_center2">
					<div class="shoucang">
						<div class="quanbu mt10">
							<h4>
								全部<span>${fn:length(goodsList) }</span>
							</h4>
						</div>
						<div class="caozuo">
							<span class="caozuospan"> <input type="checkbox" id="deletshou" /> <label for="deletshou">全部</label>
							</span> <span class="caozuospan"> <span class="icons"></span> <a href="javascript:void(0);" onclick="zhigu.delFavouriteGoods();">删除</a>
							</span>
						</div>
						<div class="scshangpin" id="scshangpin">
								<ul>
									<c:if test="${empty goodsList }">
										<strong>暂无收藏！</strong>
									</c:if>
									<c:forEach var="goods" items="${ goodsList}">
										<li class="${goods.id}"><a target="_blank" href="goods/detail?goodsId=${goods.id}">
													<div class="scshangpinbox"><img src="${goods.image300}" title="${goods.name}" /></div>
												</a>
												<p class="sbmingai120a">
													<input type="checkbox" class="ver_ali " name="goodsID" value="${goods.id }" /> <a target="_blank" href="goods/detail?goodsId=${goods.id}">${goods.name}</a>
												</p>
												<p class="tuijianprice">${goods.minPrice }-${goods.maxPrice }</p>
												<p>
													<a target="_blank" href="goods/detail?goodsId=${goods.id}" title="立即购买" class="icon1"></a> <a target="_blank" href="store/index?storeId=${goods.storeId}" title="进入店铺" class="icon2"></a> 
													<a  onclick="zhigu.delFavouriteGoods(${goods.id });" title="删除" class="icon3"></a>
												</p>
										</li>
									</c:forEach>
								</ul>
							<div class="clear"></div>
						</div>
					</div>
				</div>
			</div>
			<br style="clear: both;" />
		</div>
	</div>
	<div class="clear"></div>
	<script type="text/javascript">
	if (typeof zhigu == "undefined" || !zhigu) {
	    var zhigu = {};
	}
		$(function() {
			$("#deletshou").click(function() {
				if ($("#deletshou").is(":checked")) {
					$("#scshangpin input:checkbox").attr("checked", true);
				} else {
					$("#scshangpin input:checkbox").attr("checked", false);
				}
			});
		})
		zhigu.delFavouriteGoods = function(goodId){
			var goodIds = [];
			if(isNaN(goodId)){
				$("#scshangpin input[type='checkbox']:checked").each(function(){
					goodIds.push($(this).val());
				});
			}else{
				goodIds.push(goodId);
			}
			if(goodIds.length>0){
				ajaxSubmit("user/favourite/delFavouriteGoods",{"goodsID":goodIds},function(msgBean){
					if(msgBean.code==zhigu.code.success){
	       				layer.alert(msgBean.msg,1);
						$("."+goodIds).remove();
		       	  }else{
		       		  parent.layer.alert(msgBean.msg,0);  
		       	  }
				});
			}
		}
	</script>
</body>
</html>
