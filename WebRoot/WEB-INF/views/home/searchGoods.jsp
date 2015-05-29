<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>全部货源</title>
<link href="/css/default/list.css?v=20150505" rel="stylesheet">
</head>
<body>
<div class="mainbody">
  <div class="cur-pos"> <a href="index">首页</a> > 搜索 >
    <c:if test="${storeName != null }"> ${storeName }</c:if>
    <c:if test="${propName != null }"> ${propName }</c:if>
    <c:if test="${goodsName != null }"> ${goodsName }</c:if>
  </div>
  <div class="shopGoodsListBox" id="goodsList">
    <div style="display:none">
      <form id="requestForm" action="/home/search" method="post">
        <c:if test="${storeName != null }">
          <input name="storeName" value="${storeName}" type="hidden" />
        </c:if>
        <c:if test="${propName != null }">
          <input name="propName" value="${propName}" type="hidden" />
        </c:if>
        <c:if test="${goodsName != null }">
          <input name="goodsName" value="${goodsName}" type="hidden" />
        </c:if>
      </form>
    </div>
    <jsp:include page="../goods/goods/items.jsp"/>
  </div>
  <div class="ddpage fr mt20">
    <jsp:include page="../include/page.jsp">
    <jsp:param value="requestForm" name="requestForm"/>
    <jsp:param value="form" name="request"/>
    </jsp:include>
  </div>
</div>
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}

//分享代码
var shareid = "fenxiang";
var shareURL = "";
var shareTitle = "";
var shareContent = "";
(function() {
 var a = {
     url:function() {
         return encodeURIComponent(shareURL)
     },title:function() {
         return encodeURIComponent(shareTitle)
     },content:function(d) {
     		if(shareContent){
     			return encodeURIComponent(shareContent)
     		}
             return encodeURIComponent(shareTitle)
     },setid:function() {
         if (typeof(shareid) == "undefined") {
             return null
         } else {
             return shareid
         }
     },kaixin:function() {
         window.open("http://www.kaixin001.com/repaste/share.php?rtitle=" + this.title() + "&rurl=" + this.url() + "&rcontent=" + this.content(this.setid()))
     },renren:function() {
         window.open("http://share.renren.com/share/buttonshare.do?link=" + this.url() + "&title=" + this.title())
     },sinaminiblog:function() {
         window.open("http://v.t.sina.com.cn/share/share.php?url=" + this.url() + "&title=" + this.title() + "&content=utf-8&source=&sourceUrl=&pic=")
     },baidusoucang:function() {
         window.open("http://cang.baidu.com/do/add?it=" + this.title() + "&iu=" + this.url() + "&dc=" + this.content(this.setid()) + "&fr=ien#nw=1")
     },taojianghu:function() {
         window.open("http://share.jianghu.taobao.com/share/addShare.htm?title=" + this.title() + "&url=" + this.url() + "&content=" + this.content(this.setid()))
     },wangyi:function() {
         window.open("http://t.163.com/article/user/checkLogin.do?source=%E7%BD%91%E6%98%93%E6%96%B0%E9%97%BB%20%20%20&link=" + this.url() + "&info=" + this.content(this.setid()))
     },qqzone:function() {
         window.open('http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=' + this.url() + '&title=' + this.title())
     },pengyou:function() {
         window.open('http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?to=pengyou&url=' + this.url() + '&title=' + this.title())
     },douban:function() {
         window.open("http://www.douban.com/recommend/?url=" + this.url() + "&title=" + this.title() + "&v=1")
     },qqweibo:function(){
     	 var _t = encodeURI(shareTitle);
     	    var _url = encodeURI(shareURL);
     	    var _appkey = encodeURI("appkey");
     	    var _u = 'http://v.t.qq.com/share/share.php?title=' + _t + '&url=' + _url + '&appkey=' + _appkey;
     	    window.open(_u);
     }};
 window.share = a
})();
//jiathis分享
var jiathis_config ={};
$(function() {
	// 分享
	$(".goodsListBoxes").each(function(){
		$(this).mouseenter(function(){
			var share =  $(this).find(".fengXiangButtonDiv");
			jiathis_config={ 
					url: "http://www.zhiguw.com/"+share.attr("shareurl"), 
					title: share.attr("sharetitle"), 
					summary:share.attr("sharetitle"),
				} 
		});
	});
 $(".renren").click(function() {
 	setShare(this);
     share.renren();
 });
 $(".xinlang").click(function() {
 	setShare(this);
     share.sinaminiblog();
 });
 $(".douban").click(function() {
 	setShare(this);
     share.douban();
 });
 $(".kaixin").click(function() {
 	setShare(this);
     share.kaixin();
 });
 $(".taojianghu").click(function() {
 	setShare(this);
     share.taojianghu();
 });
 $(".wangyi").click(function() {
 	setShare(this);
     share.wangyi();
 });
 $(".qqzone").click(function() {
 	setShare(this);
     share.qqzone();
 });
 $(".baidusoucang").click(function() {
 	setShare(this);
     share.baidusoucang();
 });
 $(".tengxunweibo").click(function() {
 	setShare(this);
     share.qqweibo();
 });
	$(".qqpengyou").click(function() {
		setShare(this);
     share.pengyou();
 });
});
function setShare(obj){
	shareURL =  "http://www.zhiguw.com/"+$(obj).parent().parent().parent().attr("shareurl");
    shareTitle = "【智谷同城货源网】"+ $(obj).parent().parent().parent().attr("sharetitle");
}
</script> 
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1" charset="utf-8"></script>
</body>
</html>