<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#searchTypeDiv{cursor: pointer;}
</style>
<div class="logokk ">
	<div class="logo mt20">
		<img  src="img/logo2.png" />
	</div>
	<form action="searchCommodity" id="searchForm" method="post">
		<div class="search"  >  
			<div class="search_w">
				<div class="search_n"  id="searchDiv">
					<span id="searchTypeDiv">
						<div class="mr10 f14 fl lh35 pl10" id="searchType">商品</div>
						<div class="fl mt15 pr10">
							<img src="img/search_down.jpg" width="8" height="5" class="searchdown" />
						</div>
					</span>
					<ul  class="sbsearch" id="searchOption" style="display: none;">
						<li >商品</li>
						<li >店铺</li>
					</ul>
					<input type="text" class="search_txt pl10" name="searchName" />
					<div class="clear"></div>
				</div>
			</div>
			<div class="search_img ml10 fl" onclick="searchForm.submit();"></div>
			<div class="clear"></div>
		</div>
	</form>
</div>
<div class="clear"></div>
<div class="pt20"></div>
<script type="text/javascript">
$(function(){
	$("#searchTypeDiv").click(function(){
		if($("#searchOption").is(":hidden")){
			$("#searchOption").show();
		}else{
			$("#searchOption").hide();
		}
	});
	$("#searchOption li").each(function(){
		$(this).mouseenter(function(){
			$(this).css("background-color","#E5E5E5");
		});
		$(this).mouseleave(function(){
			$(this).css("background-color","");
		});
		$(this).click(function(){
			$("#searchType").html($(this).html());
			$("#searchOption").hide();
			if($(this).html()=="店铺"){
				$("#searchForm").attr("action","/searchStore");
			}else{
				$("#searchForm").attr("action","/searchCommodity");
			}
		});
	});
	// 导航选中状态
	var url = window.location.href;
	$(".navnr a").each(function(){
		if($(this).prop("href")==url){
			$(this).addClass("navseceted");
			return false;
		};
	});
})
</script>