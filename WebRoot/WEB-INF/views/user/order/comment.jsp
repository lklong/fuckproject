<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>商品评论</title>
<script type="text/javascript" src="/js/3rdparty/layer1.9/layer.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">商品评论</h4>
  <c:forEach items="${detailGroup}" var="detailGroup"  varStatus="status">
    <div class="rc_pg" id="rc_pg_${status.index}">
      <div class="pinglun_goods hidden">
        <table cellpadding="0" cellspacing="0" class="user-list-table no-margin-top-bottom">
          <tr>
          <th style="width:40%">规格</th>
          <th style="width:30%">价格</th>
          <th style="width:30%" class="no-right-border">数量</th>
          </tr>
        </table>
        <c:forEach items="${detailGroup.value}" var="item">
          <c:set var="totalAmount"  value="${item.quantity+totalAmount}"/>
          <c:set var="totalMoney"  value="${item.unitPrice+totalMoney}"/>
          <c:set var="goodsPic"  value="${item.goodsPic}"/>
          <c:set var="goodsName"  value="${item.goodsName}"/>
          <c:set var="goodsID"  value="${item.goodsID}"/>
          <c:set var="ordtailId"  value="${item.ID}"/>
          <c:set var="isEvaluate"  value="${item.evaluate}"/>
          <table cellpadding="0" cellspacing="0" class="user-list-table no-margin-top-bottom txt-center">
            <tr>
            <td style="width:40%">${item.propertystrname}</td>
            <td style="width:30%"><font color="#ff4400">&yen;${item.unitPrice}</font></td>
            <td style="width:30%">${item.quantity }</td>
            </tr>
          </table>
        </c:forEach>
      </div>
      <table class="head_table user-list-table txt-center"  data-fordiv="rc_pg_${status.index}" cellpadding="0" cellspacing="0">
        <thead>
          <tr>
            <th>商品图片</th>
            <th>商品名称</th>
            <th>商品交易总额</th>
            <th>商品交易总数量</th>
            <th class="no-right-border">商品交易详情</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><a href="goods/detail?goodsId=${goodsID}" target="_blank"><img src="${item.goodsPic}" height="60" width="60" /></a></td>
            <td><a href="goods/detail?goodsId=${goodsID}" target="_blank">${goodsName}</a></td>
            <td ><font color="#ff4400">&yen;${totalMoney}</font></td>
            <td><font color="#ff4400">${totalAmount}</font></td>
            <td><input value="查看详情" class="view_detail input-button" type="button"/></td>
          </tr>
        </tbody>
      </table>
      <!-- 提交评论框 -->
      <div class="commandSubmitBox comment_box_${status.index}">
        <div class="mt10">评分：
          <c:forEach  begin="1" end="5"> <img src="/img/default/star2.png"  class="grade red" data-box="comment_box_${status.index}"/> </c:forEach>
          &nbsp;&nbsp;<span class="sum_red_star">5</span>星 </div>
        <div class="mt10">
          <textarea rows="" cols="" class="input-textarea submitTextArea"></textarea>
        </div>
        <div class="mt10">
          <input data-id="${ordtailId}" class="input-button tijiaoPingLun" type="button" data-box="comment_box_${status.index}" value="提交评论" />
        </div>
      </div>
      <div class="hidden control_show" data-show="${isEvaluate}"></div>
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
			layer.alert("亲，该订单下的商品已评价完成，将自动跳转到订单列表页！");
			setTimeout(function (){
				window.location.href = "/user/order";
			}, 3000);
		}
		
		// 移动表格
		$(".head_table").each(function(i,n){
			var id = $(n).data("fordiv");
			$(n).removeClass("hidden");
			$("#"+id).children(":first").before($(n));
		});
		/**************页面初始化结束****************************/
		
		
		
		// 查看详情
		$(".view_detail").click(function(){
			var id = $(this).parents("table").data("fordiv");
			var $parent = $("#"+id);
			$(".pinglun_goods",$parent).toggleClass("hidden");
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
				layer.alert("请发表0到200个字符范围内的评论");
			}

			// 发送请求
			$.post("/goods/ajax/post/comment",json,function(data){
				if(data.code === 1){
					that.parent().hide();
					$(".submitTextArea",$comment_box).parent().html("评论：&nbsp;&nbsp;"+json.content).prev().children("img").unbind("click");
				}else{
					layer.alert(data.msg);
				}
			})
		});
	})
</script>
</body>
</html>