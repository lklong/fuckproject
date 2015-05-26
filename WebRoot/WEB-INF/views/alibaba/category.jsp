<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<title>发布到阿里</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script type="text/javascript" src="/js/alibaba/jquery.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/alibaba/bootstrap.css">
	<script type="text/javascript" src="/js/alibaba/bootstrap.js"></script>
	<style type="text/css">
		body{ background: #EEE; }
		#menubox{ background: #000;height: 45px;line-height: 45px;color: #FFF; }
		#menubox .span4{ margin: 0;padding: 0;font-size: 16px;font-family: "微软雅黑";font-weight: bold; }
		#menubox .span8{ text-align: right; }
		.container{ width: 1170px; }
		#contentbox{ margin-top: 55px; height: 1000px; }
		#cats{ background: #FFF; border: 1px #DDD solid; overflow: hidden; }
		.cat-box{ float: left;height: 500px;overflow-y:scroll;overflow-x:hidden;background: #FFF; }
		#submitbox{ clear: both; margin-top: 15px; }
		a:hover{ text-decoration:none; }
		.accordion-group,.well,.breadcrumb{ 
			-webkit-border-radius: 0px;
	     	-moz-border-radius: 0px;
	        border-radius: 0px;
	    }
	</style>
</head>
<body>
	<div id="doc">
		<div id="menubox" class="navbar navbar-fixed-top">
			<div class="container">
				<div class="span4">
					<a href="http://www.go2.cn/"><i class="icon-home icon-white" alt="回主页"></i></a>
					<strong>选择产品分类</strong>
				</div>
				<div class="span8">
					你好,yadong99! <a href="http://aapi.ximgs.net/api/ali/logout/"> [退出]</a><a href="http://aapi.ximgs.net/api/ali/logout/osogca"> [更换账号]</a>
				</div>
			</div>
		</div>
		<div id="contentbox" class="container">
			<div id="content">
				<div id="cats" class="cats well well-small">
					<ul class="nav nav-list cat-box span2" id="l1" data-level="1">
						<li class="" leaf="" data-index="3" data-id="10166"><a href="javascript:void(0);"  class="category"> 女装 </a></li>
						<li class="" leaf="" data-index="4" data-id="10165"><a href="javascript:void(0);"  class="category"> 男装 </a></li>
				<!-- 		<li class="" leaf="" data-index="15" data-id="312"><a href="javascript:void(0);"  class="category"> 内衣 </a></li> -->
						<li class="" leaf="" data-index="16" data-id="311"><a href="javascript:void(0);"  class="category"> 童装 </a></li>
						<li class="" leaf="" data-index="18" data-id="1038378"> <a href="javascript:void(0);"  class="category"> 鞋 </a></li>
			<!-- 			<li class="" leaf="" data-index="19" data-id="1042954"> <a href="javascript:void(0);"  class="category"> 箱包皮具 </a></li> -->
				</ul>
					<ul class="nav nav-list cat-box span2" id="l2" data-level="2" style="display:none"></ul>
					<ul class="nav nav-list cat-box span2" id="l3" data-level="3" style="display:none"></ul>
					<ul class="nav nav-list cat-box span2" id="l3" data-level="4" style="display:none"></ul>
				</div>
				<div id="message">
				</div>
				<div id="submitbox" align="center">
					<span class="btn disabled" alt="请点击要发布的分类" title="请点击要发布的分类">下一步，填写产品详情</span>
				</div>
			</div>
		</div>
		<div id="footerbox" class="container"></div>
	</div>

<script type="text/javascript">
$(function() {
	$('.nav-list a').live('click', (function(){
		var pn = $(this).parent().parent();
		$(this).parent().siblings().removeClass('active');
		$(this).parent().addClass('active');
		var cid = $(this).parent().attr('data-id');
		var leaf = $(this).parent().attr( 'leaf' );
		pn.nextAll().html('');
		pn.nextAll().hide();

		if( leaf != 'true' ){
			var str = '';
			$('#submitbox').html('<span class="btn disabled"  alt="请点击要发布的分类" title="请点击要发布的分类" >下一步，填写产品详情</span>');								
			$.ajax({
				url:"/alibaba/leaf?cid="+cid+"&code=${code}",
				dataType:"json",
				async: false,
				success:function(json){
			//		alert(json);
					$.each(json,function(k,v){	
						str += '<li leaf="' + v.leaf + '"  data-id="' + v.catsId + '">';
						str += '<a href="javascript:;" >' + v.catsName + '</a> </li>';
					});
					pn.next().html( str );
					pn.next().show(1);						
				}
			});
		}else{
			var url = '/alibaba/publish?goodsId=${goodsId}&code=${code}&cid=' + cid;
		//	alert(cid+"  /leaf:"+leaf);
			$('#submitbox').html('<a href="' + url + '" class="btn btn-warning">下一步，填写产品详情</a>');
		}			
	}));
});
</script>
</body></html>