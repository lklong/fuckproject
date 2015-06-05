<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="changeDiv">
  <ul>
    <li style="cursor: pointer;" class="pingLunSelected all" data-type="all">全部评价(${commentCountMap.all})</li>
    <li style="cursor: pointer;" class="good" data-type="good">好评(${commentCountMap.good})</li>
    <li style="cursor: pointer;" class="medium" data-type="medium">中评(${commentCountMap.medium})</li>
    <li style="cursor: pointer;" class="bad" data-type="bad">差评(${commentCountMap.bad})</li>
  </ul>
</div>
<form action="/goods/ajax/comments" id="evaluateForm" style="display:none">
  <input name="goodsId" value="${goodsId}">
  <input  name="commentType" id = "commentType" value="${type}">
</form>
<!--** 商品评论框 **-->
<div id="evaluateList">
  <c:forEach items="${page.datas}" var="comment">
    <div class="pingLunCommandBox type_${comment.type}">
      <div class="commandLeft">
        <p><img src="${comment.avatar}" width="80" height="80" /></p>
        <p>${comment.userName}</p>
      </div>
      <div class="commandRight">
        <div>
          <h3> <span>
            <fmt:formatDate value="${comment.addTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
            发布“评价”</span>
            <c:forEach var="i" begin="1" end="${comment.score}"> <img src="img/default/star2.png" /> </c:forEach>
            &nbsp;&nbsp;${comment.score}星 </h3>
          ${comment.content}
          <c:if test="${canReply==1&&comment.merchantReply==null}">
            <input type="button" value="回复" class="reply reply_btn" >
          </c:if>
        </div>
        <c:if test="${comment.merchantReply!=null}">
          <p>回复：${comment.merchantReply}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;回复时间：
            <fmt:formatDate value="${comment.replyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
          </p>
        </c:if>
        <p class="reply_p hidden">
          <textarea class="reply_text" data-id="${comment.id}" placeholder="200个字符内"></textarea>
          <input type="button" value="确认回复" class="reply confirm_reply_btn" style="margin-top:36px" >
        </p>
      </div>
    </div>
  </c:forEach>
</div>
<!--** 提交评论框**--> 
<!-- <div class="commandSubmitBox disnone">
  <div>评分：<img src="img/default/star2.png" /><img src="img/default/star2.png" /><img src="img/default/star2.png" /><img src="img/default/star2.png" /><img src="img/default/star2.png" />&nbsp;&nbsp;5星</div>
  <div>用户名：西西</div>
  <div>
    <textarea rows="" cols="" class="submitTextArea"></textarea>
  </div>
  <div>
    <input type="button" class="input-button" value="提交评论"/>
  </div>
</div>
<div class="clear"></div> -->
<div class="ddpage fr mt20">
  <jsp:include page="../../include/page.jsp">
  <jsp:param name="request" value="ajax"/>
  <jsp:param name="requestForm" value="evaluateForm"/>
  </jsp:include>
</div>
<script type="text/javascript">
			$(function(){
				// 评论分类加载
				$(".changeDiv ul li").on('click',function(){
					var that = $(this);
					var type = that.data("type");
					$(".pingLunBox").load("/goods/ajax/comments",{commentType:type,goodsId:"${goodsId}"});			
				});
				
				// 初始化
				$(".${type}").addClass("pingLunSelected").siblings().removeClass("pingLunSelected");
				
				// 分页事件
				zhigu.pageAjaxSuccess = function(data){
					$(".pingLunBox").html(data);
				}
				
				// 回复按钮事件
				$(".reply_btn").on('click',function(){
					var $plist= $(this).parents(".commandRight").children("p");
                    var $p = $plist.last();
					if($p.hasClass("disnone")){
						$(".reply_p").addClass("disnone");
						$p.removeClass("disnone");
					}else{
						$(".reply_p").addClass("disnone");
					}
				});
				
				// 确认回复按钮事件
				$(".confirm_reply_btn").click(function(){
					var that = $(this);
                    var $parent= that.parents(".commandRight");
                    var $p_text = $parent.children("p");
                    var $input_btn = $parent.children("div").children("input.reply_btn")
                    
                    // 参数
					var reply = $.trim($(".reply_text",$p_text).val());
					var id = $(".reply_text",$p_text).data("id");
					
					// 验证
					var len = reply.length;
					if(len<1||len>200){
						dialog("请填写0到200个字符作为您的回复");
                        return;
					}
                    $.post("/goods/ajax/comment/reply",{reply:reply,id:id},function(data){
                        if(data.code === 1){
                            $input_btn.addClass("disnone");
                            $p_text.text("回复："+reply+" 回复时间："+data.data);
                        }else{
                            dialog(data.msg);
                        }
                    });

				})
			});
</script>