<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<title>全部商品</title>
<link href="/css/default/list.css?v=20150505" rel="stylesheet">
</head>
<body>
<div class="mainbody">
  <div class="cur-pos">
     <a href="/">首页</a>> <a href="/welcome" >全部商品</a> > <a href="goods/list?categoryId=${paramCategory.id }">${paramCategory.name }</a>
  </div>
  <div class="souyoufeileitop">
    <div class="fwryh souyoufeileinrdi"> 所有分类：共<span class="cf86666">${page.totalRow } </span>件宝贝 </div>
    <div class="leimu">
      <div class="leimuTitle">类目 </div>
      <div id="categoryDiv">
        <c:forEach items="${childCategories }" var="c"> <a href="javascript:void(0)" cid="${c.id }"
							onclick="categorySel(this)">${c.name }</a> </c:forEach>
      </div>
      <br style="clear: both;" />
    </div>
    <div class="leimu">
      <div class="leimuTitle">属性 </div>
      <div class="shuxin">
        <c:forEach items="${properties }" var="pd">
          <c:if test="${pd.search }">
            <div> <a href="javascript:void(0)">${pd.name }</a>
              <ul class="hidden">
                <li onclick="propertySel(this)" pid="${pd.id }" key="0">不限</li>
                <c:forEach items="${pd.values }" var="pv">
                  <li onclick="propertySel(this)" pid="${pd.id }"
											key="${pd.id }:${pv.id}">${pv.name }</li>
                </c:forEach>
              </ul>
            </div>
          </c:if>
        </c:forEach>
      </div>
      <br style="clear: both;" />
    </div>
  </div>
  <div id="souyouProperties" class="hidden">
  	<ul class="sectednr" id="showProperties"></ul>
  </div>
  <div class="xuanzhepaixu">
    <div class="bsbSortDiv" style="width: 50px">
      <div>排序</div>
    </div>
    <div class="bsbSortDiv">
      <div>最新</div>
      <div> <span class="sortUp SUP" onclick="sort(this,9)"></span> <span
						class="sortDown" onclick="sort(this,10)"></span> </div>
    </div>
    <div class="bsbSortDiv">
      <div>价格</div>
      <div> <span class="sortUp" onclick="sort(this,7)"></span> <span
						class="sortDown" onclick="sort(this,8)"></span> </div>
    </div>
    <div class="bsbSortDiv">
      <div>人气</div>
      <div> <span class="sortUp" onclick="sort(this,3)"></span> <span
						class="sortDown" onclick="sort(this,4)"></span> </div>
    </div>
    <div class="bsbSortDiv">
      <div>收藏</div>
      <div> <span class="sortUp" onclick="sort(this,11)"></span> <span
						class="sortDown" onclick="sort(this,12)"></span> </div>
    </div>
  </div>
  <div class="shopGoodsListBox" id="goodsList">
    <jsp:include page="items.jsp" />
  </div>
</div>
<form action="goods/ajaxShoe" id="shoeForm" method="post">
  <input name="categoryId" id="categoryId" type="hidden" value="${categoryId }">
  <input name="sort" id="sort" type="hidden" value="10">
  <input name="goodsName" id="goodsName" type="hidden" value="">
  <input name=pageNo id="pageNo" type="hidden" value="1">
</form>
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}
$(document).ready(function() {
	//显示属性下拉列表
	$('.shuxin').find('div').hover(
			function(){
				$(this).find('ul').removeClass('hidden');
			},
			function(){
				$(this).find('ul').addClass('hidden');
			});
	
	// 瀑布流分页加载数据 START
	zhigu.high = 0;//初始化滚动条总长
	zhigu.top = 0;//初始化滚动条的当前位置
	
	$(window).scroll(function() {//定义滚动条位置改变时触发的事件。
		zhigu.high = $(document).height();//得到滚动条总长，赋给high变量
		zhigu.top = $(this).scrollTop();//得到滚动条当前值，赋给top变量
	});
	zhigu.addPageData = function() {
		if (zhigu.top > zhigu.high -1600 && zhigu.high>0){
			if(zhigu.pageNo==zhigu.totalPage){// 最后一页防止重复加载
				clearInterval(addDataInterval);
				zhigu.log("已加载到最后一页：totalPage = "+zhigu.totalPage);
				return;
			}
			var cpageNo = parseInt($("#pageNo").val()) + 1;//页码+1
			zhigu.log("加载数据：pageNo = "+cpageNo);
			$("#pageNo").val(cpageNo);
			ajaxSubmit("goods/ajaxShoe", $("#shoeForm").serialize(), function(data) { 
				$("#goodsList").append(data);
			}, "text");
			zhigu.high = 0;//恢复滚动条总长，因为scroll事件一触发，又会得到新值，不恢复的话可能会造成判断错误而再次加载
			zhigu.top = 0;//原因同上。
		}
	}
	var addDataInterval = setInterval("zhigu.addPageData()",1000);
	// 瀑布流分页加载数据 END
});

function closeSel(obj) {
	$(obj).parent().remove();
	search();
}
//选择类别
function categorySel(obj) {
	$("#categoryDiv a").removeClass("selected_red");
	$(obj).addClass("selected_red");
	search();
}
//选择属性
function propertySel(obj) {
	$(obj).parent().addClass('hidden');
	$('#souyouProperties').removeClass('hidden').addClass('souyouProperties');
	var pid = $(obj).attr("pid");
	var key = $(obj).attr("key");
	var text = $(obj).text();

	if (key == 0) {//删除选择
		$("#" + pid).remove();
	} else {
		var div = "<div key='" + key + "' class='cha' onclick='closeSel(this)' style='cursor: pointer;'>×</div> " + text;
		var selected = $("#showProperties [id='" + pid + "']").size();
		if (selected > 0) {
			$("#" + pid).html(div);
		} else {
			var li = "<li id='" + pid + "'>" + div + "</li>";
			$("#showProperties").append(li);
		}
	}
	//选择查询
	search();
}

//点击类目搜索
function search() {
	var categoryId = $("#categoryDiv .selected_red").attr("cid");
	if (categoryId != undefined){$("#categoryId").val(categoryId)};		//获取当前选中的分类
	//属性
	$("#shoeForm input[name='property']").remove();
	$(".cha").each(function() {
		$("#shoeForm").append("<input name='property' type='hidden' value='" + $(this).attr("key") + "'/>");
	});
	$("#pageNo").val(1);	//页码重置为1
	ajaxSubmit("goods/ajaxShoe", $("#shoeForm").serialize(), function(data) {
		zhigu.pageAjaxSuccess(data);
	}, "text");
}
zhigu.pageAjaxSuccess = function(data) {
	$("#goodsList").html("");
	$("#goodsList").append(data);
}

function sort(obj, sort) {
	$(".xuanzhepaixu span").each(function() {
		var cla = $(this).attr("class");
		if (cla.indexOf("SUP") != -1) {
			$(this).removeClass('SUP');
		}
		if (cla.indexOf("SDOWN") != -1) {
			$(this).removeClass('SDOWN');
		}
	});
	if ($(obj).attr("class")=="sortUp") {
		$(obj).addClass("SUP");
	}
	if ($(obj).attr("class")=="sortDown") {
		$(obj).addClass("SDOWN");
	}
	$("#sort").val(sort);
	search();
}
</script>
</body>
</html>