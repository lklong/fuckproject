<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta name='keywords' content='同城,货源,同城货源,服装批发网,批发市场,摄影,网店装修,一件代发' />
<meta name='description' content='智谷同城货源网是一家专业从事电子商务运营平台，提供最优质的"同城货源"、一件代发服务；专业服务、品质保障！欢迎访问 www.zhiguw.com' />
<title>货源批发网</title>
<link href="/css/default/welcome.css?v=20150505" rel="stylesheet">
</head>
<body>
<div class="main_visual">
  <div class="flicking_con"> <a href="javascript:void(0)"></a> <a href="javascript:void(0)"></a> <a href="javascript:void(0)"></a> </div>
  <div class="main_image">
    <ul>
      <li><a href="/goods/list?categoryId=3" target="_blank"><img src="img/welcome/welcome-flash-01.jpg"/></a></li>
      <li><a href="/goods/list?categoryId=20" target="_blank"><img src="img/welcome/welcome-flash-02.jpg"/></a></li>
      <li><a href="/goods/list?categoryId=19" target="_blank"><img src="img/welcome/welcome-flash-03.jpg"/></a></li>
    </ul>
  </div>
</div>
<script type="text/javascript">

	 $(document).ready(function () {
        var $images = $(".main_image li");
        var $button = $(".flicking_con a");
        var index = 0;
        var time = 0;
        function action() {
            $images.eq(index).fadeIn().siblings().fadeOut();
            $button.eq(index).addClass("btn-cur").siblings().removeClass("btn-cur");
            index = index + 1;
            if (index == $images.size())
                index = 0;
            time= window.setTimeout(action,4000); 
        }
        $button.click(function () {
            clearTimeout(time);
                index = $(this).index();
                action();
        });

        action();
    });

	</script> 

<!-- 1F女装 -->
<div class="goods_cate_block">
  <div class="goods_block_title">
    <div class="block_title nvzhuang"></div>
  </div>
  <div class="goods_block">
    <div class="inner_inside">
      <ul class="cate_block_ul">
        <c:forEach items="${womanDress }" var="g">
          <li>
            <div class="tuijian_ico"></div>
            <div class="goods_image"> <a href="/goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300}_285x285.jpg"  width="285px" height="285px" alt="${g.name}" /></a> </div>
            <div class="goods_text_info">
              <p class="text_price"> <font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font> </p>
              <div>
                <h3 class="text_name"> <a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a> </h3>
              </div>
              <p class="text_down"> <a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a> </p>
            </div>
          </li>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>

<!-- 2F男装 -->
<div class="goods_cate_block">
  <div class="goods_block_title">
    <div class="block_title nanzhuang"></div>
  </div>
  <div class="goods_block">
    <div class="inner_inside">
      <ul class="cate_block_ul">
        <c:forEach items="${manDress }" var="g">
          <li>
            <div class="tuijian_ico"></div>
            <div class="goods_image"> <a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300 }_285x285.jpg" width="285px" height="285px" alt="${g.name}" /></a> </div>
            <div class="goods_text_info">
              <p class="text_price"> <font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font> </p>
              <div>
                <h3 class="text_name"> <a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a> </h3>
              </div>
              <p class="text_down"> <a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a> </p>
            </div>
          </li>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>

<!-- 3F童装 -->
<div class="goods_cate_block">
  <div class="goods_block_title">
    <div class="block_title nantongzhuang"></div>
  </div>
  <div class="goods_block">
    <div class="inner_inside">
      <ul class="cate_block_ul">
        <c:forEach items="${childrenDress }" var="g">
          <li>
            <div class="tuijian_ico"></div>
            <div class="goods_image"> <a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300 }_285x285.jpg" width="285px" height="285px" alt="${g.name}" /></a> </div>
            <div class="goods_text_info">
              <p class="text_price"> <font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font> </p>
              <div>
                <h3 class="text_name"> <a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a> </h3>
              </div>
              <p class="text_down"> <a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a> </p>
            </div>
          </li>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>

<!-- 4F女鞋 -->
<div class="goods_cate_block">
  <div class="goods_block_title">
    <div class="block_title nvxie"></div>
  </div>
  <div class="goods_block">
    <div class="inner_inside">
      <ul class="cate_block_ul">
        <c:forEach items="${womanShoes }" var="g">
          <li>
            <div class="tuijian_ico"></div>
            <div class="goods_image"> <a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300 }_285x285.jpg" width="285px" height="285px" alt="${g.name}" /></a> </div>
            <div class="goods_text_info">
              <p class="text_price"> <font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font> </p>
              <div>
                <h3 class="text_name"> <a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a> </h3>
              </div>
              <p class="text_down"> <a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a> </p>
            </div>
          </li>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>

<!-- 5F男鞋 -->
<div class="goods_cate_block">
  <div class="goods_block_title">
    <div class="block_title nanxie"></div>
  </div>
  <div class="goods_block">
    <div class="inner_inside">
      <ul class="cate_block_ul">
        <c:forEach items="${manShoes }" var="g">
          <li>
            <div class="tuijian_ico"></div>
            <div class="goods_image">
              <div> <a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300 }_285x285.jpg" width="285px" height="285px" alt="${g.name}" /></a> </div>
            </div>
            <div class="goods_text_info">
              <p class="text_price"> <font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font> </p>
              <div>
                <h3 class="text_name"> <a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a> </h3>
              </div>
              <p class="text_down"> <a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a> </p>
            </div>
          </li>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>

<!-- 6F童鞋 -->
<div class="goods_cate_block">
  <div class="goods_block_title">
    <div class="block_title tongxie"></div>
  </div>
  <div class="goods_block">
    <div class="inner_inside">
      <ul class="cate_block_ul">
        <c:forEach items="${childrenShoes }" var="g">
          <li>
            <div class="tuijian_ico"></div>
            <div class="goods_image"> <a href="goods/detail?goodsId=${g.id}" target="_blank"><img src="${g.image300 }_285x285.jpg" width="285px" height="285px" alt="${g.name}" /></a> </div>
            <div class="goods_text_info">
              <p class="text_price"> <font color="c21902"><strong>￥<font size="+1">${g.minPrice}</font></strong></font> </p>
              <div>
                <h3 class="text_name"> <a href="goods/detail?goodsId=${g.id}" target="_blank" title="${g.name}" class="ellipsis">${g.name}</a> </h3>
              </div>
              <p class="text_down"> <a href="/store/index?storeId=${g.storeId }" target="_blank">进入店铺</a> </p>
            </div>
          </li>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>
<script type="text/javascript">

if (typeof zhigu == "undefined" || !zhigu) {var zhigu = {};}

/*$(function(){
	  $.getJSON("help/home/cementcontents?type=1",function(msgBean){
 	 var html="";
 	for(var i=0;i<msgBean.data.length;i++){
 	   html+="<li><a href=\"/help/showComment?id="+msgBean.data[i].id+"\" target=\"_blank\">"+msgBean.data[i].title+"</a></li>"
 	}
 	$("#cementType1").html(html);
 })

 $.getJSON("help/home/cementcontents?type=3",function(msgBean){
 	 var html="";
 	for(var i=0;i<msgBean.data.length;i++){
 	   html+="<li><a href=\"/help/showComment?id="+msgBean.data[i].id+"\" target=\"_blank\">"+msgBean.data[i].title+"</a></li>"
 	}
 	$("#cementType3").html(html);
 })

	  $.getJSON("help/home/cementcontents?type=5",function(msgBean){
 	 var html="";
 	for(var i=0;i<msgBean.data.length;i++){
 	   html+="<li><a href=\"/help/showComment?id="+msgBean.data[i].id+"\" target=\"_blank\" >"+msgBean.data[i].title+"</a></li>"
 	}
 	$("#cementType5").html(html);
 })

})*/
</script>
</body>
</html>
