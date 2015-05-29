<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<style type="text/css">
	table{
		width: 96%; margin-left: 20px;border:1px solid #DEDEDE;
	}
	td {
	    text-align: center;
	}
	thead tr {
		background: #DEDEDE;
		height: 40px;
	}
	.pg_title .pg_name,.pg_title  .pg_price,.pg_title .pg_count{
		width:33.33%;
	}
	.pg_body .pg_name,.pg_body  .pg_price,.pg_body .pg_count{
		width:33.33%;
	}
</style>
</head>
<body>
<div class="rightContainer">
	<!--// 标题 //-->
    <h3 class="rc_title">
    	商品评论<a href="user/home">我的主页</a>
    </h3>
    <div class="rc_body">
    	<c:forEach items="${detailGroup}" var="detailGroup"  varStatus="status">
    	<div class="rc_pg" id="rc_pg_${status.index}">
    		<div class="pinglun_goods disnone">
	    		<div class="pg_title">
	    			<!-- <span class="pg_img">商品</span> -->
	    			<span class="pg_name">规格</span>
	    			<span class="pg_price">价格</span>
	    			<span class="pg_count">数量</span>
	    			<!-- <span class="pg_status">交易状态</span> -->
	    		</div>
	    		<c:forEach items="${detailGroup.value}" var="item">
	    			<c:set var="totalAmount"  value="${item.quantity+totalAmount}"/>
		    		<c:set var="totalMoney"  value="${item.unitPrice+totalMoney}"/>
		    		<c:set var="goodsPic"  value="${item.goodsPic}"/>
		    		<c:set var="goodsName"  value="${item.goodsName}"/>
		    		<c:set var="goodsID"  value="${item.goodsID}"/>
		    		<c:set var="ordtailId"  value="${item.ID}"/>
		    		<c:set var="isEvaluate"  value="${item.evaluate}"/>
		    		<div class="pg_body">
			    		<%-- <div class="pg_img"><a href="goods/detail?goodsId=${item.goodsID}"><img src="${item.goodsPic}" height="60" width="60" /></a></div> --%>
			    		<div class="pg_name">${item.propertystrname}</div>
			    		<div class="pg_price"><font color="#ff4400">&yen;${item.unitPrice}</font></div>
			    		<div class="pg_count">${item.quantity }</div>
			    		<!-- <div class="pg_status"><font color="#ff4400">交易成功</font></div> -->
		    		</div>
	    		</c:forEach>
	    	</div>
	    	<table class="head_table disnone"  data-fordiv="rc_pg_${status.index}">
		    	<thead><tr><td>商品图片</td><td>商品名称</td><td>商品交易总额</td><td>商品交易总数量</td><td>商品交易详情</td></tr></thead>
		    	 <tbody>
		    		<tr>
			    		<td><a href="goods/detail?goodsId=${goodsID}"><img src="${item.goodsPic}" height="60" width="60" /></a></td>
			    	    <td><a href="goods/detail?goodsId=${goodsID}">${goodsName}</a></td>
			    	    <td ><font color="#ff4400">&yen;${totalMoney}</font></td>
			    	    <td><font color="#ff4400">${totalAmount}</font></td>
			    	    <td><input value="查看详情" class="view_detail" type="button"/></td>
		    	    </tr>
		    	</tbody>
	  		</table>
	    	<!-- 提交评论框 -->
	    	<div class="commandSubmitBox comment_box_${status.index}">
	       		<div>评分：
	       		<c:forEach  begin="1" end="5">
	       			<img src="img/star2.png"  class="grade red" data-box="comment_box_${status.index}"/>
	       		</c:forEach>
	       		&nbsp;&nbsp;<span class="sum_red_star">5</span>星
	       		</div>
	       		<div><textarea rows="" cols="" class="submitTextArea"></textarea></div>
	       		<div><button data-id="${ordtailId}" class="tijiaoPingLun" data-box="comment_box_${status.index}">提交评论</button></div>
	        </div>
	        <div class="disnone control_show" data-show="${isEvaluate}"></div> 
	        		<c:set var="totalAmount"  value="0"/>
		    		<c:set var="totalMoney"  value="0"/>
		    		<c:set var="goodsPic"  value=""/>
		    		<c:set var="goodsName"  value=""/>
		    		<c:set var="goodsID"  value=""/>
		    		<c:set var="ordtailId"  value=""/>
		    		<c:set var="isEvaluate"  value=""/>
    	</div>
    	</c:forEach>
    </div>
</div>
<script type="text/javascript">
	$(function(){
		/**************页面初始化开始****************************/
		// 移除已评论过的商品
		$(".control_show").each(function(i,n){
			if($(n).data("show")){
				$(n).parent().remove();
			}
		});
		
		// 订单商品已评论完就跳转到订单列表页
		var len = $(".rc_pg").length;
		if(len === 0){
			dialog("亲，您已经评价过该订单了！");
			setTimeout(function (){
				window.location.href = "/user/order";
			}, 1000);
		}
		
		// 移动表格
		$(".head_table").each(function(i,n){
			var id = $(n).data("fordiv");
			$(n).removeClass("disnone");
			$("#"+id).children(":first").before($(n));
		});
		/**************页面初始化结束****************************/
		
		
		
		// 查看详情
		$(".view_detail").click(function(){
			var id = $(this).parents("table").data("fordiv");
			var $parent = $("#"+id);
			$(".pinglun_goods",$parent).toggleClass("disnone");
		});
		
		// 评分
		$(".grade").click(function(){
			var that = $(this);
			var $comment_box = $("."+that.data("box"));
			var hasRed = that.hasClass("red");
			if(hasRed){
				that.nextAll().removeClass("red").each(function(i,n){
					if(n.src){
						var src = (n.src).replace("star2","star1");
						n.src = src;
					}
				});
			}else{
				that.prevAll().andSelf().addClass("red").each(function(i,n){
					var src = (n.src).replace("star1","star2");	
					n.src = src;
				});
			}
			var count = $(".red",$comment_box).length;
			$(".sum_red_star",$comment_box).text(count);
		});
		
		// 提交评论
		$(".tijiaoPingLun").click(function(){
			var that = $(this);
			var $comment_box = $("."+that.data("box"));
			
			// 获取参数
			var json = {};
			json.orderDetailId = that.data("id");
			json.score = $(".sum_red_star",$comment_box).text();
			json.content = $.trim($(".submitTextArea",$comment_box).val());

			// 前台验证
			var len = (json.content).length;
			if(len === 0 || len > 200){
				dialog("请发表0到200个字符范围内的评论");
			}

			// 发送请求
			$.post("/goods/ajax/post/comment",json,function(data){
				if(data.code === 1){
					that.parent().hide();
					$(".submitTextArea",$comment_box).parent().html("评论：&nbsp;&nbsp;"+json.content).prev().children("img").unbind("click");
				}else{
					dialog(data.msg);
				}
			})
		});
	})
</script>
</body>
</html>