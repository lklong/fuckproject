if (typeof zhigu == "undefined" || !zhigu) {
	var zhigu = {};
}
// js 日志
zhigu.log = function (msg,obj) {
	if (window['console']){ 
		try {
			console.log.apply(console, arguments);
		} catch (e) {
			console.log(msg);
		}
	}
	return this
};
zhigu.cmn = {};
zhigu.code = {'success':1,'fail':0};
(function($){
//全局的ajax访问，处理ajax清求时sesion超时  
	$.ajaxSetup({
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		complete : function(XMLHttpRequest, textStatus) {
			// 通过XMLHttpRequest取得响应头，sessionstatus，
			var errorCode = XMLHttpRequest.getResponseHeader("errorCode");
			if (errorCode == "1") { // 前台未登陆
				gologin();
			}else if(errorCode=="2"){//后台未登陆
				alert('未登陆或登录超时，请登录！');
				window.top.location.href='/admin';
			}else if(errorCode=="3"){// 后台无权限
				alert("无权限进行该操作！");
			}
		},
		error : function(request, status, e) {
			//alert("error:"+status+e);
			zhigu.log("ajax错误:", status, e,request);
		}
	});
	//input 错误提示
	$.fn.errorMsg = function(msg){
		var $this = $(this),
			interval,
			isRed = 0,
			toggle = function(ele){
				if(isRed % 2 !== 0){
					ele.removeClass('error');
				}else{
					ele.addClass('error');
				}
				if(isRed === 4){
					clearInterval(interval);
				}
			};
		//$this.next('label').addClass("hide");
		if( $this.closest("p.inputs").length ){
			var $parent = $this.closest("p.inputs");
			if ($parent.next("p.labels").length) {
				var $label = $parent.next("p.labels");
				interval = setInterval(function(){
					if(isRed === 0){
						$label.html("<span class='red'>" + msg + "</span>");
					}
					toggle($this);
					isRed++;
				},100);
			};
		}
	};
	//input 一般提示
	$.fn.tipMsg = function(msg){
		var $this = $(this),
			tips,
			toggle = function(ele){
				if(isRed % 2 !== 0){
					ele.removeClass('error');
				}else{
					ele.addClass('error');
				}
			};
		if( $this.closest("p.inputs").length ){
			var $parent = $this.closest("p.inputs");
			if ($parent.next("p.labels").length) {
				var $label = $parent.next("p.labels");
			};
		}
		$('.input_tips').addClass('disnone');
		tips = $('[for="tips_' + $this.attr("id") + '"]');
		if(tips.length > 0){
			if ( tips.attr('data-direction') && tips.attr('data-direction') == 'top' ) {
				tips.removeClass('disnone').css({
					'top' : $this.offset().top - tips.outerHeight() + 1 + 'px',
					'left' : $this.offset().left + 'px',
					'width' : $this.outerWidth() - 20
				});
			}else{
				tips.removeClass('disnone').css({
					'top' : $this.offset().top + 'px',
					'left' : $this.offset().left + 280 + 'px'
				});
			}
		}
	};
	//input 验证正确
	$.fn.verified = function(){
		var $this = $(this);
		$this.addClass("verified").removeClass("error");
		if( $this.closest("p.inputs").length ){
			var $parent = $this.closest("p.inputs");
			if ($parent.next("p.labels").length) {
				var $label = $parent.next("p.labels");
				$label.text("");
			};
		}
	};
	//input 检查状态重置
	$.fn.checkReset = function(msg){
		var $this = $(this);
		$this.removeClass("verified").removeClass("error");
		if( $this.closest("p.inputs").length ){
			var $parent = $this.closest("p.inputs");
			if ($parent.next("p.labels").length) {
				var $label = $parent.next("p.labels");
				$label.text("");
			};
		}
	};
})(jQuery);
function gologin(){
	layer.confirm('未登陆或登录超时，请登录！',function(){
		window.location.href = "/login?backUrl="+window.location.href;
	});
}
//约束输入:obj:this
zhigu.cmn.restrictInputMoney = function(obj){
	var $obj = obj instanceof jQuery?obj:$(obj);
	var val = $obj.val();
	if(val){
		if(val.indexOf(".")>0){
			var vs = val.split(".");
			if(vs.length==1){
				//javascript:alert("abcabcabc".replace(new RegExp("a","gm"),"ad")) // 效率更高？
				val = vs[0].replace(/[^0-9]/g,'').substr(0,7)+".";
			}else{
				val = vs[0].replace(/[^0-9]/g,'').substr(0,7)+"."+vs[1].replace(/[^0-9]/g,'').substr(0,2);
			}
		}else{
			val = val.replace(/[^0-9]/g,'').substr(0,7);
		}
	}
	$(obj).val(val);
}
/**
 * 简单封装ajax请求
 * 
 * @param url
 *			请求地址
 * @param data
 *			传递参数，如果是form提交，则传递$("#form").serialize()
 * @param callback
 *			回调
 * @param dataType
 * @param async
 */
function ajaxSubmit(url, p_data, _callback, dataType, async) {
	async = async? async:false;
	dataType = dataType?dataType: "json" ;
//	if(url.indexOf('?')<0&&url.indexOf(".ajax")<0){
//		url+=".ajax";
//	}
	$.ajax({
		url : url,
		traditional:true,
		dataType : dataType,
		type : "post",
		data : p_data,
		cache : false,
		async : async,
		beforeSend : function() {
		},
		success : function(res_data) {
			_callback(res_data);
		}
	});
}
zhigu.cmn.ajax = function(options) {
	var defaults = {
			async: false,
			dataType: "json",
			type: "post",
			cache : false,
			traditional:true,
		};
	var params = $.extend({}, defaults, options || {}); 
//	if(params.url.indexOf('?')<0&&params.url.indexOf(".ajax")<0){
//		params.url+=".ajax";
//	}
	$.ajax(params);
}
function f5() {
	var href = window.location.href;
	if(href.indexOf("?")>0){
		window.location.href = href+"&"+new Date().getTime();
	}else{
		window.location.href = href+"?"+new Date().getTime();
	}
}
// 去空格
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
};
function isEmpty(v) {
	if (v == null || v == "")
		return true;
	return v.toString().trim() == "" ? true : false;
}
// input 输入限制，在onkeyup调用
function inputReplace(obj,reg,maxlen){
	if(!(obj instanceof jQuery)){
		obj = $(obj);
	}
	var val = obj.val();
	val = val.replace(reg,'');
	if(maxlen){
		val = val.substr(0,maxlen);
	}
	$(obj).val(val);
}
zhigu.verify = {
		phoneReg:phoneReg,
		numberReg:numberReg,
		emailReg:emailReg
}
// 手机号码验证
function phoneReg(phone) {
	var reg = /^((1[0-9]{1})+\d{9})$/;
	return reg.test(phone);
}
function numberReg(num) {
	var reg = new RegExp("^[0-9]{1,11}$");
	return reg.test(num);
}
function emailReg(email) {
	var reg = /^([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	return reg.test(email);
}
function passwordReg(pwd) {
	var reg = /^.*([0-9]+.*[a-zA-Z]+)|([a-zA-Z]+.*[0-9]+).*$/;
	var length = /^.{6,16}$/;
	return reg.test(pwd) && length.test(pwd);
}
zhigu.cmn.moneyReg = function(money) {
	var reg = /^[0-9]{1,9}(.[0-9]{1,2})?$/;
	return reg.test(money);
}
function lengthReg(str, len) {
	return str.trim().length == len;
}
// 发送验证码按钮倒计时
function send_captcha_waiting(obj) {
	$(obj).attr("disabled", "disabled");
	var delay = 60;
	var interval = window.setInterval(function() {
		if (delay == 0) {
			clearInterval(interval);
			$(obj).removeAttr("disabled");
			$(obj).val("发送验证码");
		} else {
			$(obj).val(delay-- + '秒');
		}

	}, 1000);
}
// 文件上传
function uploadFile(ftype, onComplate) {
	// 上传方法
	$.upload({
		// 上传地址
		url : '/user/file/upload',
		// 文件域名字
		fileName : 'file',
		// 其他表单数据
		params : {
			ftype : ftype
		},
		// 上传完成后, 返回json, text
		dataType : 'jsonp',
		// 上传之前回调,return true表示可继续上传
		onSend : function() {
			return true;
		},
		// 上传之后回调
		onComplate : function(data) {
			if (typeof (eval(onComplate)) == "function")
				onComplate(data);
		}
	});
}

$(function() {
	// 弹出框
	$.fn.popSeting = function(options) {
		var par = {
			type : 'show'// 显示与隐藏
		};
		var obj = $(this);
		var ops = $.extend(par, options);
		if (ops.type == "show") {
			maskHtml = $("<div class='mask'></div>");
			maskHtml.css('height', $(document).height());
			maskHtml.appendTo($('body'));
			obj.show();
			obj.css('left', ($(window).width() - obj.width()) / 2);
			obj.css('top', ($(window).height() - obj.height()) / 2 + $(document).scrollTop());
		} else if (ops.type == "hide") {
			obj.hide();
			$(".mask").remove();
		}

		obj.find("h1 .close").on("click", function() {
			obj.hide();
			$(".mask").remove();
		});

		$(window).resize(function() {
			obj.css('left', ($(window).width() - obj.width()) / 2);
			obj.css('top', ($(window).height() - obj.height()) / 2 + $(document).scrollTop());
		});
		$(window).scroll(function() {
			obj.css('left', ($(window).width() - obj.width()) / 2);
			obj.css('top', ($(window).height() - obj.height()) / 2 + $(document).scrollTop());
		});
	}
	/*
	$(document).on("keyup",".mustNumber",function(){
		var val = $(this).val();
		var after = val.replace(/[^0-9]/g,"");
		$(this).val(after);
	});*/
	
	$(".levelPoint").each(function() {
		var point = $(this).text();
		$(this).html(levelPointToHtml(point));
	})
});
// 进行等级转换：等级点转成HTML(img)
var levelPointToHtml = function(levelPoint) {
	if(isNaN(levelPoint))levelPoint=0;
	var html = "";
	if(levelPoint < 2500){
		for (var i = 0; i <= levelPoint; i += 500) {
			html += "<img src='img/xin.jpg' title='" + levelPoint + "'/>";
		}
	}else if(levelPoint < 12500){
		for (var i = 2500; i <= levelPoint; i += 2500) {
			html += "<img src='img/zuanshi.jpg' title='" + levelPoint + "'/>";
		}
	}else{
		for (var i = 12500; i <= levelPoint; i += 12500) {
			html += "<img src='img/huanguan.jpg' title='" + levelPoint + "'/>";
		}
	}
	return html;
}
//对Date的扩展，将 Date 转化为指定格式的String 
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")	  ==> 2006-7-2 8:9:4.18 
Date.prototype.format = function(fmt) { 
	var o = {
		"M+" : this.getMonth() + 1, // 月份
		"d+" : this.getDate(), // 日
		"h+" : this.getHours(), // 小时
		"m+" : this.getMinutes(), // 分
		"s+" : this.getSeconds(), // 秒
		"q+" : Math.floor((this.getMonth() + 3) / 3), // 季度
		"S" : this.getMilliseconds()
	// 毫秒
	};
	if(!fmt){
		fmt = "yyyy-MM-dd hh:mm:ss";
	}
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}

//收藏商品
function favoGoods(goodsId){
	ajaxSubmit("/user/favourite/addFavouriteGoods", {goodsID:goodsId}, function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.msg(msgBean.msg);
		}else{
			layer.alert(msgBean.msg);
		}
	});
}
//收藏店铺
function favoStore(storeId){
	ajaxSubmit("/user/favourite/addFavouriteStore", {storeID:storeId}, function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.msg(msgBean.msg, 1);
		}else{
			layer.alert(msgBean.msg);
		}
	});
}
// 提取form表单数据转换
zhigu.cmn.formToObj = function(jquerySelector){// jQuerySelect : jquery选择器
	var fields = $(jquerySelector).serializeArray();
	var jsonObj = {};
	for ( var i = 0; fields != null && i < fields.length; i++) {
		jsonObj[fields[i].name] = fields[i].value;
	}
	return jsonObj;
}
zhigu.cmn.formToUriParams = function(jquerySelector){
	var fields = $(jquerySelector).serializeArray();
	var uriParams = [];
	for ( var i = 0; fields != null && i < fields.length; i++) {
		if(fields[i].value){
			if(uriParams.length>0)uriParams.push('&');
			uriParams.push(fields[i].name,'=', fields[i].value);
		}
	}
	zhigu.log("zhigu.cmn.formToUriParams:",jquerySelector,uriParams,fields);
	return uriParams.join('');
}
// 将url中的参数转换成对象，无参数时取当前url
zhigu.cmn.urlParamsToObj = function(paramsStr){
	if(!paramsStr)return {};
	var paramsArray = (paramsStr || location.search).replace(/^\?/, '').split('&');
	var length = paramsArray.length;
	var obj = {};
	for ( var i = 0; i < length; i++) {
		var ps = paramsArray[i].split('=');
		if(ps[0])obj[ps[0]] = decodeURIComponent(ps[1] || '');
	}
	zhigu.log("zhigu.cmn.urlParamsToObj:",paramsStr,obj);
	return obj;
}
// 将表单转换为完整的带参数uri
zhigu.cmn.formToUrl = function(jquerySelector){
	var formUrl = $(jquerySelector).prop("action");
	zhigu.log("zhigu.cmn.formToUrl:",jquerySelector,formUrl);
	var params = zhigu.cmn.formToUriParams(jquerySelector);
	var index =formUrl.indexOf('?'); 
	if(index>0){
		return formUrl.substr(0,index)+'?'+params+'&'+formUrl.substr(index+1);
	}
	return formUrl+'?'+params;
}
zhigu.cmn.arith = function(arg1,method, arg2){
	switch(method)
	{
	case '+':
		return zhigu.cmn.arithAdd(arg1, arg2);
	case '-':
		return zhigu.cmn.arithSub(arg1, arg2);
	case '*':
		return zhigu.cmn.arithMul(arg1, arg2);
	case '/':
		return zhigu.cmn.arithDiv(arg1, arg2);
	default:
		zhigu.log("无效运算符");
	}
}
/**
 * 精确加法
 *
 * @param {String | Number} arg1
 * @param {String | Number} arg2
 *
 * @returns {number} arg1 + arg2
 */
zhigu.cmn.arithAdd = function add(arg1, arg2) {
	// 数字化
	var num1 = parseFloat(arg1);
	var num2 = parseFloat(arg2);
	var r1, r2, m;
	try {
		r1 = num1.toString().split(".")[1].length;
	} catch (e) {
		r1 = 0;
	}
	try {
		r2 = num2.toString().split(".")[1].length;
	} catch (e) {
		r2 = 0;
	}
	m = Math.pow(10, Math.max(r1, r2));
	return (num1 * m + num2 * m) / m;
};

/**
 * 精确减法
 *
 * @param {Number | String} arg1
 * @param {Number | String} arg2
 *
 * @returns {number} arg1 - arg2
 */
zhigu.cmn.arithSub = function sub(arg1, arg2) {
	// 数字化
	var num1 = parseFloat(arg1);
	var num2 = parseFloat(arg2);
	var r1, r2, m, n;
	try {
		r1 = num1.toString().split(".")[1].length;
	} catch (e) {
		r1 = 0;
	}
	try {
		r2 = num2.toString().split(".")[1].length;
	} catch (e) {
		r2 = 0;
	}
	m = Math.pow(10, Math.max(r1, r2));
	return ((num1 * m - num2 * m) / m);
};

/**
 * 精确乘法
 *
 * @param {Number | String} arg1
 * @param {Number | String} arg2
 * @returns {number} arg1 * arg2s
 */
zhigu.cmn.arithMul = function mul(arg1, arg2) {
	// 数字化
	var num1 = parseFloat(arg1);
	var num2 = parseFloat(arg2);
	var m = 0, s1 = num1.toString(), s2 = num2.toString();
	try {
		m += s1.split(".")[1].length;
	} catch (e) {
	}
	try {
		m += s2.split(".")[1].length;
	} catch (e) {
	}
	return Number(s1.replace(".", "")) * Number(s2.replace(".", ""))
			/ Math.pow(10, m);
};

/**
 * 精确除法
 *
 * @param {Number | String} arg1
 * @param {Number | String} arg2
 * @returns {number}
 */
zhigu.cmn.arithDiv = function div(arg1, arg2) {
	// 数字化
	var num1 = parseFloat(arg1);
	var num2 = parseFloat(arg2);
	var t1 = 0, t2 = 0, r1, r2;
	try {
		t1 = num1.toString().split(".")[1].length;
	} catch (e) {
	}
	try {
		t2 = num2.toString().split(".")[1].length;
	} catch (e) {
	}
	r1 = Number(num1.toString().replace(".", ""));
	r2 = Number(num2.toString().replace(".", ""));
	return (r1 / r2) * Math.pow(10, t2 - t1);
};
/**
 * 得到一个字符串的长度,显示的长度,一个汉字或日韩文长度为2,英文字符长度为1
 * @param s
 * @returns
 */
zhigu.cmn.realLength  = function(str) {
	if(!str)return 0;
	if(typeof(str) !="String")str=str+"";
	var l = str.length; 
	var realLength = 0; 
	for(i=0; i<l; i++) { 
		if ((str.charCodeAt(i) & 0xff00) != 0) { 
			realLength ++; 
		} 
		realLength ++; 
	}
	return realLength;
}
//=========================js page start==================================
var cmn_totalPage,cmn_pageSize,cmn_cpage,cmn_goToPageFuntion,cmn_showPageElement; 
zhigu.cmn.goToPage = function(pageNo){
	cmn_goToPageFuntion(pageNo);
}
zhigu.cmn.reloadPage = function(){
	zhigu.cmn.goToPage(cmn_cpage);
	if(cmn_cpage>cmn_totalPage){
		zhigu.cmn.goToPage(cmn_totalPage);
	}
}
zhigu.cmn.setPage = function(pageBean, goToPageFunction, pageContainerId) {
	var cmn_outstr = "";
	if (pageBean && goToPageFunction) {
		cmn_totalPage = pageBean.totalPage;
		cmn_pageSize = pageBean.pageSize;
		cmn_cpage = pageBean.pageNo;
		cmn_goToPageFuntion = goToPageFunction;
	}
	if (pageContainerId) {
		cmn_showPageElement = pageContainerId;
	}
	// 分页(此种分页的上下页是当前页码加减1)
	cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + 1 + ")'>首页</a> ";
	if(cmn_cpage>1){
		cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + (cmn_cpage-1) + ")'>上一页</a> ";
	}
	var cmn_showPageNo = cmn_cpage - 3>0?cmn_cpage - 3:1;
	var showNum = cmn_showPageNo+6;
	for ( ; cmn_showPageNo <= showNum; cmn_showPageNo++) {
		if (cmn_showPageNo != cmn_cpage) {
			cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + cmn_showPageNo + ")'>" + cmn_showPageNo + "</a>";
		} else {
			cmn_outstr = cmn_outstr + "<span class='currPageColor'>" + cmn_showPageNo + "</span>";//当前页码
		}
		if(cmn_showPageNo==cmn_totalPage){
			break;
		}
	}
	if(cmn_cpage<cmn_totalPage){
		cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" +  (cmn_cpage+1) + ")'> 下一页 </a>";
	}
	cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + cmn_totalPage + ")'>尾页</a>";
	// 此种分页的上下页是显示页组上下页
//	if (cmn_totalPage <= 10) { // 总页数小于十页
//		for (cmn_showPageNo = 1; cmn_showPageNo <= cmn_totalPage; cmn_showPageNo++) {
//			if (cmn_showPageNo != cmn_cpage) {
//				cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + cmn_showPageNo + ")'>" + cmn_showPageNo + "</a>";
//			} else {
//				cmn_outstr = cmn_outstr + "<span >" + cmn_showPageNo + "</span>";
//			}
//		}
//	}
//	if (cmn_totalPage > 10) { // 总页数大于十页
//		if (parseInt((cmn_cpage - 1) / 10) == 0) {
//			for (cmn_showPageNo = 1; cmn_showPageNo <= 10; cmn_showPageNo++) {
//				if (cmn_showPageNo != cmn_cpage) {
//					cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + cmn_showPageNo + ")'>" + cmn_showPageNo + "</a>";
//				} else {
//					cmn_outstr = cmn_outstr + "<span >" + cmn_showPageNo + "</span>";//当前页
//				}
//			}
//			cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + cmn_showPageNo + ")'> 下一页 </a>";
//		} else if (parseInt((cmn_cpage - 1) / 10) == parseInt(cmn_totalPage / 10)) {
//			cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + (parseInt((cmn_cpage - 1) / 10) * 10) + ")'>上一页</a>";
//			for (cmn_showPageNo = parseInt(cmn_totalPage / 10) * 10 + 1; cmn_showPageNo <= cmn_totalPage; cmn_showPageNo++) {
//				if (cmn_showPageNo != cmn_cpage) {
//					cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + cmn_showPageNo + ")'>" + cmn_showPageNo + "</a>";
//				} else {
//					cmn_outstr = cmn_outstr + "<span >" + cmn_showPageNo + "</span>";
//				}
//			}
//		} else {
//			cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + (parseInt((cmn_cpage - 1) / 10) * 10) + ")'>上一页</a>";
//			for (cmn_showPageNo = parseInt((cmn_cpage - 1) / 10) * 10 + 1; cmn_showPageNo <= parseInt((cmn_cpage - 1) / 10) * 10 + 10; cmn_showPageNo++) {
//				if (cmn_showPageNo != cmn_cpage) {
//					cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + cmn_showPageNo + ")'>" + cmn_showPageNo + "</a>";
//				} else {
//					cmn_outstr = cmn_outstr + "<span >" + cmn_showPageNo + "</span>";
//				}
//			}
//			cmn_outstr = cmn_outstr + "<a href='javascript:void(0)' onclick='zhigu.cmn.goToPage(" + cmn_showPageNo + ")'> 下一页 </a>";
//		}
//	}
	document.getElementById(cmn_showPageElement).innerHTML = "<div >" + cmn_outstr + " <span > 共" + cmn_totalPage + "页 总" + pageBean.totalRow + "条<\/span><\/div>";
} 
// =========================js page end==================================

// ========================base64 start================================
zhigu.encodeBase64 = function(input){// 转成base64
	var b = new Base64();  
	return b.encode(input);  
}
zhigu.decodeBase64 = function(input){//base64解码
	var b = new Base64();  
	return b.decode(input);  
}
// Base64 encode / decode
function Base64(){_keyStr="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";this.encode=function(input){var output="";var chr1,chr2,chr3,enc1,enc2,enc3,enc4;var i=0;input=_utf8_encode(input);while(i<input.length){chr1=input.charCodeAt(i++);chr2=input.charCodeAt(i++);chr3=input.charCodeAt(i++);enc1=chr1>>2;enc2=((chr1&3)<<4)|(chr2>>4);enc3=((chr2&15)<<2)|(chr3>>6);enc4=chr3&63;if(isNaN(chr2)){enc3=enc4=64}else{if(isNaN(chr3)){enc4=64}}output=output+_keyStr.charAt(enc1)+_keyStr.charAt(enc2)+_keyStr.charAt(enc3)+_keyStr.charAt(enc4)}return output};this.decode=function(input){var output="";var chr1,chr2,chr3;var enc1,enc2,enc3,enc4;var i=0;input=input.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(i<input.length){enc1=_keyStr.indexOf(input.charAt(i++));enc2=_keyStr.indexOf(input.charAt(i++));enc3=_keyStr.indexOf(input.charAt(i++));enc4=_keyStr.indexOf(input.charAt(i++));chr1=(enc1<<2)|(enc2>>4);chr2=((enc2&15)<<4)|(enc3>>2);chr3=((enc3&3)<<6)|enc4;output=output+String.fromCharCode(chr1);if(enc3!=64){output=output+String.fromCharCode(chr2)}if(enc4!=64){output=output+String.fromCharCode(chr3)}}output=_utf8_decode(output);return output};_utf8_encode=function(string){string=string.replace(/\r\n/g,"\n");var utftext="";for(var n=0;n<string.length;n++){var c=string.charCodeAt(n);if(c<128){utftext+=String.fromCharCode(c)}else{if((c>127)&&(c<2048)){utftext+=String.fromCharCode((c>>6)|192);utftext+=String.fromCharCode((c&63)|128)}else{utftext+=String.fromCharCode((c>>12)|224);utftext+=String.fromCharCode(((c>>6)&63)|128);utftext+=String.fromCharCode((c&63)|128)}}}return utftext};_utf8_decode=function(utftext){var string="";var i=0;var c=c1=c2=0;while(i<utftext.length){c=utftext.charCodeAt(i);if(c<128){string+=String.fromCharCode(c);i++}else{if((c>191)&&(c<224)){c2=utftext.charCodeAt(i+1);string+=String.fromCharCode(((c&31)<<6)|(c2&63));i+=2}else{c2=utftext.charCodeAt(i+1);c3=utftext.charCodeAt(i+2);string+=String.fromCharCode(((c&15)<<12)|((c2&63)<<6)|(c3&63));i+=3}}}return string}};
//========================base64 end================================

// ==========================js json start==============================
zhigu.objToJson = function(obj){
	var seen = [];
    var json = JSON.stringify(obj, function(key, val) {
       if (typeof val == "object") {
            if (seen.indexOf(val) >= 0) return '__cycle__' + (typeof val) + '[' + key + ']';
            seen.push(val)
        }
        return val;
    });
    return json;
	//return JSON.stringify(obj);
}
zhigu.jsonToObj = function(str){
	return JSON.parse(str);
}
//json2.js
if(typeof JSON!=="object"){JSON={}}(function(){function f(n){return n<10?"0"+n:n}if(typeof Date.prototype.toJSON!=="function"){Date.prototype.toJSON=function(){return isFinite(this.valueOf())?this.getUTCFullYear()+"-"+f(this.getUTCMonth()+1)+"-"+f(this.getUTCDate())+"T"+f(this.getUTCHours())+":"+f(this.getUTCMinutes())+":"+f(this.getUTCSeconds())+"Z":null};String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(){return this.valueOf()}}var cx,escapable,gap,indent,meta,rep;function quote(string){escapable.lastIndex=0;return escapable.test(string)?'"'+string.replace(escapable,function(a){var c=meta[a];return typeof c==="string"?c:"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+string+'"'}function str(key,holder){var i,k,v,length,mind=gap,partial,value=holder[key];if(value&&typeof value==="object"&&typeof value.toJSON==="function"){value=value.toJSON(key)}if(typeof rep==="function"){value=rep.call(holder,key,value)}switch(typeof value){case"string":return quote(value);case"number":return isFinite(value)?String(value):"null";case"boolean":case"null":return String(value);case"object":if(!value){return"null"}gap+=indent;partial=[];if(Object.prototype.toString.apply(value)==="[object Array]"){length=value.length;for(i=0;i<length;i+=1){partial[i]=str(i,value)||"null"}v=partial.length===0?"[]":gap?"[\n"+gap+partial.join(",\n"+gap)+"\n"+mind+"]":"["+partial.join(",")+"]";gap=mind;return v}if(rep&&typeof rep==="object"){length=rep.length;for(i=0;i<length;i+=1){if(typeof rep[i]==="string"){k=rep[i];v=str(k,value);if(v){partial.push(quote(k)+(gap?": ":":")+v)}}}}else{for(k in value){if(Object.prototype.hasOwnProperty.call(value,k)){v=str(k,value);if(v){partial.push(quote(k)+(gap?": ":":")+v)}}}}v=partial.length===0?"{}":gap?"{\n"+gap+partial.join(",\n"+gap)+"\n"+mind+"}":"{"+partial.join(",")+"}";gap=mind;return v}}if(typeof JSON.stringify!=="function"){escapable=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;meta={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"};JSON.stringify=function(value,replacer,space){var i;gap="";indent="";if(typeof space==="number"){for(i=0;i<space;i+=1){indent+=" "}}else{if(typeof space==="string"){indent=space}}rep=replacer;if(replacer&&typeof replacer!=="function"&&(typeof replacer!=="object"||typeof replacer.length!=="number")){throw new Error("JSON.stringify")}return str("",{"":value})}}if(typeof JSON.parse!=="function"){cx=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;JSON.parse=function(text,reviver){var j;function walk(holder,key){var k,v,value=holder[key];if(value&&typeof value==="object"){for(k in value){if(Object.prototype.hasOwnProperty.call(value,k)){v=walk(value,k);if(v!==undefined){value[k]=v}else{delete value[k]}}}}return reviver.call(holder,key,value)}text=String(text);cx.lastIndex=0;if(cx.test(text)){text=text.replace(cx,function(a){return"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})}if(/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,"]").replace(/(?:^|:|,)(?:\s*\[)+/g,""))){j=eval("("+text+")");return typeof reviver==="function"?walk({"":j},""):j}throw new SyntaxError("JSON.parse")}}}());
// ===========================js json end=============================
// ===========================js MD5 start===============================
zhigu.MD5=function(string){function RotateLeft(lValue,iShiftBits){return(lValue<<iShiftBits)|(lValue>>>(32-iShiftBits))}function AddUnsigned(lX,lY){var lX4,lY4,lX8,lY8,lResult;lX8=(lX&2147483648);lY8=(lY&2147483648);lX4=(lX&1073741824);lY4=(lY&1073741824);lResult=(lX&1073741823)+(lY&1073741823);if(lX4&lY4){return(lResult^2147483648^lX8^lY8)}if(lX4|lY4){if(lResult&1073741824){return(lResult^3221225472^lX8^lY8)}else{return(lResult^1073741824^lX8^lY8)}}else{return(lResult^lX8^lY8)}}function F(x,y,z){return(x&y)|((~x)&z)}function G(x,y,z){return(x&z)|(y&(~z))}function H(x,y,z){return(x^y^z)}function I(x,y,z){return(y^(x|(~z)))}function FF(a,b,c,d,x,s,ac){a=AddUnsigned(a,AddUnsigned(AddUnsigned(F(b,c,d),x),ac));return AddUnsigned(RotateLeft(a,s),b)}function GG(a,b,c,d,x,s,ac){a=AddUnsigned(a,AddUnsigned(AddUnsigned(G(b,c,d),x),ac));return AddUnsigned(RotateLeft(a,s),b)}function HH(a,b,c,d,x,s,ac){a=AddUnsigned(a,AddUnsigned(AddUnsigned(H(b,c,d),x),ac));return AddUnsigned(RotateLeft(a,s),b)}function II(a,b,c,d,x,s,ac){a=AddUnsigned(a,AddUnsigned(AddUnsigned(I(b,c,d),x),ac));return AddUnsigned(RotateLeft(a,s),b)}function ConvertToWordArray(string){var lWordCount;var lMessageLength=string.length;var lNumberOfWords_temp1=lMessageLength+8;var lNumberOfWords_temp2=(lNumberOfWords_temp1-(lNumberOfWords_temp1%64))/64;var lNumberOfWords=(lNumberOfWords_temp2+1)*16;var lWordArray=Array(lNumberOfWords-1);var lBytePosition=0;var lByteCount=0;while(lByteCount<lMessageLength){lWordCount=(lByteCount-(lByteCount%4))/4;lBytePosition=(lByteCount%4)*8;lWordArray[lWordCount]=(lWordArray[lWordCount]|(string.charCodeAt(lByteCount)<<lBytePosition));lByteCount++}lWordCount=(lByteCount-(lByteCount%4))/4;lBytePosition=(lByteCount%4)*8;lWordArray[lWordCount]=lWordArray[lWordCount]|(128<<lBytePosition);lWordArray[lNumberOfWords-2]=lMessageLength<<3;lWordArray[lNumberOfWords-1]=lMessageLength>>>29;return lWordArray}function WordToHex(lValue){var WordToHexValue="",WordToHexValue_temp="",lByte,lCount;for(lCount=0;lCount<=3;lCount++){lByte=(lValue>>>(lCount*8))&255;WordToHexValue_temp="0"+lByte.toString(16);WordToHexValue=WordToHexValue+WordToHexValue_temp.substr(WordToHexValue_temp.length-2,2)}return WordToHexValue}function Utf8Encode(string){string=string.replace(/\r\n/g,"\n");var utftext="";for(var n=0;n<string.length;n++){var c=string.charCodeAt(n);if(c<128){utftext+=String.fromCharCode(c)}else{if((c>127)&&(c<2048)){utftext+=String.fromCharCode((c>>6)|192);utftext+=String.fromCharCode((c&63)|128)}else{utftext+=String.fromCharCode((c>>12)|224);utftext+=String.fromCharCode(((c>>6)&63)|128);utftext+=String.fromCharCode((c&63)|128)}}}return utftext}var x=Array();var k,AA,BB,CC,DD,a,b,c,d;var S11=7,S12=12,S13=17,S14=22;var S21=5,S22=9,S23=14,S24=20;var S31=4,S32=11,S33=16,S34=23;var S41=6,S42=10,S43=15,S44=21;string=Utf8Encode(string);x=ConvertToWordArray(string);a=1732584193;b=4023233417;c=2562383102;d=271733878;for(k=0;k<x.length;k+=16){AA=a;BB=b;CC=c;DD=d;a=FF(a,b,c,d,x[k+0],S11,3614090360);d=FF(d,a,b,c,x[k+1],S12,3905402710);c=FF(c,d,a,b,x[k+2],S13,606105819);b=FF(b,c,d,a,x[k+3],S14,3250441966);a=FF(a,b,c,d,x[k+4],S11,4118548399);d=FF(d,a,b,c,x[k+5],S12,1200080426);c=FF(c,d,a,b,x[k+6],S13,2821735955);b=FF(b,c,d,a,x[k+7],S14,4249261313);a=FF(a,b,c,d,x[k+8],S11,1770035416);d=FF(d,a,b,c,x[k+9],S12,2336552879);c=FF(c,d,a,b,x[k+10],S13,4294925233);b=FF(b,c,d,a,x[k+11],S14,2304563134);a=FF(a,b,c,d,x[k+12],S11,1804603682);d=FF(d,a,b,c,x[k+13],S12,4254626195);c=FF(c,d,a,b,x[k+14],S13,2792965006);b=FF(b,c,d,a,x[k+15],S14,1236535329);a=GG(a,b,c,d,x[k+1],S21,4129170786);d=GG(d,a,b,c,x[k+6],S22,3225465664);c=GG(c,d,a,b,x[k+11],S23,643717713);b=GG(b,c,d,a,x[k+0],S24,3921069994);a=GG(a,b,c,d,x[k+5],S21,3593408605);d=GG(d,a,b,c,x[k+10],S22,38016083);c=GG(c,d,a,b,x[k+15],S23,3634488961);b=GG(b,c,d,a,x[k+4],S24,3889429448);a=GG(a,b,c,d,x[k+9],S21,568446438);d=GG(d,a,b,c,x[k+14],S22,3275163606);c=GG(c,d,a,b,x[k+3],S23,4107603335);b=GG(b,c,d,a,x[k+8],S24,1163531501);a=GG(a,b,c,d,x[k+13],S21,2850285829);d=GG(d,a,b,c,x[k+2],S22,4243563512);c=GG(c,d,a,b,x[k+7],S23,1735328473);b=GG(b,c,d,a,x[k+12],S24,2368359562);a=HH(a,b,c,d,x[k+5],S31,4294588738);d=HH(d,a,b,c,x[k+8],S32,2272392833);c=HH(c,d,a,b,x[k+11],S33,1839030562);b=HH(b,c,d,a,x[k+14],S34,4259657740);a=HH(a,b,c,d,x[k+1],S31,2763975236);d=HH(d,a,b,c,x[k+4],S32,1272893353);c=HH(c,d,a,b,x[k+7],S33,4139469664);b=HH(b,c,d,a,x[k+10],S34,3200236656);a=HH(a,b,c,d,x[k+13],S31,681279174);d=HH(d,a,b,c,x[k+0],S32,3936430074);c=HH(c,d,a,b,x[k+3],S33,3572445317);b=HH(b,c,d,a,x[k+6],S34,76029189);a=HH(a,b,c,d,x[k+9],S31,3654602809);d=HH(d,a,b,c,x[k+12],S32,3873151461);c=HH(c,d,a,b,x[k+15],S33,530742520);b=HH(b,c,d,a,x[k+2],S34,3299628645);a=II(a,b,c,d,x[k+0],S41,4096336452);d=II(d,a,b,c,x[k+7],S42,1126891415);c=II(c,d,a,b,x[k+14],S43,2878612391);b=II(b,c,d,a,x[k+5],S44,4237533241);a=II(a,b,c,d,x[k+12],S41,1700485571);d=II(d,a,b,c,x[k+3],S42,2399980690);c=II(c,d,a,b,x[k+10],S43,4293915773);b=II(b,c,d,a,x[k+1],S44,2240044497);
a=II(a,b,c,d,x[k+8],S41,1873313359);d=II(d,a,b,c,x[k+15],S42,4264355552);c=II(c,d,a,b,x[k+6],S43,2734768916);b=II(b,c,d,a,x[k+13],S44,1309151649);a=II(a,b,c,d,x[k+4],S41,4149444226);d=II(d,a,b,c,x[k+11],S42,3174756917);c=II(c,d,a,b,x[k+2],S43,718787259);b=II(b,c,d,a,x[k+9],S44,3951481745);a=AddUnsigned(a,AA);b=AddUnsigned(b,BB);c=AddUnsigned(c,CC);d=AddUnsigned(d,DD)}var temp=WordToHex(a)+WordToHex(b)+WordToHex(c)+WordToHex(d);return temp.toLowerCase()};
// ===========================js MD5 end===============================
