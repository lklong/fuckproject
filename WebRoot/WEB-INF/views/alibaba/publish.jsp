<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>发布到阿里</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link rel="stylesheet" type="text/css" href="/css/alibaba/bootstrap.css">
	<script type="text/javascript" src="/js/alibaba/bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="/js/3rdparty/kindeditor/themes/default/default.css">
<link rel="stylesheet" href="/js/3rdparty/kindeditor/plugins/code/prettify.css">
<script charset="utf-8" src="/js/3rdparty/kindeditor/kindeditor-all-min.js"></script>
<script charset="utf-8" src="/js/3rdparty/kindeditor/lang/zh_CN.js"></script>
<script charset="utf-8" src="/js/3rdparty/kindeditor/plugins/code/prettify.js"></script>

<style type="text/css">

	#menubox{ background: #000; height: 45px; line-height: 45px; color: #FFF; }
	#accordion{ min-height: 450px; }
	#contentbox{ margin-top: 55px; min-height: 600px; }
	.red{ color: red; }
	.thumbnails li{ cursor: pointer; }
	.img-null{ display: inline-block; width:120px;height:120px;background: url(/images/pubimgbg.gif) no-repeat center center; }
	.boximg{ width: 60px;height: 60px; }
	.list-img-null{ display: inline-block; width:60px;height:60px;overflow: hidden; }
	.thumbnails{ margin-bottom: 0px; }
	ul{ list-style: none; }
	a:hover{
		text-decoration:none;
	}
	.accordion-group,.well,.breadcrumb{ 
		-webkit-border-radius: 0px;
     	-moz-border-radius: 0px;
        border-radius: 0px;
    }
    h6{ font-weight: normal; }
    .modal.fade.in{ top:5%; }
    .modal { z-index: 999999 }
    .modal-backdrop{ z-index: 888888 }
    .thumbnail{ text-align: center; }
    .thumbnail img{  width: 110px; height: 110px;  }
    #choosebox .thumbnail img{  width: 60px; height: 60px;  }
	.img{ height: 120px; }
    .ke-icon-insertimg {
    	<!-- 
    	/*自定义编辑器插件*/ 
    	-->
        background-image: url(/js/3rdparty/kindeditor/themes/default/default.png);
        background-position: 0px -494px;
        width: 16px;
        height: 16px;
	}
	#time{
		width: 100%;
		text-align: center;
	}
</style>
<script type="text/javascript">
	host = "http://127.0.0.1:8080/";
	var images = ${goodsImages};
	var mainImgList = "";
	for(var i=0;i<images.length;i++){
		mainImgList += '<li><img src='+host+images[i].image+' class="thumbnail img" choose="F"></li>';
	}
	//var descImgList = '<li><img src="http://thumb.ximgs.net/48646/2015031617552797757199_120x120.jpg" class="thumbnail img" choose="F"></li>';
	var descImgList =mainImgList;
	var imgsmall = 'thumb.ximgs.net';//缩略图网址''
	var imgbig = 'static.ximgs.net';//大图网址
	var editor = '';
</script>

<script type="text/javascript">
	
	//将form转为AJAX提交
	function ajaxSubmit(frm, fn) {
	  var dataPara = getFormJson(frm);
	  $.ajax({
	    url: frm.action,
	    type: frm.method,
	    data: dataPara,
	    //async: false,
	    success: fn
	  });
	}
	//将form中的值转换为键值对。

	function getFormJson(frm) {
	  var o = {
	  };
	  var a = $(frm).serializeArray();
	  $.each(a, function () {
	    if (o[this.name] !== undefined) {
	      if (!o[this.name].push) {
	        o[this.name] = [
	          o[this.name]
	        ];
	      }
	      o[this.name].push(this.value || '');
	    } else {
	      o[this.name] = this.value || '';
	    }
	  });
	  return o;
	}
	//图片上传

	function uploadEnd(img) {
		
	  var type = typeof img;
	  $('#descfile').val('');
	  $('#descalert').html('');
	  if (type == 'string') {
	    var html = '<li class="span1"><img src="' + img + '" class="thumbnail img" choose="F"></li>';
	    $('#descUploadImg').append(html);
	    $('#descalert').html('<div  class="text-success">上传成功!</div>');
	  } else if (type = 'object') {
	    $('#descalert').html('<div  class="alert">' + img.url + '</div>');
	  } else {
	    $('#descalert').html('<div  class="alert">未知错误!</div>');
	  }
	}
	function loading() {
	  $('#descalert').html('<div>  上传中...</div>');
	 /* <img src="/images/ajax-loader.gif" /> */
	}
	//判断已选盒子是否装满

	function countimg() {
	  var boxnum = $('#choosebox li').size();
	  var imgnum = $('#choosebox li img').size();
	  if (imgnum < boxnum) {
	    return true;
	  } else {
	    return false;
	  }
	}
	//将图片装进盒子

	function insert2box(img) {
	  $('#choosebox li').each(function () {
	    if (!$(this).children('img').attr('src')) {
	      $(this).html('<img src="' + img + '" class="boximg"  />');
	      return false;
	    }
	  }
	  );
	}
	//将图片加入描述中 需要用到全局变量 editor

	function insert2desc() {
	  var img = '';
	  $('.boximg').each(function () {
	    var src = $(this).attr('src');
	    src = src.replace(imgsmall, imgbig); //图片网址转换
	    src = src.replace('120x120', '550x550');
	    img += '<img src="' + src + '">';
	  }
	  );
	  if (img != '') {
	    img = '<div style="text-align:center">' + img + '</div>';
	    editor.edit.design(true);
	    editor.toolbar.unselect('source');
	    editor.toolbar.disableAll(false);
	    editor.insertHtml(img);
	  }
	}
	//生成配色图片盒子

	function matchimg_init() {
	  var matchhtml = '';
	  $('.color').each(function () {
	    var title = $(this).val();
	    title = title.replace(/\s+/g, '');
	    if ($(this).attr('data-check') == 'T' && title != '') {
	      matchhtml += '<li class="thumbnail" data-toggle="modal" ><span class="img-null img-btn"';
	      matchhtml += 'rel=' + $(this).attr('id');
	      matchhtml += ' data-src="match"></span><h6>' + title + '</h6></li>';
	    }
	  }
	  );
	  if (matchhtml.length) {
	    $('#match').css('display', 'block');
	    $('#match-box').html(matchhtml);
	  } else {
	    $('#match').css('display', 'none');
	    $('#match-box').html(matchhtml);
	  }
	}
	//启动模态框

	function modal(title, imglsit, src, id, choosebox) {
	  $('#img-box').modal({
	    'backdrop': 'static',
	  });
	  $('#img-box-title').html(title);
	  $('#local-img-list').html(imglsit);
	  $('#insert').attr('data-src', src);
	  $('#insert').attr('data-id', id);
	  $('#choosebox').html(choosebox);
	  return false;
	}
	//配色图片框

	function matchbox(id) {
	  $('.boximg').each(function () {
	    var src = $(this).attr('src');
	    $('#match-box span').each(function () {
	      var rel = $(this).attr('rel');
	      if (id == rel) {
	        var value = $(this).next().text();
	        var html = '<img src="' + src + '" class="slectedmatch" data-value="' + value + '" rel="' + rel + '" />';
	        $(this).before(html);
	        $(this).remove();
	      }
	    }
	    );
	  }
	  );
	  var input = '';
	  $('.slectedmatch').each(function () {
	    var src = $(this).attr('src');
	    var v = $(this).attr('data-value');
	    input += v + '#' + src + '|';
	  }
	  );
	  $('#matchinput').val(input);
	}
	//主图图片框

	function mainbox(id) {
	  $('.boximg').each(function () {
	    var src = $(this).attr('src');
	    $('#main-box span').each(function () {
	      var html = '<img src="' + src + '" class="slectedmain" />';
	      $(this).parent().html(html);
	      //break;
	      return false;
	    }
	    );
	  }
	  );
	  var input = '';
	  $('.slectedmain').each(function () {
	    var src = $(this).attr('src');
	    input += src + '|';
	  }
	  );
	  $('#maininput').val(input);
	}
	//倒计时

	function cdown() {
	  if (cdtime > 0) {
	    $('#time').html(cdtime);
	    cdtime--;
	  } else {
	    clearInterval(countdown);
	    var mess = '<span class="red">发布超时</span><hr>';
	    mess += '<h4 class="text-error">返回代码:</h4><hr /><p>local</p><hr />';
	    mess += '<h4 class="text-success">解决方法(参考):</h4><hr />';
	    mess += '<ol><li>请减少图片,详细说明图片建议少于20张!</li>';
	    mess += '<li>检查图片空间容量、张数!</li></ol>';
	    $('#notice').html(mess);
	  }
	}
	//调用
	//自定义编辑器插件

	KindEditor.lang({
	  insertimg: '选择图片',
	});
	KindEditor.ready(function (K) {
	  editor = K.create('#description', {
	    items: [
	      'source',
	      '|',
	      'undo',
	      'redo',
	      '|',
	      'forecolor',
	      'hilitecolor',
	      'fontname',
	      'fontsize',
	      '|',
	      'bold',
	      'italic',
	      'underline',
	      'removeformat',
	      '|',
	      'justifyleft',
	      'justifycenter',
	      'justifyright',
	      'insertorderedlist',
	      'insertunorderedlist',
	      'link',
	      '|',
	      'insertimg',
	      '|',
	      'fullscreen'
	    ],
	  });
	  K.sync('#description');
	  K('input[name=getHtml]').click(function (e) {
	    nw = window.open();
	    nw.document.write('<div style="margin:10px auto;width:770px;">' + editor.html() + '</div>');
	  });
	  K('#desc_template').click(function () {
	    alert('完善中....');
	  }
	  );
	});
	$(function () {
	  if (navigator.userAgent.indexOf('MSIE') > 0) {
	    $('body').html('<center><h2>暂时不支持IE浏览器,请使用Google或者火狐浏览器!</h2></center>');
	  }
	  //初始化配色图片

	  matchimg_init();
	  $('.color').click(function () {
	    if ($(this).attr('checked') == 'checked') {
	      $(this).attr('data-check', 'T');
	    } else {
	      $(this).attr('data-check', 'F');
	    }
	    matchimg_init();
	  }
	  );
	  //表单提交弹出
	  $('#form').live('submit', function () {
	    $('#myModal').modal({
	      'backdrop': 'static',
	    });
	    $('#notice').html('<strong>正在上传数据.... </strong><h1 id="time"></h1>');
	    /* <img src="/images/ajax-loader.gif" />    */
	    //倒计时
	    cdtime = 600;
	    countdown = setInterval(cdown, 1000);
	    ajaxSubmit(this, function (data) {
	    	var host = "http://127.0.0.1:8080";
	    	/* alert(12);
	      var obj = JSON.parse(data); */
	      var mess = '';
	      if (data.status) {
	        mess += '<span class="red">' + data.msg + '</span><hr>';
	        mess += '<h4>阿里地址:</h4><a href=' + data.data + '>'+ data.data + '</a>';
	        mess += '<h4>返回智谷首页:</h4><a href=' + host + '>'+ hsot + '</a>';
	      } else {
	        mess += '<span class="red">' + data.msg + '</span><hr>';
	       // mess += '<h4 class="text-error">返回代码:</h4><hr /><p>' + obj.info.code + '</p><hr />';
	       // mess += '<h4 class="text-success">解决方法(参考):</h4><hr /><ol>' + obj.info.mess + '</ol>';
	      }
	      clearInterval(countdown);
	      $('#notice').html(mess);
	    });
	    return false;
	  }
	  );
	  //图片处理区///////////////////////////////
	  //图片选择
	  $('.img-btn').live('click', function () {
	    var src = $(this).attr('data-src');
	    var t = 1;
	    switch (src) {
	      case 'match':
	        t = 1;
	        var title = '匹配图片选择';
	        var imglsit = mainImgList;
	        var id = $(this).attr('rel');
	        break;
	      case 'main':
	        n = 3;
	        t = 3 - $('.slectedmain').size();
	        var title = '主图图片选择';
	        var imglsit = mainImgList;
	        var id = $(this).attr('rel');
	        break;
	      case 'desc':
	        t = 8;
	        var title = '详细说明图片选择';
	        var imglsit = descImgList;
	        var id = 'desc';
	        break;
	    }
	    if (t > 0) {
	      var choosebox = '';
	      while (t > 0) {
	        choosebox += '<li class="thumbnail"><span class="list-img-null"></span></li>';
	        t--;
	      }
	      modal(title, imglsit, src, id, choosebox)
	      return false;
	  } else {
	    $('#alert').modal({
	      'backdrop': 'static',
	    });
	    $('#alert_mess').html('没有空位了');
	}
	}
	);
	//删除配色已选图片
	$('.slectedmatch').live('click', function () {
	var rel = $(this).attr('rel');
	var html = '<span data-src="match" rel="' + rel + '" class="img-null img-btn"></span>';
	$(this).before(html);
	$(this).remove();
	}
	);
	//删除主图已选图片
	$('.slectedmain').live('click', function () {
	var html = '<span data-src="main" class="img-null img-btn"></span>';
	$(this).before(html);
	$(this).remove();
	}
	);
	$('.img').live('click', function () {
	var CE = $(this);
	switch (CE.attr('choose')) {
	  case 'F':
	    if (countimg()) {
	      CE.attr('choose', 'T');
	      CE.css('border', '1px solid red');
	      insert2box(CE.attr('src'));
	    } else {
	      alert('只能选择这么多图片!');
	    }
	    break;
	  case 'T':
	    CE.attr('choose', 'F');
	    CE.css('border', '1px solid #DDD');
	    $('.boximg').each(function () {
	      if (CE.attr('src') == $(this).attr('src')) {
	        $(this).parent().html('<span class="list-img-null" ></span>');
	      }
	    }
	    );
	    break;
	}
	}
	);
	$('.boximg').live('click', function () {
	var src = $(this).attr('src');
	$(this).parent().html('<span class="list-img-null" ></span>');
	//去除边框
	$('.img').each(function () {
	  if ($(this).attr('src') == src) {
	    $(this).attr('choose', 'F');
	    $(this).css('border', '1px solid #DDD');
	  }
	}
	);
	}
	);
	//将图片加入表单
	$('#insert').on('click', function () {
	var CE = $(this);
	var datasrc = CE.attr('data-src');
	var dataid = CE.attr('data-id');
	switch (datasrc) {
	  case 'match':
	    matchbox(dataid);
	    break;
	  case 'main':
	    mainbox(dataid)
	    break;
	  case 'desc':
	    insert2desc();
	    break;
	}
	$('.img').attr('choose', 'F');
	$('#local-img-list').html('');
	$('#choosebox').html('');
	$('.img').css('border', '1px solid #DDD');
	});
	/////属性处理区///////
	//添加自定义属性
	$('#feature_add').click(function () {
	var html = '<div class="control-group"><label class="control-label">自定义属性</label>';
	html += '<div class="controls zdy">';
	html += '<input class="span1 feature" name="add_feature_key[]" type="text" value="" placeholder="属性名">&nbsp;';
	html += '<input class="span2 feature" name="add_feature_value[]" type="text" value="" placeholder="属性值">';
	html += '<a href="javascript:;" class="feature_del hide" > <i class="icon-minus-sign"></i> 删除</a></div></div>';
	$(this).before(html);
	}
	);
	//删除自定义属性
	$('.feature_del').live('click', function () {
	$(this).parent().parent().remove();
	}
	);
	//添加自定义颜色或尺寸
	$('.add_btn').click(function () {
	var type = $(this).attr('data-info');
	var html = '';
	switch (type) {
	  case 'color':
	    var n = $('.color').size() + 1;
	    html += '<label class="span2  checkbox zdy" >';
	    html += '<input type="text" id="color_' + n + '"  name="feature_' + color_fid + '[]" class="span1 color zdy-color" data-check="T"  value="">';
	    html += '<a href="javascript:;" class="hide color_del">';
	    html += ' <i class="icon-minus-sign"></i> 删除</a></label>';
	    break;
	  case 'size':
	    html += '<label class="span2 checkbox zdy" >';
	    html += '<input type="text" name="feature_' + size_fid + '[]" class="span1" value="">';
	    html += '<a href="javascript:;" class="hide size_del" >';
	    html += ' <i class="icon-minus-sign"></i> 删除</a></label>';
	    break;
	}
	$(this).before(html);
	}
	);
	//添加价格区间
	$('#addpriceRange').click(function () {
	var len = $(".numRanges").length;
	var html = '';
	html += '<div class="zdy numRanges" >起订量<input class="span1"  name="numRanges['+len+']" value="" placeholder="请输入起订量" />';
	html += '&#160;&#160;价格<input class="span2"  name="priceranges['+len+']" value=""  placeholder="请输入价格,单位:元" />';
	html += '<a href="javascript:;" class="hide size_del" ><i class="icon-minus-sign"></i> 删除</a><p /></div>';
	$(this).before(html);
	});
	$('.zdy').live('mouseover', function () {
	$(this).find('a').removeClass('hide');
	}
	);
	$('.zdy').live('mouseleave', function () {
	$(this).find('a').addClass('hide');
	}
	);
	$('.zdy-color').live('blur', matchimg_init);
	//删除自定义颜色或属性
	$('.color_del').live('click', function () {
	$(this).parent().remove();
	matchimg_init();
	}
	);
	$('.size_del').live('click', function () {
	$(this).parent().remove();
	}
	);
	//子属性菜单
	$('.getchildren').live('click', function () {
	var p = $(this)
	var path = $(this).find('option:selected').attr('path');
	var cid = $('#cid').val();
	p.next().html('');
	if (path != 'F' && path != '') {
		 var url = '/alibaba/cat/spu?cid=${cid}&path=' + path;
	  $.ajax({
	    url: url,
	    dataType: 'json',
	    async: false,
	    success: function (data) {
	      var html = '';
	      p.next().html(html);
	      $.each(data, function (key, val) {
	        if (val.inputType == 1) {
	          html += '<p /><span class="red">*</span>' + val.name + '&#160;<select ';
	          if (val.childrenFids[0]) {
	            html += ' class="getchildren" ';
	          }
	          html += 'name="feature_' + val.fid + '"><option path="F"> - 请选择 - </option>';
	          $.each(val.featureIdValues, function (k, v) {
	            html += '<option path="' + path + '>' + val.fid + ':' + v.vid + '" value="' + v.value + '">' + v.value + '</option>';
	          }
	          );
	          html += '</select><span></span>';
	        } else if (val.inputType == 2) {
	          html += '<div class="clearfix" ></div><h6><span class="red">*</span>' + val.name + '</h6>';
	          $.each(val.featureIdValues, function (k, v) {
	            html += '<label class="checkbox  span1 feature">';
	            html += '<input type="checkbox" vid="' + v.vid + '"';
	            html += 'name="feature_' + val.fid + '[]" value="' + v.value + '">' + v.value + '</label>';
	          }
	          );
	        } else {
	          html = '';
	        }
	      }
	      );
	      p.next().html(html);
	    }
	  });
	} else {
	  p.next().html('');
	}
	}
	);
	$('#used-freight').live('click change', function () {
	var v = $(this).val();
	if (v == 'T') {
	  $(this).next().html(templatelists);
	} else {
	  $(this).next().html('');
	}
	}
	);
	});

</script>
</head>
<body data-spy="scroll" data-target=".accordion-body">
<div id="menubox" class="navbar navbar-fixed-top">
	<div class="container">
		<div class="row">
			<div class="span8 text-left" style="font-size: 16px; font-family: " 微软雅黑";"="">
				<a href="http://www.zhiguw.com/"><i class="icon-home icon-white" alt="回主页"></i></a>
				<strong>填写产品详情</strong>
			</div>
			<div class="span4 text-right">				
				你好,${user.loginId }! <a href="http://aapi.ximgs.net/api/ali/logout"> [退出]</a><a href="http://aapi.ximgs.net/api/ali/logout/osogca"> [更换账号]</a>
			</div>
		</div>
	</div>
</div>
<%-- ${tradeProps } 
 ${catProps }
${itemCatProps }
${user } --%>
<div id="contentbox" class="container">
	<ul class="breadcrumb">
	
	    <li> <i class="icon-flag"></i> <span>当前分类:<c:forEach items="${paths}" var="path"> ${path.catsName}&gt;</c:forEach> </span></li>
	    <li class="pull-right"> 
	    	<a href="http://127.0.0.1:8080/alibaba/category/choose?state=${goods.id}&cid=${cid}&code=${code}"> <i class="icon-repeat"></i> 重选分类 </a> 
	    </li>
    </ul>			
	<div id="content">		
		<form action="/alibaba/save" method="post" id="form">
			<input name="product_id" id="product_id" value="osogca" type="hidden">
			<input name="categoryID" id="cid" value="${cid }" type="hidden">
			<input name="code" id="code" value="${code }" type="hidden">
			<input name="savemode" value="album" type="hidden">
			<input name="main" id="maininput" value="" type="hidden">
			<input name="match" id="matchinput" value="" type="hidden">

							<input name="feature_346" value="四川成都" type="hidden">
							<input name="feature_8514" value="否" type="hidden">
						<!-- 折叠开始 -->
			<div class="accordion" id="accordion">

				<!-- 属性等基本信息 -->
				<div class="accordion-group">
					<div class="accordion-heading">
						<span title="点击展开或收起" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
							<i class="icon-hand-right"></i> <strong>填写基本信息</strong>							
						</span>			           
					</div>
					<div id="collapseOne" class="accordion-body collapse in">
						<div class="accordion-inner form-horizontal">

							<div class="control-group">
								<label class="control-label" for="subject"><span class="red"> * </span>信息标题</label>
								<div class="controls">
									<input class="span4" id="subject" name="subject" placeholder="建议在标题中包含产品名和产品特性关键词" maxlength="30" type="text" value="${goods.name }">									      
									<p class="help-inline">字数小于等于30个字符</p>
								</div>
							</div>

							<div class="control-group">									    	
								<label class="control-label">产品属性</label>
								<div class="controls well">
									<div class="alert alert-info">带*号为必选属性,部分属性需要点击才能弹出!</div>
																                    	
									
									<c:forEach items="${catProps }" var="catProp"> 
									<c:if test="${!catProp.isSpecAttr&&fn:replace(catProp.aspect,';','')=='0' }">	
									<c:choose>		
									<c:when test="${catProp.showType==1 }">	
											     	
										<div class="control-group">
										<label class="control-label"><c:if test="${catProp.required }"><strong class="red"> * </strong></c:if>${catProp.name }</label>
										<!-- 数字输入框 -->
																	                        	
										<div class="controls">
											<select class="span2 feature getchildren " name="feature_${catProp.fid}" data-isneeded="Y">  
												<option selected="selected" value="" path="F"> - 请选择 - </option>    
												<c:forEach items="${catProp.featureIdValues }"  var="fearture"  varStatus="status">                                                            
															<option value="${fearture.value} "  path="${catProp.fid }:${fearture.vid}"  vid="${fearture.vid }"> ${fearture.value } </option>
												</c:forEach> 
												                                                                
											</select>
											<span></span>
										</div>
										<!-- 多选框 -->
										 
									</div>	
								</c:when>
								<c:when test="${catProp.showType==2 }">	
									<div class="control-group">
										<label class="control-label"><strong class="red"> * </strong>${catProp.name }</label>
										<!-- 数字输入框 -->
														<div class="controls">
														<c:forEach items="${catProp.featureIdValues }"  var="fearture"  varStatus="status">                                                           
														<label class="checkbox inline  feature"><input data-isneeded="Y" vid="${fearture.vid }" name="feature_${catProp.fid }" value="${fearture.value}" type="checkbox">${fearture.value}</label>                              
												</c:forEach> 
														
										</div>
										<!-- 单选框 -->
										 
									</div>	
								</c:when>
								<c:when test="${catProp.showType==0 }">	
								
									<div class="control-group">
										<label class="control-label">${catProp.name }</label>
										<div class="controls">
											<input class="span2 feature" name="feature_${catProp.fid }" value="" placeholder="请输入${catProp.name }" type="text">
										</div>
									</div>	
									
								</c:when>
									</c:choose>	 
									</c:if>			                        							                        						                                           
									</c:forEach>				
										
									<!-- <a href="javascript:;" id="feature_add" data-info="feature"><i class="icon-plus-sign"></i> 添加产品属性</a><p class="help-inline">如果您觉得我们提供的产品属性无法满足您的需要，您可以手动添加产品属性</p> -->
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">产品规格</label>
								<div class="controls well">
									<!-- 颜色/尺寸 -->
									<div class="control-group">
									   <!--  <div class="alert alert-info"> 
									    	可选颜色: &nbsp;&nbsp;黑色;米白色;粉红色;蓝色; &nbsp;&nbsp;&nbsp;&nbsp;	
										可选尺码: &nbsp;&nbsp;31,32,33,34,35,36,37,38,39,40,41,42,43 
											&nbsp;&nbsp;&nbsp;&nbsp;										</div> 				 -->					
																                    	
										<script type="text/javascript"> var color_fid = 3216;</script>
										<div class="clearfix"></div>
										
										<!-- 颜色 -->
										<c:forEach items="${catProps }" var="catProp"> 
										<c:if test="${catProp.isSpecPicAttr }">	
										<h6><span class="red">*</span>${catProp.name }</h6>									
										
										<c:forEach items="${catProp.featureIdValues }"  var="feature"  varStatus="status">                                                            
										<label class="checkbox span2"> 	<input class="color" id="color_${status.index }" name="feature_${catProp.fid}[]" vid="${feature.vid }" value="${feature.value}" type="checkbox"> ${feature.value} </label>
										</c:forEach>
										<label class="checkbox span2 add_btn" data-info="color"><a href="javascript:;"><i class="icon-plus-sign"></i> 增加自定义项</a></label>	
																                    	
										 </c:if>
										 <c:if test="${!catProp.isSpecPicAttr&&catProp.isSpecAttr}">
										 <script type="text/javascript"> var size_fid = 450;</script>
										<div class="clearfix"></div>
										<h6><span class="red">*</span>${ catProp.name }</h6>
									   <c:forEach items="${catProp.featureIdValues }"  var="feature"  varStatus="status">
										<label class="checkbox span2"> <input vid="${feature.vid }" name="feature_${catProp.fid}[]" value="${feature.value}"   type="checkbox"> ${feature.value} </label>
										</c:forEach>
										<label class="checkbox span2 add_btn" data-info="size"><a href="javascript:;"><i class="icon-plus-sign"></i> 增加自定义项</a></label>																						
										 </c:if>
										 </c:forEach>									
									<!-- 尺寸 -->								
										 							                    	
										
																                    	
										 </div>
								</div>
							</div>
						
						
							
							<div id="match" class="control-group" style="display: block;">
								<label class="control-label">匹配图片</label>
								<div class="controls well">
									<ul class="thumbnails" id="match-box"><li class="thumbnail" data-toggle="modal"><img src="" class="slectedmatch" data-value="" rel="color_4"><h6></h6></li></ul>									
								</div>
							</div>

						</div>
					</div>
				</div>
				<!-- 属性等基本信息结束 -->

				<!-- 产品销售信息 -->
					<div class="accordion-group">
						<div class="accordion-heading">
							<span title="点击展开或收起" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#saleinfo">
								<i class="icon-shopping-cart"></i> <strong>产品销售信息</strong>							
							</span>			           
						</div>
						<div id="saleinfo" class="accordion-body collapse in">
							<div class="accordion-inner  form-horizontal">
							
							
								<div class="control-group">
									<label class="control-label">
									<span class="red"> * </span>${catProp.name }</label>
									<div class="controls well">
										<input class="span2" name="amountOnSale" value="9999" placeholder="请输入可销售数量" type="hidden"><span class="offerWeight"></span>
										<div class="alert alert-info">价格提示: 拿货价 ${goods.minPrice } 元</div>										
										<div class="numRanges">
											起订量<input class="span1" name="numRanges[0]" value="" placeholder="请输入起订量">&nbsp;&nbsp;
											价格<input class="span2" name="priceranges[0]" value="" placeholder="请输入价格,单位:元">
											<p></p>
										</div>
										<a href="javascript:;" id="addpriceRange"><i class="icon-plus-sign"></i> 增加区间</a> 
									</div>
								</div>
								
							</div>
						</div>
					</div>
				<!-- 产品销售信息结束 -->

				<!-- 图片和详细说明 -->
				<div class="accordion-group">
					<div class="accordion-heading">
						<span title="点击展开或收起" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
							<i class="icon-pencil"></i> <strong>图片和详细说明</strong>							
						</span>			           
					</div>
					<div id="collapseTwo" class="accordion-body collapse in">
						<div class="accordion-inner form-horizontal">
							<div class="control-group">
								<label class="control-label">产品图片</label>
								<div class="controls well">
									<div class="alert alert-info">第一张图为默认主图，建议图片尺寸在750*750像素以上，图片请避免全文字。</div>												
									<ul class="thumbnails" id="main-box">
											<li class="thumbnail mainimg-box" data-toggle="modal">
											<span class="img-null img-btn" data-src="main"></span>
										</li>
											<li class="thumbnail mainimg-box" data-toggle="modal">
											<span class="img-null img-btn" data-src="main"></span>
										</li>
											<li class="thumbnail mainimg-box" data-toggle="modal">
											<span class="img-null img-btn" data-src="main"></span>
										</li>
																				
									</ul>
								</div>

								<label class="control-label"><span class="red"> * </span>详细说明</label>
								<div class="controls well">
								<!-- 	<div style="width: 100%;" class="ke-container ke-container-default">
									</div> -->
									<textarea id="description" name="offerDetail" style="width: 100%; height: 500px; visibility: hidden; display: none;">
										${goods.description }
									</textarea>																																
								</div>
								
<!-- 								<label class="control-label">选择自定义分类</label>
								<div class="controls well">
									<div class="btn">选择分类… (可多选)</div>&#160;&#160;<a href="javascript:;" class="btn btn-mini"> 刷新 </a>
									<ul class="userCategorys" id="userCategorys">
													                    	</ul>
								</div> -->

								<label class="control-label"><span class="red"> * </span>信息有效期</label>
								<div class="controls well">
									<label class="radio inline"><input name="periodOfValidity" value="10" class="" type="radio"> 10天</label>			
									<label class="radio inline"><input name="periodOfValidity" value="20" class="" type="radio"> 20天</label>			
									<label class="radio inline"><input name="periodOfValidity" value="30" checked="checked" class="" type="radio"> 1个月</label>		
									<label class="radio inline"><input name="periodOfValidity" value="90" class="" type="radio"> 3个月</label>
									<label class="radio inline"><input name="periodOfValidity" value="180" class="" type="radio"> 6个月</label>		
								</div>
							</div>																										
						</div>
					</div>
				</div>
				<!-- 图片和详细说明结束 -->

				<!-- 物流运费信息 -->
				<div class="accordion-group">
					<div class="accordion-heading">
						<span title="点击展开或收起" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
							<i class="icon-plane"></i> <strong>物流运费信息</strong>							
						</span>			           
					</div>
					<div id="collapseThree" class="accordion-body collapse in">
						<div class="accordion-inner  form-horizontal">
							<div class="control-group">
								<label class="control-label">物流运费信息</label>
								<div class="controls well">

									<label>
									<span class="red"> * </span>
									发货地址
									<select class="span5" name="sendGoodsAddressId">                      
									<c:forEach items="${addrList }" var="addr">                
											<option value=${addr.deliveryAddressId } selected="selected">${addr.address }</option>
									</c:forEach>
									</select>
									
									<!-- <a href="javascript:;" class="btn btn-mini"> 刷新 </a></br> -->
									</label>

									<label>
									<span class="red"> * </span>
									运费设置
									<select id="used-freight" name="freightType" class="span2">
										<option value="T">使用运费模板</option>
										<!-- <option value="D">使用运费说明</option> -->
										<option value="F" selected="selected">卖家承担运费</option>
									</select>
									<span></span>
									</label>

									<script type="text/javascript">
										var templatelists = '<select name="freightTemplateId">';
										var templates = ${templates};
										for(var i=0;i<templates.length;i++){
											templatelists += '<option value='+templates[i].templateId+'>'+templates[i].templateName+' </option>';
										}
										templatelists += '</select>';
									</script>

									<!-- <label>单位重量
									<input  class="span2" type="text" value="1" name="offerweight" /> <span>公斤/销售单位</span>
									</label> -->
									<input value="1" name="offerweight" type="hidden">
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 物流运费信息结束 -->

			</div>
			<!-- 折叠结束 -->
			<div class="text-center" id="submitbox">
				<span> 点此阅读<a target="_blank" href="http://rule.1688.com/rule/detail/general.htm?tracelog=aliguize_backoffer0">阿里巴巴中国网站总则 </a></span>
				<br><br>
				<button type="submit" id="submit" class="btn btn-warning">同意协议条款，我要发布</button>					
			</div>
		</form>
	</div>
</div>

<div id="footerbox" class="container text-center"></div>


<!-- 弹出层 -->
<div id="modal">
	<!-- 发布提交弹出层 -->
	<div id="myModal" class="modal hide fade" >
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" >×</button>
			<h3>发布提示</h3>
		</div>
		<div class="modal-body">
			<p id="notice" style="min-height:300px;font-size:16px;"> 
				<img src="/images/ajax-loader.gif" /> 
				<strong>正在上传数据.... </strong>
			</p>
		</div>
	</div>

	<!-- 图片选择弹出层 -->
	<div id="img-box" class="modal  hide fade" >
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" >×</button>
			<h3 id="img-box-title">图片选择</h3>
		</div>
		<div class="modal-body tabbable"> 
		   	<ul class="nav nav-tabs">
		        <li class="active"><a href="#tab1" data-toggle="tab">产品图片</a></li>
		        <li><a href="#tab2" data-toggle="tab">相册图片</a></li>
		        <li><a href="#tab3" data-toggle="tab">本地上传</a></li>
		    </ul>

		    <div class="tab-content">
		    	<div class="tab-pane active" id="tab1">           
		    		<ul id="local-img-list" class="thumbnails imgContainer">		    			
		    		</ul>
		    	</div>
		    	<div class="tab-pane" id="tab2">
		    		<ul class="thumbnails albumimgContainer">
		    			                   
		    		</ul>            
		    	</div>
		    	<div class="tab-pane" id="tab3">
		    		<p style="text-align:center">	
		    			<ul class="thumbnails" id="descUploadImg"></ul>
		    			<p />
		    			<div id="descalert">仅支持 gif、jpg、png、bmp、jpeg 格式</div>
		    			<form action="/alibaba/file/upload?code=${code}" method="post" enctype="multipart/form-data" target="form-target">
		    				<input type="hidden" name="MAX_FILE_SIZE" value="1000000" />
		    				<input type="file" name="userfile" id="descfile"/>
		    				<input type="submit" name="submit" value="上传文件" onclick="loading()" />
		    			</form>
		    			<iframe style="width:0; height:0; border:0px;" name="form-target">
		    			</iframe>
		    		</p>
		    	</div>
		    </div>
		</div>
		<div class="modal-footer">
			<ul class="thumbnails" id="choosebox"></ul>
			<button id="insert" class="btn btn-danger btn-mini" data-dismiss="modal">插入图片</button>
		</div>
	</div>

	<!-- 错误弹出提示 -->
	<div id="alert" class="modal hide fade" >
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" >×</button>
			<h3>提示</h3>
		</div>
		<div class="modal-body">
			<p id="alert_mess" class="alert"></p>
		</div>
	</div>

</div>
<!-- 弹出层结束 -->


</body></html>